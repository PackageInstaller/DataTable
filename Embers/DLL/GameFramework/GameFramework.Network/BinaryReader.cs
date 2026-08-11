using System;
using System.IO;
using System.Threading.Tasks;

namespace GameFramework.Network;

public class BinaryReader : IDisposable
{
	private const int DEFAULT_BUFFER_SIZE = 4192;

	private Stream input;

	private bool leaveOpen;

	private bool isBigEndian;

	private byte[] buffer;

	private bool disposedValue = false;

	public virtual Stream BaseStream => input;

	public virtual bool IsBigEndian
	{
		get
		{
			return isBigEndian;
		}
		set
		{
			isBigEndian = value;
		}
	}

	public BinaryReader(Stream input, bool leaveOpen)
		: this(input, leaveOpen, isBigEndian: true)
	{
	}

	public BinaryReader(Stream input, bool leaveOpen, bool isBigEndian)
	{
		this.input = input;
		this.leaveOpen = leaveOpen;
		this.isBigEndian = isBigEndian;
		buffer = new byte[4192];
	}

	public virtual async Task<byte> ReadByte()
	{
		await Read(buffer, 0, 1).ConfigureAwait(continueOnCapturedContext: false);
		return buffer[0];
	}

	public virtual async Task<ushort> ReadUInt16()
	{
		await Read(buffer, 0, 2).ConfigureAwait(continueOnCapturedContext: false);
		if (isBigEndian)
		{
			return (ushort)(buffer[1] | (buffer[0] << 8));
		}
		return (ushort)(buffer[0] | (buffer[1] << 8));
	}

	public virtual async Task<short> ReadInt16()
	{
		await Read(buffer, 0, 2).ConfigureAwait(continueOnCapturedContext: false);
		if (isBigEndian)
		{
			return (short)(buffer[1] | (buffer[0] << 8));
		}
		return (short)(buffer[0] | (buffer[1] << 8));
	}

	public virtual async Task<uint> ReadUInt32()
	{
		await Read(buffer, 0, 4).ConfigureAwait(continueOnCapturedContext: false);
		if (isBigEndian)
		{
			return (uint)(buffer[3] | (buffer[2] << 8) | (buffer[1] << 16) | (buffer[0] << 24));
		}
		return (uint)(buffer[0] | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24));
	}

	public virtual async Task<int> ReadInt32()
	{
		await Read(buffer, 0, 4).ConfigureAwait(continueOnCapturedContext: false);
		if (isBigEndian)
		{
			return buffer[3] | (buffer[2] << 8) | (buffer[1] << 16) | (buffer[0] << 24);
		}
		return buffer[0] | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);
	}

	public virtual async Task<ulong> ReadUInt64()
	{
		await Read(buffer, 0, 8).ConfigureAwait(continueOnCapturedContext: false);
		if (isBigEndian)
		{
			uint lo = (uint)(buffer[7] | (buffer[6] << 8) | (buffer[5] << 16) | (buffer[4] << 24));
			uint hi = (uint)(buffer[3] | (buffer[2] << 8) | (buffer[1] << 16) | (buffer[0] << 24));
			return ((ulong)hi << 32) | lo;
		}
		uint lo2 = (uint)(buffer[0] | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24));
		uint hi2 = (uint)(buffer[4] | (buffer[5] << 8) | (buffer[6] << 16) | (buffer[7] << 24));
		return ((ulong)hi2 << 32) | lo2;
	}

	public virtual async Task<long> ReadInt64()
	{
		await Read(buffer, 0, 8).ConfigureAwait(continueOnCapturedContext: false);
		if (isBigEndian)
		{
			uint lo = (uint)(buffer[7] | (buffer[6] << 8) | (buffer[5] << 16) | (buffer[4] << 24));
			uint hi = (uint)(buffer[3] | (buffer[2] << 8) | (buffer[1] << 16) | (buffer[0] << 24));
			return (long)(((ulong)hi << 32) | lo);
		}
		uint lo2 = (uint)(buffer[0] | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24));
		uint hi2 = (uint)(buffer[4] | (buffer[5] << 8) | (buffer[6] << 16) | (buffer[7] << 24));
		return (long)(((ulong)hi2 << 32) | lo2);
	}

	public virtual async Task<float> ReadSingle()
	{
		CheckDisposed();
		return ToSingle(await ReadUInt32().ConfigureAwait(continueOnCapturedContext: false));
	}

	public virtual async Task<double> ReadDouble()
	{
		CheckDisposed();
		return ToDouble(await ReadUInt64().ConfigureAwait(continueOnCapturedContext: false));
	}

	public virtual async Task<int> Read(byte[] buffer, int offset, int count)
	{
		CheckDisposed();
		int n;
		int len;
		for (n = 0; n < count; n += len)
		{
			len = await input.ReadAsync(buffer, offset + n, count - n).ConfigureAwait(continueOnCapturedContext: false);
			if (len <= 0)
			{
				throw new IOException("Stream is closed.");
			}
		}
		return n;
	}

	public virtual async Task<int> Read(IByteBuffer buffer, int count)
	{
		CheckDisposed();
		if (buffer is ByteBuffer buf)
		{
			buf.EnsureWritable(count);
			int n = 0;
			int offset = buf.ArrayOffset + buf.WriterIndex;
			int len;
			for (; n < count; n += len)
			{
				len = await input.ReadAsync(buf.Array, offset + n, count - n).ConfigureAwait(continueOnCapturedContext: false);
				if (len <= 0)
				{
					throw new IOException("Stream is closed.");
				}
			}
			buf.WriterIndex += n;
			return n;
		}
		int i;
		int len2;
		for (i = 0; i < count; i += len2)
		{
			len2 = await input.ReadAsync(this.buffer, 0, Math.Min(this.buffer.Length, count - i)).ConfigureAwait(continueOnCapturedContext: false);
			if (len2 <= 0)
			{
				throw new IOException("Stream is closed.");
			}
			buffer.Write(this.buffer, 0, len2);
		}
		return i;
	}

	protected unsafe float ToSingle(uint value)
	{
		return *(float*)(&value);
	}

	protected unsafe double ToDouble(ulong value)
	{
		return *(double*)(&value);
	}

	protected void CheckDisposed()
	{
		if (disposedValue)
		{
			throw new ObjectDisposedException("BinaryReader");
		}
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposedValue)
		{
			if (!leaveOpen && input != null)
			{
				input.Close();
				input = null;
			}
			disposedValue = true;
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}
}
