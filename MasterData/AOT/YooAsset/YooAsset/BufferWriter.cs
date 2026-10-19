using System;
using System.Diagnostics;
using System.IO;
using System.Text;

namespace YooAsset;

internal class BufferWriter
{
	private readonly byte[] _buffer;

	private int _index;

	public int Capacity => _buffer.Length;

	public BufferWriter(int capacity)
	{
		_buffer = new byte[capacity];
	}

	public void Clear()
	{
		_index = 0;
	}

	public void WriteToStream(FileStream fileStream)
	{
		fileStream.Write(_buffer, 0, _index);
	}

	public void WriteBytes(byte[] data)
	{
		int num = data.Length;
		Buffer.BlockCopy(data, 0, _buffer, _index, num);
		_index += num;
	}

	public void WriteByte(byte value)
	{
		_buffer[_index++] = value;
	}

	public void WriteBool(bool value)
	{
		WriteByte((byte)(value ? 1u : 0u));
	}

	public void WriteInt16(short value)
	{
		WriteUInt16((ushort)value);
	}

	public void WriteUInt16(ushort value)
	{
		_buffer[_index++] = (byte)value;
		_buffer[_index++] = (byte)(value >> 8);
	}

	public void WriteInt32(int value)
	{
		WriteUInt32((uint)value);
	}

	public void WriteUInt32(uint value)
	{
		_buffer[_index++] = (byte)value;
		_buffer[_index++] = (byte)(value >> 8);
		_buffer[_index++] = (byte)(value >> 16);
		_buffer[_index++] = (byte)(value >> 24);
	}

	public void WriteInt64(long value)
	{
		WriteUInt64((ulong)value);
	}

	public void WriteUInt64(ulong value)
	{
		_buffer[_index++] = (byte)value;
		_buffer[_index++] = (byte)(value >> 8);
		_buffer[_index++] = (byte)(value >> 16);
		_buffer[_index++] = (byte)(value >> 24);
		_buffer[_index++] = (byte)(value >> 32);
		_buffer[_index++] = (byte)(value >> 40);
		_buffer[_index++] = (byte)(value >> 48);
		_buffer[_index++] = (byte)(value >> 56);
	}

	public void WriteUTF8(string value)
	{
		if (string.IsNullOrEmpty(value))
		{
			WriteUInt16(0);
			return;
		}
		byte[] bytes = Encoding.UTF8.GetBytes(value);
		int num = bytes.Length;
		if (num > 65535)
		{
			throw new FormatException($"Write string length cannot be greater than {ushort.MaxValue} !");
		}
		WriteUInt16(Convert.ToUInt16(num));
		WriteBytes(bytes);
	}

	public void WriteInt32Array(int[] values)
	{
		if (values == null)
		{
			WriteUInt16(0);
			return;
		}
		int num = values.Length;
		if (num > 65535)
		{
			throw new FormatException($"Write array length cannot be greater than {ushort.MaxValue} !");
		}
		WriteUInt16(Convert.ToUInt16(num));
		for (int i = 0; i < num; i++)
		{
			WriteInt32(values[i]);
		}
	}

	public void WriteInt64Array(long[] values)
	{
		if (values == null)
		{
			WriteUInt16(0);
			return;
		}
		int num = values.Length;
		if (num > 65535)
		{
			throw new FormatException($"Write array length cannot be greater than {ushort.MaxValue} !");
		}
		WriteUInt16(Convert.ToUInt16(num));
		for (int i = 0; i < num; i++)
		{
			WriteInt64(values[i]);
		}
	}

	public void WriteUTF8Array(string[] values)
	{
		if (values == null)
		{
			WriteUInt16(0);
			return;
		}
		int num = values.Length;
		if (num > 65535)
		{
			throw new FormatException($"Write array length cannot be greater than {ushort.MaxValue} !");
		}
		WriteUInt16(Convert.ToUInt16(num));
		for (int i = 0; i < num; i++)
		{
			WriteUTF8(values[i]);
		}
	}

	[Conditional("DEBUG")]
	private void CheckWriterIndex(int length)
	{
		if (_index + length > Capacity)
		{
			throw new IndexOutOfRangeException();
		}
	}
}
