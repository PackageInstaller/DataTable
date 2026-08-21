using System.Buffers;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace System.Security.Cryptography;

public class CryptoStream : Stream, IDisposable
{
	private readonly Stream _stream;

	private readonly ICryptoTransform _transform;

	private readonly CryptoStreamMode _transformMode;

	private byte[] _inputBuffer;

	private int _inputBufferIndex;

	private int _inputBlockSize;

	private byte[] _outputBuffer;

	private int _outputBufferIndex;

	private int _outputBlockSize;

	private bool _canRead;

	private bool _canWrite;

	private bool _finalBlockTransformed;

	private SemaphoreSlim _lazyAsyncActiveSemaphore;

	private readonly bool _leaveOpen;

	public override bool CanRead => _canRead;

	public override bool CanSeek => false;

	public override bool CanWrite => _canWrite;

	public override long Length
	{
		get
		{
			throw new NotSupportedException("Stream does not support seeking.");
		}
	}

	public override long Position
	{
		get
		{
			throw new NotSupportedException("Stream does not support seeking.");
		}
		set
		{
			throw new NotSupportedException("Stream does not support seeking.");
		}
	}

	public bool HasFlushedFinalBlock => _finalBlockTransformed;

	private SemaphoreSlim AsyncActiveSemaphore => LazyInitializer.EnsureInitialized(ref _lazyAsyncActiveSemaphore, () => new SemaphoreSlim(1, 1));

	public CryptoStream(Stream stream, ICryptoTransform transform, CryptoStreamMode mode)
		: this(stream, transform, mode, leaveOpen: false)
	{
	}

	public CryptoStream(Stream stream, ICryptoTransform transform, CryptoStreamMode mode, bool leaveOpen)
	{
		_stream = stream;
		_transformMode = mode;
		_transform = transform;
		_leaveOpen = leaveOpen;
		switch (_transformMode)
		{
		case CryptoStreamMode.Read:
			if (!_stream.CanRead)
			{
				throw new ArgumentException(SR.Format("Stream was not readable.", "stream"));
			}
			_canRead = true;
			break;
		case CryptoStreamMode.Write:
			if (!_stream.CanWrite)
			{
				throw new ArgumentException(SR.Format("Stream was not writable.", "stream"));
			}
			_canWrite = true;
			break;
		default:
			throw new ArgumentException("Argument {0} should be larger than {1}.");
		}
		InitializeBuffer();
	}

	public void FlushFinalBlock()
	{
		if (_finalBlockTransformed)
		{
			throw new NotSupportedException("FlushFinalBlock() method was called twice on a CryptoStream. It can only be called once.");
		}
		byte[] array = _transform.TransformFinalBlock(_inputBuffer, 0, _inputBufferIndex);
		_finalBlockTransformed = true;
		if (_canWrite && _outputBufferIndex > 0)
		{
			_stream.Write(_outputBuffer, 0, _outputBufferIndex);
			_outputBufferIndex = 0;
		}
		if (_canWrite)
		{
			_stream.Write(array, 0, array.Length);
		}
		if (_stream is CryptoStream cryptoStream)
		{
			if (!cryptoStream.HasFlushedFinalBlock)
			{
				cryptoStream.FlushFinalBlock();
			}
		}
		else
		{
			_stream.Flush();
		}
		if (_inputBuffer != null)
		{
			Array.Clear(_inputBuffer, 0, _inputBuffer.Length);
		}
		if (_outputBuffer != null)
		{
			Array.Clear(_outputBuffer, 0, _outputBuffer.Length);
		}
	}

	public override void Flush()
	{
	}

	public override Task FlushAsync(CancellationToken cancellationToken)
	{
		if (GetType() != typeof(CryptoStream))
		{
			return base.FlushAsync(cancellationToken);
		}
		if (!cancellationToken.IsCancellationRequested)
		{
			return Task.CompletedTask;
		}
		return Task.FromCanceled(cancellationToken);
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		throw new NotSupportedException("Stream does not support seeking.");
	}

	public override void SetLength(long value)
	{
		throw new NotSupportedException("Stream does not support seeking.");
	}

