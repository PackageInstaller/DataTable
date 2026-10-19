using System;
using System.IO;

namespace Google.Protobuf;

internal sealed class LimitedInputStream : Stream
{
	private readonly Stream proxied;

	private int bytesLeft;

	public override bool CanRead => true;

	public override bool CanSeek => false;

	public override bool CanWrite => false;

	public override long Length
	{
		get
		{
			throw new NotSupportedException();
		}
	}

	public override long Position
	{
		get
		{
			throw new NotSupportedException();
		}
		set
		{
			throw new NotSupportedException();
		}
	}

	internal LimitedInputStream(Stream proxied, int size)
	{
		this.proxied = proxied;
		bytesLeft = size;
	}

	public override void Flush()
	{
	}

	public override int Read(byte[] buffer, int offset, int count)
	{
		if (bytesLeft > 0)
		{
			int num = proxied.Read(buffer, offset, Math.Min(bytesLeft, count));
			bytesLeft -= num;
			return num;
		}
		return 0;
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		throw new NotSupportedException();
	}

	public override void SetLength(long value)
	{
		throw new NotSupportedException();
	}

	public override void Write(byte[] buffer, int offset, int count)
	{
		throw new NotSupportedException();
	}
}
