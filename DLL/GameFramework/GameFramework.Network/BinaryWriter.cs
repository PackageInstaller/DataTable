using System;
using System.IO;
using System.Threading.Tasks;

namespace GameFramework.Network;

public class BinaryWriter : IDisposable
{
	private const int DEFAULT_BUFFER_SIZE = 4192;

	private Stream output;

	private bool leaveOpen;

	private bool isBigEndian;

	private byte[] buffer;

	private bool disposedValue = false;

	public virtual Stream BaseStream => output;

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

	public BinaryWriter(Stream output, bool leaveOpen)
		: this(output, leaveOpen, isBigEndian: true)
	{
	}

	public BinaryWriter(Stream output, bool leaveOpen, bool isBigEndian)
	{
		this.output = output;
		this.leaveOpen = leaveOpen;
		this.isBigEndian = isBigEndian;
		buffer = new byte[4192];
	}

	public virtual void Write(byte value)
	{
		CheckDisposed();
		output.WriteByte(value);
	}

	public virtual void Write(ushort value)
	{
		CheckDisposed();
		if (isBigEndian)
		{
			buffer[1] = (byte)value;
			buffer[0] = (byte)(value >> 8);
		}
		else
		{
			buffer[0] = (byte)value;
			buffer[1] = (byte)(value >> 8);
		}
		output.Write(buffer, 0, 2);
	}

	public virtual void Write(short value)
	{
		CheckDisposed();
		if (isBigEndian)
		{
			buffer[1] = (byte)value;
			buffer[0] = (byte)(value >> 8);
		}
		else
		{
			buffer[0] = (byte)value;
			buffer[1] = (byte)(value >> 8);
		}
		output.Write(buffer, 0, 2);
	}

	public virtual void Write(uint value)
	{
		CheckDisposed();
		if (isBigEndian)
		{
			buffer[3] = (byte)value;
			buffer[2] = (byte)(value >> 8);
			buffer[1] = (byte)(value >> 16);
			buffer[0] = (byte)(value >> 24);
		}
		else
		{
			buffer[0] = (byte)value;
			buffer[1] = (byte)(value >> 8);
			buffer[2] = (byte)(value >> 16);
			buffer[3] = (byte)(value >> 24);
		}
		output.Write(buffer, 0, 4);
	}

	public virtual void Write(int value)
	{
		CheckDisposed();
		if (isBigEndian)
		{
			buffer[3] = (byte)value;
			buffer[2] = (byte)(value >> 8);
			buffer[1] = (byte)(value >> 16);
			buffer[0] = (byte)(value >> 24);
		}
		else
		{
			buffer[0] = (byte)value;
			buffer[1] = (byte)(value >> 8);
			buffer[2] = (byte)(value >> 16);
			buffer[3] = (byte)(value >> 24);
		}
		output.Write(buffer, 0, 4);
	}

	public virtual void Write(ulong value)
	{
		CheckDisposed();
		if (isBigEndian)
		{
			buffer[7] = (byte)value;
			buffer[6] = (byte)(value >> 8);
			buffer[5] = (byte)(value >> 16);
			buffer[4] = (byte)(value >> 24);
			buffer[3] = (byte)(value >> 32);
			buffer[2] = (byte)(value >> 40);
			buffer[1] = (byte)(value >> 48);
			buffer[0] = (byte)(value >> 56);
		}
		else
		{
			buffer[0] = (byte)value;
			buffer[1] = (byte)(value >> 8);
			buffer[2] = (byte)(value >> 16);
			buffer[3] = (byte)(value >> 24);
			buffer[4] = (byte)(value >> 32);
			buffer[5] = (byte)(value >> 40);
			buffer[6] = (byte)(value >> 48);
			buffer[7] = (byte)(value >> 56);
		}
		output.Write(buffer, 0, 8);
	}