	public override Task<int> ReadAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		CheckReadArguments(buffer, offset, count);
		return ReadAsyncInternal(buffer, offset, count, cancellationToken);
	}

	public override IAsyncResult BeginRead(byte[] buffer, int offset, int count, AsyncCallback callback, object state)
	{
		return TaskToApm.Begin(ReadAsync(buffer, offset, count, CancellationToken.None), callback, state);
	}

	public override int EndRead(IAsyncResult asyncResult)
	{
		return TaskToApm.End<int>(asyncResult);
	}

	private async Task<int> ReadAsyncInternal(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		SemaphoreSlim semaphore = AsyncActiveSemaphore;
		await semaphore.WaitAsync().ForceAsync();
		try
		{
			return await ReadAsyncCore(buffer, offset, count, cancellationToken, useAsync: true);
		}
		finally
		{
			semaphore.Release();
		}
	}

	public override int ReadByte()
	{
		if (_outputBufferIndex > 1)
		{
			byte result = _outputBuffer[0];
			Buffer.BlockCopy(_outputBuffer, 1, _outputBuffer, 0, _outputBufferIndex - 1);
			_outputBufferIndex--;
			return result;
		}
		return base.ReadByte();
	}

	public override void WriteByte(byte value)
	{
		if (_inputBufferIndex + 1 < _inputBlockSize)
		{
			_inputBuffer[_inputBufferIndex++] = value;
		}
		else
		{
			base.WriteByte(value);
		}
	}

	public override int Read(byte[] buffer, int offset, int count)
	{
		CheckReadArguments(buffer, offset, count);
		return ReadAsyncCore(buffer, offset, count, default(CancellationToken), useAsync: false).GetAwaiter().GetResult();
	}

	private void CheckReadArguments(byte[] buffer, int offset, int count)
	{
		if (!CanRead)
		{
			throw new NotSupportedException("Stream does not support reading.");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - offset < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
	}

	private async Task<int> ReadAsyncCore(byte[] buffer, int offset, int count, CancellationToken cancellationToken, bool useAsync)
	{
		int bytesToDeliver = count;
		int currentOutputIndex = offset;
		if (_outputBufferIndex != 0)
		{
			if (_outputBufferIndex > count)
			{
				Buffer.BlockCopy(_outputBuffer, 0, buffer, offset, count);
				Buffer.BlockCopy(_outputBuffer, count, _outputBuffer, 0, _outputBufferIndex - count);
				_outputBufferIndex -= count;
				int length = _outputBuffer.Length - _outputBufferIndex;
				CryptographicOperations.ZeroMemory(new Span<byte>(_outputBuffer, _outputBufferIndex, length));
				return count;
			}
			Buffer.BlockCopy(_outputBuffer, 0, buffer, offset, _outputBufferIndex);
			bytesToDeliver -= _outputBufferIndex;
			currentOutputIndex += _outputBufferIndex;
			int length2 = _outputBuffer.Length - _outputBufferIndex;
			CryptographicOperations.ZeroMemory(new Span<byte>(_outputBuffer, _outputBufferIndex, length2));
			_outputBufferIndex = 0;
		}
		if (_finalBlockTransformed)
		{
			return count - bytesToDeliver;
		}
		int num = bytesToDeliver / _outputBlockSize;
		if (num > 1 && _transform.CanTransformMultipleBlocks)
		{
			int numWholeBlocksInBytes = num * _inputBlockSize;
			byte[] tempInputBuffer = ArrayPool<byte>.Shared.Rent(numWholeBlocksInBytes);
			byte[] tempOutputBuffer = null;
			try
			{
				int num2 = ((!useAsync) ? _stream.Read(tempInputBuffer, _inputBufferIndex, numWholeBlocksInBytes - _inputBufferIndex) : (await _stream.ReadAsync(new Memory<byte>(tempInputBuffer, _inputBufferIndex, numWholeBlocksInBytes - _inputBufferIndex), cancellationToken)));
				int num3 = num2;
				int num4 = _inputBufferIndex + num3;
				if (num4 < _inputBlockSize)
				{
					Buffer.BlockCopy(tempInputBuffer, _inputBufferIndex, _inputBuffer, _inputBufferIndex, num3);
					_inputBufferIndex = num4;
				}
				else
				{
					Buffer.BlockCopy(_inputBuffer, 0, tempInputBuffer, 0, _inputBufferIndex);
					CryptographicOperations.ZeroMemory(new Span<byte>(_inputBuffer, 0, _inputBufferIndex));
					num3 += _inputBufferIndex;
					_inputBufferIndex = 0;
					int num5 = num3 / _inputBlockSize;
					int num6 = num5 * _inputBlockSize;
					int num7 = num3 - num6;
					if (num7 != 0)
					{
						_inputBufferIndex = num7;
						Buffer.BlockCopy(tempInputBuffer, num6, _inputBuffer, 0, num7);
					}
					tempOutputBuffer = ArrayPool<byte>.Shared.Rent(num5 * _outputBlockSize);
					int num8 = _transform.TransformBlock(tempInputBuffer, 0, num6, tempOutputBuffer, 0);
					Buffer.BlockCopy(tempOutputBuffer, 0, buffer, currentOutputIndex, num8);
					CryptographicOperations.ZeroMemory(new Span<byte>(tempOutputBuffer, 0, num8));
					ArrayPool<byte>.Shared.Return(tempOutputBuffer);
					tempOutputBuffer = null;
					bytesToDeliver -= num8;
					currentOutputIndex += num8;
				}
			}
			finally
			{
				if (tempOutputBuffer != null)
				{
					CryptographicOperations.ZeroMemory(tempOutputBuffer);
					ArrayPool<byte>.Shared.Return(tempOutputBuffer);
				}
				CryptographicOperations.ZeroMemory(new Span<byte>(tempInputBuffer, 0, numWholeBlocksInBytes));
				ArrayPool<byte>.Shared.Return(tempInputBuffer);
			}
		}
		while (bytesToDeliver > 0)
		{
			while (_inputBufferIndex < _inputBlockSize)
			{
				int num2 = ((!useAsync) ? _stream.Read(_inputBuffer, _inputBufferIndex, _inputBlockSize - _inputBufferIndex) : (await _stream.ReadAsync(new Memory<byte>(_inputBuffer, _inputBufferIndex, _inputBlockSize - _inputBufferIndex), cancellationToken)));
				int num3 = num2;
				if (num3 != 0)
				{
					_inputBufferIndex += num3;
					continue;
				}
				_outputBufferIndex = (_outputBuffer = _transform.TransformFinalBlock(_inputBuffer, 0, _inputBufferIndex)).Length;
				_finalBlockTransformed = true;
				if (bytesToDeliver < _outputBufferIndex)
				{
					Buffer.BlockCopy(_outputBuffer, 0, buffer, currentOutputIndex, bytesToDeliver);
					_outputBufferIndex -= bytesToDeliver;
					Buffer.BlockCopy(_outputBuffer, bytesToDeliver, _outputBuffer, 0, _outputBufferIndex);
					int length3 = _outputBuffer.Length - _outputBufferIndex;
					CryptographicOperations.ZeroMemory(new Span<byte>(_outputBuffer, _outputBufferIndex, length3));
					return count;
				}
				Buffer.BlockCopy(_outputBuffer, 0, buffer, currentOutputIndex, _outputBufferIndex);
				bytesToDeliver -= _outputBufferIndex;
				_outputBufferIndex = 0;
				CryptographicOperations.ZeroMemory(_outputBuffer);
				return count - bytesToDeliver;
			}
			int num8 = _transform.TransformBlock(_inputBuffer, 0, _inputBlockSize, _outputBuffer, 0);
			_inputBufferIndex = 0;
			if (bytesToDeliver >= num8)
			{
				Buffer.BlockCopy(_outputBuffer, 0, buffer, currentOutputIndex, num8);
				CryptographicOperations.ZeroMemory(new Span<byte>(_outputBuffer, 0, num8));
				currentOutputIndex += num8;
				bytesToDeliver -= num8;
				continue;
			}
			Buffer.BlockCopy(_outputBuffer, 0, buffer, currentOutputIndex, bytesToDeliver);
			_outputBufferIndex = num8 - bytesToDeliver;
			Buffer.BlockCopy(_outputBuffer, bytesToDeliver, _outputBuffer, 0, _outputBufferIndex);
			int length4 = _outputBuffer.Length - _outputBufferIndex;
			CryptographicOperations.ZeroMemory(new Span<byte>(_outputBuffer, _outputBufferIndex, length4));
			return count;
		}
		return count;
	}

	public override Task WriteAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		CheckWriteArguments(buffer, offset, count);
		return WriteAsyncInternal(buffer, offset, count, cancellationToken);
	}

	public override IAsyncResult BeginWrite(byte[] buffer, int offset, int count, AsyncCallback callback, object state)
	{
		return TaskToApm.Begin(WriteAsync(buffer, offset, count, CancellationToken.None), callback, state);
	}

	public override void EndWrite(IAsyncResult asyncResult)
	{
		TaskToApm.End(asyncResult);
	}

	private async Task WriteAsyncInternal(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		SemaphoreSlim semaphore = AsyncActiveSemaphore;
		await semaphore.WaitAsync().ForceAsync();
		try
		{
			await WriteAsyncCore(buffer, offset, count, cancellationToken, useAsync: true);
		}
		finally
		{
			semaphore.Release();
		}
	}

	public override void Write(byte[] buffer, int offset, int count)
	{
		CheckWriteArguments(buffer, offset, count);
		WriteAsyncCore(buffer, offset, count, default(CancellationToken), useAsync: false).GetAwaiter().GetResult();
	}

	private void CheckWriteArguments(byte[] buffer, int offset, int count)
	{
		if (!CanWrite)
		{
			throw new NotSupportedException("Stream does not support writing.");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - offset < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
	}

	private async Task WriteAsyncCore(byte[] buffer, int offset, int count, CancellationToken cancellationToken, bool useAsync)
	{
		int bytesToWrite = count;
		int currentInputIndex = offset;
		if (_inputBufferIndex > 0)
		{
			if (count < _inputBlockSize - _inputBufferIndex)
			{
				Buffer.BlockCopy(buffer, offset, _inputBuffer, _inputBufferIndex, count);
				_inputBufferIndex += count;
				return;
			}
			Buffer.BlockCopy(buffer, offset, _inputBuffer, _inputBufferIndex, _inputBlockSize - _inputBufferIndex);
			currentInputIndex += _inputBlockSize - _inputBufferIndex;
			bytesToWrite -= _inputBlockSize - _inputBufferIndex;
			_inputBufferIndex = _inputBlockSize;
		}
		if (_outputBufferIndex > 0)
		{
			if (useAsync)
			{
				await _stream.WriteAsync(new ReadOnlyMemory<byte>(_outputBuffer, 0, _outputBufferIndex), cancellationToken);
			}
			else
			{
				_stream.Write(_outputBuffer, 0, _outputBufferIndex);
			}
			_outputBufferIndex = 0;
		}
		if (_inputBufferIndex == _inputBlockSize)
		{
			int numOutputBytes = _transform.TransformBlock(_inputBuffer, 0, _inputBlockSize, _outputBuffer, 0);
			if (useAsync)
			{
				await _stream.WriteAsync(new ReadOnlyMemory<byte>(_outputBuffer, 0, numOutputBytes), cancellationToken);
			}
			else
			{
				_stream.Write(_outputBuffer, 0, numOutputBytes);
			}
			_inputBufferIndex = 0;
		}
		while (bytesToWrite > 0)
		{
			if (bytesToWrite >= _inputBlockSize)
			{
				int num = bytesToWrite / _inputBlockSize;
				if (_transform.CanTransformMultipleBlocks && num > 1)
				{
					int numWholeBlocksInBytes = num * _inputBlockSize;
					byte[] tempOutputBuffer = ArrayPool<byte>.Shared.Rent(num * _outputBlockSize);
					int numOutputBytes = 0;
					try
					{
						numOutputBytes = _transform.TransformBlock(buffer, currentInputIndex, numWholeBlocksInBytes, tempOutputBuffer, 0);
						if (useAsync)
						{
							await _stream.WriteAsync(new ReadOnlyMemory<byte>(tempOutputBuffer, 0, numOutputBytes), cancellationToken);
						}
						else
						{
							_stream.Write(tempOutputBuffer, 0, numOutputBytes);
						}
						currentInputIndex += numWholeBlocksInBytes;
						bytesToWrite -= numWholeBlocksInBytes;
					}
					finally
					{
						CryptographicOperations.ZeroMemory(new Span<byte>(tempOutputBuffer, 0, numOutputBytes));
						ArrayPool<byte>.Shared.Return(tempOutputBuffer);
					}
				}
				else
				{
					int numOutputBytes = _transform.TransformBlock(buffer, currentInputIndex, _inputBlockSize, _outputBuffer, 0);
					if (useAsync)
					{
						await _stream.WriteAsync(new ReadOnlyMemory<byte>(_outputBuffer, 0, numOutputBytes), cancellationToken);
					}
					else
					{
						_stream.Write(_outputBuffer, 0, numOutputBytes);
					}
					currentInputIndex += _inputBlockSize;
					bytesToWrite -= _inputBlockSize;
				}
				continue;
			}
			Buffer.BlockCopy(buffer, currentInputIndex, _inputBuffer, 0, bytesToWrite);
			_inputBufferIndex += bytesToWrite;
			break;
		}
	}

	public void Clear()
	{
		Close();
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (disposing)
			{
				if (!_finalBlockTransformed)
				{
					FlushFinalBlock();
				}
				if (!_leaveOpen)
				{
					_stream.Dispose();
				}
			}
		}
		finally
		{
			try
			{
				_finalBlockTransformed = true;
				if (_inputBuffer != null)
				{
					Array.Clear(_inputBuffer, 0, _inputBuffer.Length);
				}
				if (_outputBuffer != null)
				{
					Array.Clear(_outputBuffer, 0, _outputBuffer.Length);
				}
				_inputBuffer = null;
				_outputBuffer = null;
				_canRead = false;
				_canWrite = false;
			}
			finally
			{
				base.Dispose(disposing);
			}
		}
	}

	private void InitializeBuffer()
	{
		if (_transform != null)
		{
			_inputBlockSize = _transform.InputBlockSize;
			_inputBuffer = new byte[_inputBlockSize];
			_outputBlockSize = _transform.OutputBlockSize;
			_outputBuffer = new byte[_outputBlockSize];
		}
	}
}
