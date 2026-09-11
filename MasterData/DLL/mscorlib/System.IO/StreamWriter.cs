using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace System.IO;

[Serializable]
public class StreamWriter : TextWriter
{
	internal const int DefaultBufferSize = 1024;

	private const int DefaultFileStreamBufferSize = 4096;

	private const int MinBufferSize = 128;

	private const int DontCopyOnWriteLineThreshold = 512;

	public new static readonly StreamWriter Null = new StreamWriter(Stream.Null, UTF8NoBOM, 128, leaveOpen: true);

	private Stream _stream;

	private Encoding _encoding;

	private Encoder _encoder;

	private byte[] _byteBuffer;

	private char[] _charBuffer;

	private int _charPos;

	private int _charLen;

	private bool _autoFlush;

	private bool _haveWrittenPreamble;

	private bool _closable;

	private Task _asyncWriteTask = Task.CompletedTask;

	private static Encoding UTF8NoBOM => EncodingHelper.UTF8Unmarked;

	public virtual bool AutoFlush
	{
		get
		{
			return _autoFlush;
		}
		set
		{
			CheckAsyncTaskInProgress();
			_autoFlush = value;
			if (value)
			{
				Flush(flushStream: true, flushEncoder: false);
			}
		}
	}

	public virtual Stream BaseStream => _stream;

	internal bool LeaveOpen => !_closable;

	internal bool HaveWrittenPreamble
	{
		set
		{
			_haveWrittenPreamble = value;
		}
	}

	public override Encoding Encoding => _encoding;

	private int CharPos_Prop
	{
		set
		{
			_charPos = value;
		}
	}

	private bool HaveWrittenPreamble_Prop
	{
		set
		{
			_haveWrittenPreamble = value;
		}
	}

	private void CheckAsyncTaskInProgress()
	{
		if (!_asyncWriteTask.IsCompleted)
		{
			ThrowAsyncIOInProgress();
		}
	}

	private static void ThrowAsyncIOInProgress()
	{
		throw new InvalidOperationException("The stream is currently in use by a previous operation on the stream.");
	}

	internal StreamWriter()
		: base(null)
	{
	}

	public StreamWriter(Stream stream)
		: this(stream, UTF8NoBOM, 1024, leaveOpen: false)
	{
	}

	public StreamWriter(Stream stream, Encoding encoding)
		: this(stream, encoding, 1024, leaveOpen: false)
	{
	}

	public StreamWriter(Stream stream, Encoding encoding, int bufferSize)
		: this(stream, encoding, bufferSize, leaveOpen: false)
	{
	}

	public StreamWriter(Stream stream, Encoding encoding, int bufferSize, bool leaveOpen)
		: base(null)
	{
		if (stream == null || encoding == null)
		{
			throw new ArgumentNullException((stream == null) ? "stream" : "encoding");
		}
		if (!stream.CanWrite)
		{
			throw new ArgumentException("Stream was not writable.");
		}
		if (bufferSize <= 0)
		{
			throw new ArgumentOutOfRangeException("bufferSize", "Positive number required.");
		}
		Init(stream, encoding, bufferSize, leaveOpen);
	}

	public StreamWriter(string path)
		: this(path, append: false, UTF8NoBOM, 1024)
	{
	}

	public StreamWriter(string path, bool append)
		: this(path, append, UTF8NoBOM, 1024)
	{
	}

	public StreamWriter(string path, bool append, Encoding encoding)
		: this(path, append, encoding, 1024)
	{
	}

