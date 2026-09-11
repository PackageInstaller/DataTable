using System.IO;

namespace System.Security.Cryptography;

internal sealed class TailStream : Stream
{
	private byte[] _Buffer;

	private int _BufferSize;

	private int _BufferIndex;

	private bool _BufferFull;

	public byte[] Buffer => (byte[])_Buffer.Clone();

	public override bool CanRead => false;

	public override bool CanSeek => false;

	public override bool CanWrite => _Buffer != null;

	public override long Length
	{
		get
		{
			throw new NotSupportedException(Environment.GetResourceString("Stream does not support seeking."));
		}
	}

	public override long Position
	{
		get
		{
			throw new NotSupportedException(Environment.GetResourceString("Stream does not support seeking."));
		}
		set
		{
			throw new NotSupportedException(Environment.GetResourceString("Stream does not support seeking."));
		}
	}

	public TailStream(int bufferSize)
	{
		_Buffer = new byte[bufferSize];
		_BufferSize = bufferSize;
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
				if (_Buffer != null)
				{
					Array.Clear(_Buffer, 0, _Buffer.Length);
				}
				_Buffer = null;
			}
		}
		finally
		{
			base.Dispose(disposing);
		}
	}

	public override void Flush()
	{
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		throw new NotSupportedException(Environment.GetResourceString("Stream does not support seeking."));
	}

	public override void SetLength(long value)
	{
		throw new NotSupportedException(Environment.GetResourceString("Stream does not support seeking."));
	}

	public override int Read(byte[] buffer, int offset, int count)
	{
		throw new NotSupportedException(Environment.GetResourceString("Stream does not support reading."));
	}

	public override void Write(byte[] buffer, int offset, int count)
	{
		if (_Buffer == null)
		{
			throw new ObjectDisposedException("TailStream");
		}
		if (count == 0)
		{
			return;
		}
		if (_BufferFull)
		{
			if (count > _BufferSize)
			{
				System.Buffer.InternalBlockCopy(buffer, offset + count - _BufferSize, _Buffer, 0, _BufferSize);
				return;
			}
			System.Buffer.InternalBlockCopy(_Buffer, _BufferSize - count, _Buffer, 0, _BufferSize - count);
			System.Buffer.InternalBlockCopy(buffer, offset, _Buffer, _BufferSize - count, count);
		}
		else if (count > _BufferSize)
		{
			System.Buffer.InternalBlockCopy(buffer, offset + count - _BufferSize, _Buffer, 0, _BufferSize);
			_BufferFull = true;
		}
		else if (count + _BufferIndex >= _BufferSize)
		{
			System.Buffer.InternalBlockCopy(_Buffer, _BufferIndex + count - _BufferSize, _Buffer, 0, _BufferSize - count);
			System.Buffer.InternalBlockCopy(buffer, offset, _Buffer, _BufferIndex, count);
			_BufferFull = true;
		}
		else
		{
			System.Buffer.InternalBlockCopy(buffer, offset, _Buffer, _BufferIndex, count);
			_BufferIndex += count;
		}
	}
}
