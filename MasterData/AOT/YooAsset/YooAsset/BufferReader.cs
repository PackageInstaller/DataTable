using System;
using System.Diagnostics;
using System.Text;

namespace YooAsset;

internal class BufferReader
{
	private readonly byte[] _buffer;

	private int _index;

	public bool IsValid
	{
		get
		{
			if (_buffer == null || _buffer.Length == 0)
			{
				return false;
			}
			return true;
		}
	}

	public int Capacity => _buffer.Length;

	public BufferReader(byte[] data)
	{
		_buffer = data;
	}

	public byte[] ReadBytes(int count)
	{
		byte[] array = new byte[count];
		Buffer.BlockCopy(_buffer, _index, array, 0, count);
		_index += count;
		return array;
	}

	public byte ReadByte()
	{
		return _buffer[_index++];
	}

	public bool ReadBool()
	{
		return _buffer[_index++] == 1;
	}

	public short ReadInt16()
	{
		if (BitConverter.IsLittleEndian)
		{
			short result = (short)(_buffer[_index] | (_buffer[_index + 1] << 8));
			_index += 2;
			return result;
		}
		short result2 = (short)((_buffer[_index] << 8) | _buffer[_index + 1]);
		_index += 2;
		return result2;
	}

	public ushort ReadUInt16()
	{
		return (ushort)ReadInt16();
	}

	public int ReadInt32()
	{
		if (BitConverter.IsLittleEndian)
		{
			int result = _buffer[_index] | (_buffer[_index + 1] << 8) | (_buffer[_index + 2] << 16) | (_buffer[_index + 3] << 24);
			_index += 4;
			return result;
		}
		int result2 = (_buffer[_index] << 24) | (_buffer[_index + 1] << 16) | (_buffer[_index + 2] << 8) | _buffer[_index + 3];
		_index += 4;
		return result2;
	}

	public uint ReadUInt32()
	{
		return (uint)ReadInt32();
	}

	public long ReadInt64()
	{
		if (BitConverter.IsLittleEndian)
		{
			int num = _buffer[_index] | (_buffer[_index + 1] << 8) | (_buffer[_index + 2] << 16) | (_buffer[_index + 3] << 24);
			int num2 = _buffer[_index + 4] | (_buffer[_index + 5] << 8) | (_buffer[_index + 6] << 16) | (_buffer[_index + 7] << 24);
			_index += 8;
			return (uint)num | ((long)num2 << 32);
		}
		int num3 = (_buffer[_index] << 24) | (_buffer[_index + 1] << 16) | (_buffer[_index + 2] << 8) | _buffer[_index + 3];
		int num4 = (_buffer[_index + 4] << 24) | (_buffer[_index + 5] << 16) | (_buffer[_index + 6] << 8) | _buffer[_index + 7];
		_index += 8;
		return (uint)num4 | ((long)num3 << 32);
	}

	public ulong ReadUInt64()
	{
		return (ulong)ReadInt64();
	}

	public string ReadUTF8()
	{
		ushort num = ReadUInt16();
		if (num == 0)
		{
			return string.Empty;
		}
		string result = Encoding.UTF8.GetString(_buffer, _index, num);
		_index += num;
		return result;
	}

	public int[] ReadInt32Array()
	{
		ushort num = ReadUInt16();
		int[] array = new int[num];
		for (int i = 0; i < num; i++)
		{
			array[i] = ReadInt32();
		}
		return array;
	}

	public long[] ReadInt64Array()
	{
		ushort num = ReadUInt16();
		long[] array = new long[num];
		for (int i = 0; i < num; i++)
		{
			array[i] = ReadInt64();
		}
		return array;
	}

	public string[] ReadUTF8Array()
	{
		ushort num = ReadUInt16();
		string[] array = new string[num];
		for (int i = 0; i < num; i++)
		{
			array[i] = ReadUTF8();
		}
		return array;
	}

	[Conditional("DEBUG")]
	private void CheckReaderIndex(int length)
	{
		if (_index + length > Capacity)
		{
			throw new IndexOutOfRangeException();
		}
	}
}