	public StreamWriter(string path, bool append, Encoding encoding, int bufferSize)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.");
		}
		if (bufferSize <= 0)
		{
			throw new ArgumentOutOfRangeException("bufferSize", "Positive number required.");
		}
		Init(new FileStream(path, append ? FileMode.Append : FileMode.Create, FileAccess.Write, FileShare.Read, 4096, FileOptions.SequentialScan), encoding, bufferSize, shouldLeaveOpen: false);
	}

	private void Init(Stream streamArg, Encoding encodingArg, int bufferSize, bool shouldLeaveOpen)
	{
		_stream = streamArg;
		_encoding = encodingArg;
		_encoder = _encoding.GetEncoder();
		if (bufferSize < 128)
		{
			bufferSize = 128;
		}
		_charBuffer = new char[bufferSize];
		_byteBuffer = new byte[_encoding.GetMaxByteCount(bufferSize)];
		_charLen = bufferSize;
		if (_stream.CanSeek && _stream.Position > 0)
		{
			_haveWrittenPreamble = true;
		}
		_closable = !shouldLeaveOpen;
	}

	public override void Close()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (_stream != null && disposing)
			{
				CheckAsyncTaskInProgress();
				Flush(flushStream: true, flushEncoder: true);
			}
		}
		finally
		{
			if (!LeaveOpen && _stream != null)
			{
				try
				{
					if (disposing)
					{
						_stream.Close();
					}
				}
				finally
				{
					_stream = null;
					_byteBuffer = null;
					_charBuffer = null;
					_encoding = null;
					_encoder = null;
					_charLen = 0;
					base.Dispose(disposing);
				}
			}
		}
	}

	public override ValueTask DisposeAsync()
	{
		if (!(GetType() != typeof(StreamWriter)))
		{
			return DisposeAsyncCore();
		}
		return base.DisposeAsync();
	}

	private async ValueTask DisposeAsyncCore()
	{
		try
		{
			if (_stream != null)
			{
				await FlushAsync().ConfigureAwait(continueOnCapturedContext: false);
			}
		}
		finally
		{
			CloseStreamFromDispose(disposing: true);
		}
		GC.SuppressFinalize(this);
	}

	private void CloseStreamFromDispose(bool disposing)
	{
		if (LeaveOpen || _stream == null)
		{
			return;
		}
		try
		{
			if (disposing)
			{
				_stream.Close();
			}
		}
		finally
		{
			_stream = null;
			_byteBuffer = null;
			_charBuffer = null;
			_encoding = null;
			_encoder = null;
			_charLen = 0;
			base.Dispose(disposing);
		}
	}

	public override void Flush()
	{
		CheckAsyncTaskInProgress();
		Flush(flushStream: true, flushEncoder: true);
	}

	private void Flush(bool flushStream, bool flushEncoder)
	{
		if (_stream == null)
		{
			throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
		}
		if (_charPos == 0 && !flushStream && !flushEncoder)
		{
			return;
		}
		if (!_haveWrittenPreamble)
		{
			_haveWrittenPreamble = true;
			ReadOnlySpan<byte> preamble = _encoding.Preamble;
			if (preamble.Length > 0)
			{
				_stream.Write(preamble);
			}
		}
		int bytes = _encoder.GetBytes(_charBuffer, 0, _charPos, _byteBuffer, 0, flushEncoder);
		_charPos = 0;
		if (bytes > 0)
		{
			_stream.Write(_byteBuffer, 0, bytes);
		}
		if (flushStream)
		{
			_stream.Flush();
		}
	}

	public override void Write(char value)
	{
		CheckAsyncTaskInProgress();
		if (_charPos == _charLen)
		{
			Flush(flushStream: false, flushEncoder: false);
		}
		_charBuffer[_charPos] = value;
		_charPos++;
		if (_autoFlush)
		{
			Flush(flushStream: true, flushEncoder: false);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	public override void Write(char[] buffer)
	{
		WriteSpan(buffer, appendNewLine: false);
	}

	[MethodImpl((MethodImplOptions)8)]
	public override void Write(char[] buffer, int index, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		WriteSpan(buffer.AsSpan(index, count), appendNewLine: false);
	}

	[MethodImpl((MethodImplOptions)8)]
	public override void Write(ReadOnlySpan<char> buffer)
	{
		if (GetType() == typeof(StreamWriter))
		{
			WriteSpan(buffer, appendNewLine: false);
		}
		else
		{
			base.Write(buffer);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe void WriteSpan(ReadOnlySpan<char> buffer, bool appendNewLine)
	{
		CheckAsyncTaskInProgress();
		if (buffer.Length <= 4 && buffer.Length <= _charLen - _charPos)
		{
			for (int i = 0; i < buffer.Length; i++)
			{
				_charBuffer[_charPos++] = buffer[i];
			}
		}
		else
		{
			char[] charBuffer = _charBuffer;
			if (charBuffer == null)
			{
				throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
			}
			fixed (char* reference = &MemoryMarshal.GetReference(buffer))
			{
				fixed (char* ptr = &charBuffer[0])
				{
					char* ptr2 = reference;
					int num = buffer.Length;
					int num2 = _charPos;
					while (num > 0)
					{
						if (num2 == charBuffer.Length)
						{
							Flush(flushStream: false, flushEncoder: false);
							num2 = 0;
						}
						int num3 = Math.Min(charBuffer.Length - num2, num);
						int num4 = num3 * 2;
						Buffer.MemoryCopy(ptr2, ptr + num2, num4, num4);
						_charPos += num3;
						num2 += num3;
						ptr2 += num3;
						num -= num3;
					}
				}
			}
		}
		if (appendNewLine)
		{
			char[] coreNewLine = CoreNewLine;
			for (int j = 0; j < coreNewLine.Length; j++)
			{
				if (_charPos == _charLen)
				{
					Flush(flushStream: false, flushEncoder: false);
				}
				_charBuffer[_charPos] = coreNewLine[j];
				_charPos++;
			}
		}
		if (_autoFlush)
		{
			Flush(flushStream: true, flushEncoder: false);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	public override void Write(string value)
	{
		WriteSpan(value, appendNewLine: false);
	}

	[MethodImpl((MethodImplOptions)8)]
	public override void WriteLine(string value)
	{
		CheckAsyncTaskInProgress();
		WriteSpan(value, appendNewLine: true);
	}

	[MethodImpl((MethodImplOptions)8)]
	public override void WriteLine(ReadOnlySpan<char> value)
	{
		if (GetType() == typeof(StreamWriter))
		{
			CheckAsyncTaskInProgress();
			WriteSpan(value, appendNewLine: true);
		}
		else
		{
			base.WriteLine(value);
		}
	}

	public override Task WriteAsync(char value)
	{
		if (GetType() != typeof(StreamWriter))
		{
			return base.WriteAsync(value);
		}
		if (_stream == null)
		{
			throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
		}
		CheckAsyncTaskInProgress();
		return _asyncWriteTask = WriteAsyncInternal(this, value, _charBuffer, _charPos, _charLen, CoreNewLine, _autoFlush, appendNewLine: false);
	}

	private static async Task WriteAsyncInternal(StreamWriter _this, char value, char[] charBuffer, int charPos, int charLen, char[] coreNewLine, bool autoFlush, bool appendNewLine)
	{
		if (charPos == charLen)
		{
			await _this.FlushAsyncInternal(flushStream: false, flushEncoder: false, charBuffer, charPos).ConfigureAwait(continueOnCapturedContext: false);
			charPos = 0;
		}
		charBuffer[charPos] = value;
		charPos++;
		if (appendNewLine)
		{
			for (int i = 0; i < coreNewLine.Length; i++)
			{
				if (charPos == charLen)
				{
					await _this.FlushAsyncInternal(flushStream: false, flushEncoder: false, charBuffer, charPos).ConfigureAwait(continueOnCapturedContext: false);
					charPos = 0;
				}
				charBuffer[charPos] = coreNewLine[i];
				charPos++;
			}
		}
		if (autoFlush)
		{
			await _this.FlushAsyncInternal(flushStream: true, flushEncoder: false, charBuffer, charPos).ConfigureAwait(continueOnCapturedContext: false);
			charPos = 0;
		}
		_this.CharPos_Prop = charPos;
	}

	public override Task WriteAsync(string value)
	{
		if (GetType() != typeof(StreamWriter))
		{
			return base.WriteAsync(value);
		}
		if (value != null)
		{
			if (_stream == null)
			{
				throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
			}
			CheckAsyncTaskInProgress();
			return _asyncWriteTask = WriteAsyncInternal(this, value, _charBuffer, _charPos, _charLen, CoreNewLine, _autoFlush, appendNewLine: false);
		}
		return Task.CompletedTask;
	}

	private static async Task WriteAsyncInternal(StreamWriter _this, string value, char[] charBuffer, int charPos, int charLen, char[] coreNewLine, bool autoFlush, bool appendNewLine)
	{
		int count = value.Length;
		int index = 0;
		while (count > 0)
		{
			if (charPos == charLen)
			{
				await _this.FlushAsyncInternal(flushStream: false, flushEncoder: false, charBuffer, charPos).ConfigureAwait(continueOnCapturedContext: false);
				charPos = 0;
			}
			int num = charLen - charPos;
			if (num > count)
			{
				num = count;
			}
			value.CopyTo(index, charBuffer, charPos, num);
			charPos += num;
			index += num;
			count -= num;
		}
		if (appendNewLine)
		{
			for (int i = 0; i < coreNewLine.Length; i++)
			{
				if (charPos == charLen)
				{
					await _this.FlushAsyncInternal(flushStream: false, flushEncoder: false, charBuffer, charPos).ConfigureAwait(continueOnCapturedContext: false);
					charPos = 0;
				}
				charBuffer[charPos] = coreNewLine[i];
				charPos++;
			}
		}
		if (autoFlush)
		{
			await _this.FlushAsyncInternal(flushStream: true, flushEncoder: false, charBuffer, charPos).ConfigureAwait(continueOnCapturedContext: false);
			charPos = 0;
		}
		_this.CharPos_Prop = charPos;
	}

	public override Task WriteAsync(char[] buffer, int index, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (GetType() != typeof(StreamWriter))
		{
			return base.WriteAsync(buffer, index, count);
		}
		if (_stream == null)
		{
			throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
		}
		CheckAsyncTaskInProgress();
		return _asyncWriteTask = WriteAsyncInternal(this, new ReadOnlyMemory<char>(buffer, index, count), _charBuffer, _charPos, _charLen, CoreNewLine, _autoFlush, appendNewLine: false, default(CancellationToken));
	}

	public override Task WriteAsync(ReadOnlyMemory<char> buffer, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (GetType() != typeof(StreamWriter))
		{
			return base.WriteAsync(buffer, cancellationToken);
		}
		if (_stream == null)
		{
			throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
		}
		CheckAsyncTaskInProgress();
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled(cancellationToken);
		}
		return _asyncWriteTask = WriteAsyncInternal(this, buffer, _charBuffer, _charPos, _charLen, CoreNewLine, _autoFlush, appendNewLine: false, cancellationToken);
	}

	private static async Task WriteAsyncInternal(StreamWriter _this, ReadOnlyMemory<char> source, char[] charBuffer, int charPos, int charLen, char[] coreNewLine, bool autoFlush, bool appendNewLine, CancellationToken cancellationToken)
	{
		int num;
		for (int copied = 0; copied < source.Length; copied += num)
		{
			if (charPos == charLen)
			{
				await _this.FlushAsyncInternal(flushStream: false, flushEncoder: false, charBuffer, charPos, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				charPos = 0;
			}
			num = Math.Min(charLen - charPos, source.Length - copied);
			ReadOnlySpan<char> readOnlySpan = source.Span;
			readOnlySpan = readOnlySpan.Slice(copied, num);
			readOnlySpan.CopyTo(new Span<char>(charBuffer, charPos, num));
			charPos += num;
		}
		if (appendNewLine)
		{
			for (int i = 0; i < coreNewLine.Length; i++)
			{
				if (charPos == charLen)
				{
					await _this.FlushAsyncInternal(flushStream: false, flushEncoder: false, charBuffer, charPos, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
					charPos = 0;
				}
				charBuffer[charPos] = coreNewLine[i];
				charPos++;
			}
		}
		if (autoFlush)
		{
			await _this.FlushAsyncInternal(flushStream: true, flushEncoder: false, charBuffer, charPos, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			charPos = 0;
		}
		_this.CharPos_Prop = charPos;
	}

	public override Task WriteLineAsync()
	{
		if (GetType() != typeof(StreamWriter))
		{
			return base.WriteLineAsync();
		}
		if (_stream == null)
		{
			throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
		}
		CheckAsyncTaskInProgress();
		return _asyncWriteTask = WriteAsyncInternal(this, ReadOnlyMemory<char>.Empty, _charBuffer, _charPos, _charLen, CoreNewLine, _autoFlush, appendNewLine: true, default(CancellationToken));
	}

	public override Task WriteLineAsync(char value)
	{
		if (GetType() != typeof(StreamWriter))
		{
			return base.WriteLineAsync(value);
		}
		if (_stream == null)
		{
			throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
		}
		CheckAsyncTaskInProgress();
		return _asyncWriteTask = WriteAsyncInternal(this, value, _charBuffer, _charPos, _charLen, CoreNewLine, _autoFlush, appendNewLine: true);
	}

	public override Task WriteLineAsync(string value)
	{
		if (value == null)
		{
			return WriteLineAsync();
		}
		if (GetType() != typeof(StreamWriter))
		{
			return base.WriteLineAsync(value);
		}
		if (_stream == null)
		{
			throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
		}
		CheckAsyncTaskInProgress();
		return _asyncWriteTask = WriteAsyncInternal(this, value, _charBuffer, _charPos, _charLen, CoreNewLine, _autoFlush, appendNewLine: true);
	}

	public override Task WriteLineAsync(char[] buffer, int index, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (GetType() != typeof(StreamWriter))
		{
			return base.WriteLineAsync(buffer, index, count);
		}
		if (_stream == null)
		{
			throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
		}
		CheckAsyncTaskInProgress();
		return _asyncWriteTask = WriteAsyncInternal(this, new ReadOnlyMemory<char>(buffer, index, count), _charBuffer, _charPos, _charLen, CoreNewLine, _autoFlush, appendNewLine: true, default(CancellationToken));
	}

	public override Task WriteLineAsync(ReadOnlyMemory<char> buffer, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (GetType() != typeof(StreamWriter))
		{
			return base.WriteLineAsync(buffer, cancellationToken);
		}
		if (_stream == null)
		{
			throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
		}
		CheckAsyncTaskInProgress();
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled(cancellationToken);
		}
		return _asyncWriteTask = WriteAsyncInternal(this, buffer, _charBuffer, _charPos, _charLen, CoreNewLine, _autoFlush, appendNewLine: true, cancellationToken);
	}

	public override Task FlushAsync()
	{
		if (GetType() != typeof(StreamWriter))
		{
			return base.FlushAsync();
		}
		if (_stream == null)
		{
			throw new ObjectDisposedException(null, "Can not write to a closed TextWriter.");
		}
		CheckAsyncTaskInProgress();
		return _asyncWriteTask = FlushAsyncInternal(flushStream: true, flushEncoder: true, _charBuffer, _charPos);
	}

	private Task FlushAsyncInternal(bool flushStream, bool flushEncoder, char[] sCharBuffer, int sCharPos, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled(cancellationToken);
		}
		if (sCharPos == 0 && !flushStream && !flushEncoder)
		{
			return Task.CompletedTask;
		}
		Task result = FlushAsyncInternal(this, flushStream, flushEncoder, sCharBuffer, sCharPos, _haveWrittenPreamble, _encoding, _encoder, _byteBuffer, _stream, cancellationToken);
		_charPos = 0;
		return result;
	}

	private static async Task FlushAsyncInternal(StreamWriter _this, bool flushStream, bool flushEncoder, char[] charBuffer, int charPos, bool haveWrittenPreamble, Encoding encoding, Encoder encoder, byte[] byteBuffer, Stream stream, CancellationToken cancellationToken)
	{
		if (!haveWrittenPreamble)
		{
			_this.HaveWrittenPreamble_Prop = true;
			byte[] preamble = encoding.GetPreamble();
			if (preamble.Length != 0)
			{
				await stream.WriteAsync(new ReadOnlyMemory<byte>(preamble), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			}
		}
		int bytes = encoder.GetBytes(charBuffer, 0, charPos, byteBuffer, 0, flushEncoder);
		if (bytes > 0)
		{
			await stream.WriteAsync(new ReadOnlyMemory<byte>(byteBuffer, 0, bytes), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		}
		if (flushStream)
		{
			await stream.FlushAsync(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		}
	}
}