	public virtual void Write(long value)
	{
		CheckDisposed();
		if (isBigEndian)
		{
			buffer[7] = (byte)value;
			buffer[6] = (byte)(value >> 8);
			buffer[5] = (byte)(value >> 16);
			buffer[4] = (byte)(value >> 24);
			buffer[3] = (byte)(value >> 32);
			buffer[2] = (byte)(value >> 40);
			buffer[1] = (byte)(value >> 48);
			buffer[0] = (byte)(value >> 56);
		}
		else
		{
			buffer[0] = (byte)value;
			buffer[1] = (byte)(value >> 8);
			buffer[2] = (byte)(value >> 16);
			buffer[3] = (byte)(value >> 24);
			buffer[4] = (byte)(value >> 32);
			buffer[5] = (byte)(value >> 40);
			buffer[6] = (byte)(value >> 48);
			buffer[7] = (byte)(value >> 56);
		}
		output.Write(buffer, 0, 8);
	}

	public virtual void Write(float value)
	{
		CheckDisposed();
		uint num = ToUInt32(value);
		buffer[0] = (byte)num;
		buffer[1] = (byte)(num >> 8);
		buffer[2] = (byte)(num >> 16);
		buffer[3] = (byte)(num >> 24);
		output.Write(buffer, 0, 4);
	}

	public virtual void Write(double value)
	{
		CheckDisposed();
		ulong num = ToUInt64(value);
		buffer[0] = (byte)num;
		buffer[1] = (byte)(num >> 8);
		buffer[2] = (byte)(num >> 16);
		buffer[3] = (byte)(num >> 24);
		buffer[4] = (byte)(num >> 32);
		buffer[5] = (byte)(num >> 40);
		buffer[6] = (byte)(num >> 48);
		buffer[7] = (byte)(num >> 56);
		output.Write(buffer, 0, 8);
	}

	public virtual void Write(byte[] buffer, int offset, int count)
	{
		CheckDisposed();
		output.Write(buffer, offset, count);
	}

	public virtual void Write(IByteBuffer buffer, int count)
	{
		CheckDisposed();
		if (buffer is ByteBuffer byteBuffer)
		{
			int offset = byteBuffer.ArrayOffset + byteBuffer.ReaderIndex;
			byteBuffer.ReaderIndex += count;
			output.Write(byteBuffer.Array, offset, count);
		}
		else
		{
			byte[] destination = new byte[count];
			buffer.ReadBytes(destination, 0, count);
			output.Write(destination, 0, count);
		}
	}

	public virtual Task WriteAsync(byte[] buffer, int offset, int count)
	{
		CheckDisposed();
		return output.WriteAsync(buffer, offset, count);
	}

	public virtual async Task WriteAsync(IByteBuffer buffer, int count)
	{
		CheckDisposed();
		if (buffer is ByteBuffer buf)
		{
			int offset = buf.ArrayOffset + buf.ReaderIndex;
			buf.ReaderIndex += count;
			await output.WriteAsync(buf.Array, offset, count).ConfigureAwait(continueOnCapturedContext: false);
		}
		else
		{
			byte[] data = new byte[count];
			buffer.ReadBytes(data, 0, count);
			await output.WriteAsync(data, 0, count).ConfigureAwait(continueOnCapturedContext: false);
		}
	}

	public virtual void Flush()
	{
		CheckDisposed();
		output.Flush();
	}

	public virtual Task FlushAsync()
	{
		CheckDisposed();
		return output.FlushAsync();
	}

	protected unsafe uint ToUInt32(float value)
	{
		return *(uint*)(&value);
	}

	protected unsafe ulong ToUInt64(double value)
	{
		return *(ulong*)(&value);
	}

	protected void CheckDisposed()
	{
		if (disposedValue)
		{
			throw new ObjectDisposedException("BinaryWriter");
		}
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposedValue)
		{
			if (!leaveOpen && output != null)
			{
				output.Close();
				output = null;
			}
			disposedValue = true;
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}
}
