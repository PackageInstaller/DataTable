using System;

namespace GameFramework.Network;

public class ByteBuffer : IByteBuffer
{
	private const int DEFAULT_CAPACITY = 8192;

	protected byte[] array;

	protected int offset;

	protected int length;

	protected bool extensible;

	protected int readerIndex;

	protected int writerIndex;

	protected int markedReaderIndex;

	protected int markedWriterIndex;

	protected int maxCapacity;

	protected bool isBigEndian;

	protected internal byte[] Array => array;

	protected internal int ArrayOffset => offset;

	public int Capacity => Math.Min(length, array.Length - offset);

	public bool IsBigEndian
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

	public int MaxCapacity
	{
		get
		{
			return maxCapacity;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentException("MaxCapacity");
			}
			maxCapacity = value;
		}
	}

	public virtual int ReaderIndex
	{
		get
		{
			return readerIndex;
		}
		set
		{
			if (value < 0 || value > writerIndex)
			{
				throw new ArgumentOutOfRangeException($"ReaderIndex: {value} (expected: 0 <= readerIndex <= writerIndex({writerIndex})");
			}
			readerIndex = value;
		}
	}

	public virtual int WriterIndex
	{
		get
		{
			return writerIndex;
		}
		set
		{
			if (value < readerIndex || value > Capacity)
			{
				throw new ArgumentOutOfRangeException($"WriterIndex: {value} (expected: 0 <= readerIndex({readerIndex}) <= writerIndex <= capacity ({Capacity})");
			}
			writerIndex = value;
		}
	}

	public int ReadableBytes => WriterIndex - ReaderIndex;

	public int WritableBytes => Capacity - writerIndex;

	public int MaxWritableBytes => MaxCapacity - writerIndex;

	public ByteBuffer(bool isBigEndian = true)
		: this(8192, isBigEndian)
	{
	}

	public ByteBuffer(int initCapacity, bool isBigEndian = true)
	{
		array = new byte[initCapacity];
		offset = 0;
		length = int.MaxValue;
		extensible = true;
		maxCapacity = int.MaxValue;
		readerIndex = 0;
		writerIndex = 0;
		this.isBigEndian = isBigEndian;
	}

	public ByteBuffer(byte[] array, bool isBigEndian = true)
		: this(array, 0, array.Length, isBigEndian)
	{
	}

	public ByteBuffer(byte[] array, int offset, int length, bool isBigEndian = true)
	{
		this.array = array;
		this.offset = offset;
		this.length = length;
		extensible = false;
		maxCapacity = length;
		readerIndex = 0;
		writerIndex = length;
		this.isBigEndian = isBigEndian;
	}

	public ByteBuffer(ByteBuffer buffer, int offset, int length, bool isBigEndian = true)
	{
		array = buffer.array;
		this.offset = buffer.offset + offset;
		this.length = length;
		extensible = false;
		maxCapacity = length;
		readerIndex = 0;
		writerIndex = length;
		this.isBigEndian = isBigEndian;
	}

	public byte[] ToArray()
	{
		byte[] array = new byte[WriterIndex - ReaderIndex];
		System.Array.Copy(this.array, offset + ReaderIndex, array, 0, array.Length);
		return array;
	}

	public virtual bool IsReadable()
	{
		return writerIndex > readerIndex;
	}

	public virtual bool IsReadable(int size)
	{
		return writerIndex - readerIndex >= size;
	}

	public virtual bool IsWritable()
	{
		return Capacity > writerIndex;
	}

	public virtual bool IsWritable(int size)
	{
		return Capacity - writerIndex >= size;
	}

	public virtual IByteBuffer Clear()
	{
		readerIndex = (writerIndex = 0);
		return this;
	}

	public virtual IByteBuffer MarkReaderIndex()
	{
		markedReaderIndex = readerIndex;
		return this;
	}

	public virtual IByteBuffer ResetReaderIndex()
	{
		readerIndex = markedReaderIndex;
		return this;
	}

	public virtual IByteBuffer MarkWriterIndex()
	{
		markedWriterIndex = writerIndex;
		return this;
	}

	public virtual IByteBuffer ResetWriterIndex()
	{
		writerIndex = markedWriterIndex;
		return this;
	}

	public virtual IByteBuffer EnsureWritable(int minWritableBytes)
	{
		EnsureWritable0(minWritableBytes);
		return this;
	}

	protected internal void EnsureWritable0(int minWritableBytes)
	{
		if (!extensible)
		{
			throw new InvalidOperationException("The array length is not extensible");
		}
		if (minWritableBytes < 0)
		{
			throw new ArgumentOutOfRangeException("minWritableBytes", "expected minWritableBytes to be greater than zero");
		}
		if (minWritableBytes > WritableBytes)
		{
			if (minWritableBytes > MaxCapacity - writerIndex)
			{
				throw new IndexOutOfRangeException(string.Format($"writerIndex({0}) + minWritableBytes({1}) exceeds maxCapacity({2}): {3}", writerIndex, minWritableBytes, maxCapacity, this));
			}
			int newCapacity = CalculateNewCapacity(writerIndex + minWritableBytes, MaxCapacity);
			AdjustCapacity(newCapacity);
		}
	}

	private int CalculateNewCapacity(int minNewCapacity, int maxCapacity)
	{
		if (minNewCapacity % 512 == 0)
		{
			return minNewCapacity;
		}
		return Math.Min((minNewCapacity / 512 + 1) * 512, maxCapacity);
	}

	private IByteBuffer AdjustCapacity(int newCapacity)
	{
		if (newCapacity < 0 || newCapacity > MaxCapacity)
		{
			throw new ArgumentOutOfRangeException("newCapacity", string.Format($"newCapacity: {0} (expected: 0-{1})", newCapacity, maxCapacity));
		}
		int num = array.Length;
		if (newCapacity > num)
		{
			byte[] destinationArray = new byte[newCapacity];
			System.Array.Copy(array, 0, destinationArray, 0, num);
			array = destinationArray;
		}
		else if (newCapacity < num)
		{
			byte[] destinationArray2 = new byte[newCapacity];
			int num2 = ReaderIndex;
			if (num2 < newCapacity)
			{
				int num3 = WriterIndex;
				if (num3 > newCapacity)
				{
					writerIndex = newCapacity;
				}
				System.Array.Copy(array, num2, destinationArray2, 0, num3 - num2);
			}
			else
			{
				readerIndex = newCapacity;
				writerIndex = newCapacity;
			}
			array = destinationArray2;
		}
		return this;
	}

	protected virtual void CheckReadableBytes(int minimumReadableBytes)
	{
		if (readerIndex > writerIndex - minimumReadableBytes)
		{
			throw new IndexOutOfRangeException($"readerIndex({readerIndex}) + length({minimumReadableBytes}) exceeds writerIndex({writerIndex}): {this}");
		}
	}

	protected virtual void CheckIndex(int index, int length)
	{
		if ((index | length | (index + length) | (Capacity - (index + length))) < 0)
		{
			throw new IndexOutOfRangeException($"index: {index}, length: {length} (expected: range(0, {Capacity}))");
		}
	}

	protected virtual void CheckSrcIndex(int index, int length, int srcIndex, int srcCapacity)
	{
		CheckIndex(index, length);
		if ((srcIndex | length | (srcIndex + length) | (srcCapacity - (srcIndex + length))) < 0)
		{
			throw new IndexOutOfRangeException($"srcIndex: {srcIndex}, length: {length} (expected: range(0, {srcCapacity}))");
		}
	}

	protected virtual void CheckDstIndex(int index, int length, int dstIndex, int dstCapacity)
	{
		CheckIndex(index, length);
		if ((dstIndex | length | (dstIndex + length) | (dstCapacity - (dstIndex + length))) < 0)
		{
			throw new IndexOutOfRangeException($"dstIndex: {dstIndex}, length: {length} (expected: range(0, {dstCapacity}))");
		}
	}

	public virtual byte GetByte(int index)
	{
		CheckIndex(index, 1);
		return array[offset + index];
	}

	public virtual short GetInt16(int index)
	{
		CheckIndex(index, 2);
		index += offset;
		if (isBigEndian)
		{
			return (short)(array[index + 1] | (array[index] << 8));
		}
		return (short)(array[index] | (array[index + 1] << 8));
	}

	public virtual ushort GetUInt16(int index)
	{
		return (ushort)GetInt16(index);
	}

	public virtual int GetInt32(int index)
	{
		CheckIndex(index, 4);
		index += offset;
		if (isBigEndian)
		{
			return array[index + 3] | (array[index + 2] << 8) | (array[index + 1] << 16) | (array[index] << 24);
		}
		return array[index] | (array[index + 1] << 8) | (array[index + 2] << 16) | (array[index + 3] << 24);
	}

	public virtual uint GetUInt32(int index)
	{
		return (uint)GetInt32(index);
	}

	public virtual long GetInt64(int index)
	{
		CheckIndex(index, 8);
		index += offset;
		if (isBigEndian)
		{
			uint num = (uint)(array[index + 7] | (array[index + 6] << 8) | (array[index + 5] << 16) | (array[index + 4] << 24));
			uint num2 = (uint)(array[index + 3] | (array[index + 2] << 8) | (array[index + 1] << 16) | (array[index] << 24));
			return (long)(((ulong)num2 << 32) | num);
		}
		uint num3 = (uint)(array[index] | (array[index + 1] << 8) | (array[index + 2] << 16) | (array[index + 3] << 24));
		uint num4 = (uint)(array[index + 4] | (array[index + 5] << 8) | (array[index + 6] << 16) | (array[index + 7] << 24));
		return (long)(((ulong)num4 << 32) | num3);
	}

	public virtual ulong GetUInt64(int index)
	{
		return (ulong)GetInt64(index);
	}

	public virtual double GetDouble(int index)
	{
		return ToDouble(GetInt64(index));
	}

	public virtual float GetFloat(int index)
	{
		return ToSingle(GetInt32(index));
	}

	public virtual long GetVariableInt(int index)
	{
		int len = ReadVariableIntLength(GetByte(index));
		return GetVariableInt(index, len);
	}

	public virtual long Get7BitEncodedInt(int index)
	{
		long value;
		if (isBigEndian)
		{
			Get7BitEncodedIntBE(index, out value);
		}
		else
		{
			Get7BitEncodedIntLE(index, out value);
		}
		return value;
	}

	public virtual IByteBuffer GetBytes(int index, byte[] destination)
	{
		GetBytes(index, destination, 0, destination.Length);
		return this;
	}

	public virtual IByteBuffer GetBytes(int index, byte[] destination, int dstIndex, int length)
	{
		CheckDstIndex(index, length, dstIndex, destination.Length);
		System.Array.Copy(array, offset + index, destination, dstIndex, length);
		return this;
	}

	public virtual IByteBuffer GetBytes(int index, IByteBuffer destination)
	{
		GetBytes(index, destination, destination.WritableBytes);
		return this;
	}

	public virtual IByteBuffer GetBytes(int index, IByteBuffer destination, int length)
	{
		GetBytes(index, destination, destination.WriterIndex, length);
		destination.WriterIndex += length;
		return this;
	}

	public virtual IByteBuffer GetBytes(int index, IByteBuffer destination, int dstIndex, int length)
	{
		CheckDstIndex(index, length, dstIndex, destination.Capacity);
		if (destination is ByteBuffer byteBuffer)
		{
			GetBytes(index, byteBuffer.Array, byteBuffer.ArrayOffset + dstIndex, length);
		}
		else
		{
			destination.Set(dstIndex, array, offset + index, length);
		}
		return this;
	}

	public virtual IByteBuffer Slice(int length)
	{
		return Slice(readerIndex, length);
	}

	public virtual IByteBuffer Slice(int index, int length)
	{
		return new ByteBuffer(this, index, length);
	}

	public virtual IByteBuffer Set(int index, byte value)
	{
		CheckIndex(index, 1);
		array[offset + index] = value;
		return this;
	}

	public virtual IByteBuffer Set(int index, short value)
	{
		CheckIndex(index, 2);
		index += offset;
		if (isBigEndian)
		{
			array[index++] = (byte)((value >> 8) & 0xFF);
			array[index++] = (byte)(value & 0xFF);
		}
		else
		{
			array[index++] = (byte)(value & 0xFF);
			array[index++] = (byte)((value >> 8) & 0xFF);
		}
		return this;
	}

	public virtual IByteBuffer Set(int index, ushort value)
	{
		return Set(index, (short)value);
	}

	public virtual IByteBuffer Set(int index, int value)
	{
		CheckIndex(index, 4);
		index += offset;
		if (isBigEndian)
		{
			array[index++] = (byte)((value >> 24) & 0xFF);
			array[index++] = (byte)((value >> 16) & 0xFF);
			array[index++] = (byte)((value >> 8) & 0xFF);
			array[index++] = (byte)(value & 0xFF);
		}
		else
		{
			array[index++] = (byte)(value & 0xFF);
			array[index++] = (byte)((value >> 8) & 0xFF);
			array[index++] = (byte)((value >> 16) & 0xFF);
			array[index++] = (byte)((value >> 24) & 0xFF);
		}
		return this;
	}

	public virtual IByteBuffer Set(int index, uint value)
	{
		return Set(index, (int)value);
	}

	public virtual IByteBuffer Set(int index, long value)
	{
		CheckIndex(index, 8);
		index += offset;
		if (isBigEndian)
		{
			array[index++] = (byte)((value >> 56) & 0xFF);
			array[index++] = (byte)((value >> 48) & 0xFF);
			array[index++] = (byte)((value >> 40) & 0xFF);
			array[index++] = (byte)((value >> 32) & 0xFF);
			array[index++] = (byte)((value >> 24) & 0xFF);
			array[index++] = (byte)((value >> 16) & 0xFF);
			array[index++] = (byte)((value >> 8) & 0xFF);
			array[index++] = (byte)(value & 0xFF);
		}
		else
		{
			array[index++] = (byte)(value & 0xFF);
			array[index++] = (byte)((value >> 8) & 0xFF);
			array[index++] = (byte)((value >> 16) & 0xFF);
			array[index++] = (byte)((value >> 24) & 0xFF);
			array[index++] = (byte)((value >> 32) & 0xFF);
			array[index++] = (byte)((value >> 40) & 0xFF);
			array[index++] = (byte)((value >> 48) & 0xFF);
			array[index++] = (byte)((value >> 56) & 0xFF);
		}
		return this;
	}

	public virtual IByteBuffer Set(int index, ulong value)
	{
		return Set(index, (long)value);
	}

	public virtual IByteBuffer Set(int index, float value)
	{
		return Set(index, ToInt32(value));
	}

	public virtual IByteBuffer Set(int index, double value)
	{
		return Set(index, ToInt64(value));
	}

	public virtual IByteBuffer SetVariableInt(int index, long value)
	{
		int variableIntLength = GetVariableIntLength(value);
		SetVariableInt(index, value, variableIntLength);
		return this;
	}

	public virtual IByteBuffer Set7BitEncodedInt(int index, long value)
	{
		int len = Get7BitEncodedLength(value);
		if (isBigEndian)
		{
			Set7BitEncodedIntBE(index, value, len);
		}
		else
		{
			Set7BitEncodedIntLE(index, value, len);
		}
		return this;
	}

	public virtual IByteBuffer Set(int index, byte[] src)
	{
		Set(index, src, 0, src.Length);
		return this;
	}

	public virtual IByteBuffer Set(int index, byte[] src, int srcIndex, int length)
	{
		CheckSrcIndex(index, length, srcIndex, src.Length);
		System.Array.Copy(src, srcIndex, array, offset + index, length);
		return this;
	}

	public virtual IByteBuffer Set(int index, IByteBuffer src)
	{
		Set(index, src, src.ReadableBytes);
		return this;
	}

	public virtual IByteBuffer Set(int index, IByteBuffer src, int length)
	{
		if (src == null)
		{
			throw new ArgumentNullException("src");
		}
		CheckIndex(index, length);
		if (length > src.ReadableBytes)
		{
			throw new IndexOutOfRangeException($"length({length}) exceeds src.readableBytes({src.ReadableBytes}) where src is: {src}");
		}
		Set(index, src, src.ReaderIndex, length);
		src.ReaderIndex += length;
		return this;
	}

	public virtual IByteBuffer Set(int index, IByteBuffer src, int srcIndex, int length)
	{
		CheckSrcIndex(index, length, srcIndex, src.Capacity);
		if (src is ByteBuffer byteBuffer)
		{
			Set(index, byteBuffer.Array, byteBuffer.ArrayOffset + srcIndex, length);
		}
		else
		{
			src.GetBytes(srcIndex, array, offset + index, length);
		}
		return this;
	}

	public virtual byte ReadByte()
	{
		CheckReadableBytes(1);
		byte result = GetByte(readerIndex);
		readerIndex++;
		return result;
	}

	public virtual short ReadInt16()
	{
		CheckReadableBytes(2);
		short @int = GetInt16(readerIndex);
		readerIndex += 2;
		return @int;
	}

	public virtual ushort ReadUInt16()
	{
		return (ushort)ReadInt16();
	}

	public virtual int ReadInt32()
	{
		CheckReadableBytes(4);
		int @int = GetInt32(readerIndex);
		readerIndex += 4;
		return @int;
	}

	public virtual uint ReadUInt32()
	{
		return (uint)ReadInt32();
	}

	public virtual long ReadInt64()
	{
		CheckReadableBytes(8);
		long @int = GetInt64(readerIndex);
		readerIndex += 8;
		return @int;
	}

	public virtual ulong ReadUInt64()
	{
		return (ulong)ReadInt64();
	}

	public virtual double ReadDouble()
	{
		return ToDouble(ReadInt64());
	}

	public virtual float ReadFloat()
	{
		return ToSingle(ReadInt32());
	}

	public virtual long ReadVariableInt()
	{
		int index = readerIndex;
		CheckReadableBytes(1);
		int num = ReadVariableIntLength(GetByte(index));
		CheckReadableBytes(num);
		long variableInt = GetVariableInt(index, num);
		readerIndex += num;
		return variableInt;
	}

	public virtual long Read7BitEncodedInt()
	{
		int index = readerIndex;
		int num = ((!isBigEndian) ? Get7BitEncodedIntLE(index, out var value) : Get7BitEncodedIntBE(index, out value));
		readerIndex += num;
		return value;
	}

	public virtual IByteBuffer ReadBytes(int length)
	{
		CheckReadableBytes(length);
		if (length == 0)
		{
			return null;
		}
		byte[] destination = new byte[length];
		ReadBytes(destination, 0, length);
		return new ByteBuffer(destination, 0, length);
	}

	public virtual byte[] ReadBytes(int offset, int length)
	{
		CheckReadableBytes(length);
		if (length == 0)
		{
			return null;
		}
		byte[] array = new byte[length];
		ReadBytes(array, offset, length);
		return array;
	}

	public virtual IByteBuffer ReadBytes(IByteBuffer destination)
	{
		ReadBytes(destination, destination.WritableBytes);
		return this;
	}

	public virtual IByteBuffer ReadBytes(IByteBuffer destination, int length)
	{
		if (length > destination.WritableBytes)
		{
			throw new IndexOutOfRangeException($"length({length}) exceeds destination.WritableBytes({destination.WritableBytes}) where destination is: {destination}");
		}
		ReadBytes(destination, destination.WriterIndex, length);
		destination.WriterIndex += length;
		return this;
	}

	public virtual IByteBuffer ReadBytes(IByteBuffer destination, int dstIndex, int length)
	{
		CheckReadableBytes(length);
		GetBytes(readerIndex, destination, dstIndex, length);
		readerIndex += length;
		return this;
	}

	public virtual IByteBuffer ReadBytes(byte[] destination)
	{
		ReadBytes(destination, 0, destination.Length);
		return this;
	}

	public virtual IByteBuffer ReadBytes(byte[] destination, int dstIndex, int length)
	{
		CheckReadableBytes(length);
		GetBytes(readerIndex, destination, dstIndex, length);
		readerIndex += length;
		return this;
	}

	public virtual IByteBuffer Write(byte value)
	{
		EnsureWritable0(1);
		Set(writerIndex, value);
		writerIndex++;
		return this;
	}

	public virtual IByteBuffer Write(short value)
	{
		EnsureWritable0(2);
		Set(writerIndex, value);
		writerIndex += 2;
		return this;
	}

	public virtual IByteBuffer Write(ushort value)
	{
		EnsureWritable0(2);
		Set(writerIndex, value);
		writerIndex += 2;
		return this;
	}

	public virtual IByteBuffer Write(int value)
	{
		EnsureWritable0(4);
		Set(writerIndex, value);
		writerIndex += 4;
		return this;
	}

	public virtual IByteBuffer Write(uint value)
	{
		EnsureWritable0(4);
		Set(writerIndex, value);
		writerIndex += 4;
		return this;
	}

	public virtual IByteBuffer Write(long value)
	{
		EnsureWritable0(8);
		Set(writerIndex, value);
		writerIndex += 8;
		return this;
	}

	public virtual IByteBuffer Write(ulong value)
	{
		EnsureWritable0(8);
		Set(writerIndex, value);
		writerIndex += 8;
		return this;
	}

	public virtual IByteBuffer Write(float value)
	{
		EnsureWritable0(4);
		Set(writerIndex, value);
		writerIndex += 4;
		return this;
	}

	public virtual IByteBuffer Write(double value)
	{
		EnsureWritable0(8);
		Set(writerIndex, value);
		writerIndex += 8;
		return this;
	}

	public virtual IByteBuffer WriteVariableInt(long value)
	{
		int variableIntLength = GetVariableIntLength(value);
		EnsureWritable0(variableIntLength);
		int index = writerIndex;
		SetVariableInt(index, value, variableIntLength);
		writerIndex += variableIntLength;
		return this;
	}

	public virtual IByteBuffer Write7BitEncodedInt(long value)
	{
		int num = Get7BitEncodedLength(value);
		EnsureWritable0(num);
		int index = writerIndex;
		if (isBigEndian)
		{
			Set7BitEncodedIntBE(index, value, num);
		}
		else
		{
			Set7BitEncodedIntLE(index, value, num);
		}
		writerIndex += num;
		return this;
	}

	public virtual IByteBuffer Write(IByteBuffer src)
	{
		return Write(src, src.ReaderIndex, src.ReadableBytes);
	}

	public virtual IByteBuffer Write(IByteBuffer src, int length)
	{
		return Write(src, src.ReaderIndex, length);
	}

	public virtual IByteBuffer Write(IByteBuffer src, int srcIndex, int length)
	{
		if (length > src.ReadableBytes)
		{
			throw new IndexOutOfRangeException($"length({length}) exceeds src.readableBytes({src.ReadableBytes}) where src is: {src}");
		}
		EnsureWritable0(length);
		Set(writerIndex, src, srcIndex, length);
		writerIndex += length;
		return this;
	}

	public virtual IByteBuffer Write(byte[] src)
	{
		return Write(src, 0, src.Length);
	}

	public virtual IByteBuffer Write(byte[] src, int srcIndex, int length)
	{
		EnsureWritable0(length);
		Set(writerIndex, src, srcIndex, length);
		writerIndex += length;
		return this;
	}

	public virtual IByteBuffer ReadSlice(int length)
	{
		return ReadSlice(readerIndex, length);
	}

	public virtual IByteBuffer ReadSlice(int index, int length)
	{
		CheckReadableBytes(length);
		IByteBuffer result = Slice(readerIndex, length);
		readerIndex += length;
		return result;
	}

	protected virtual long GetVariableInt(int index, int len)
	{
		return len switch
		{
			1 => GetByte(index), 
			2 => GetInt16(index) & 0x3FFF, 
			4 => GetInt32(index) & 0x3FFFFFFF, 
			8 => GetInt64(index) & 0x3FFFFFFFFFFFFFFFL, 
			_ => throw new ArgumentException(), 
		};
	}

	protected virtual void SetVariableInt(int index, long value, int len)
	{
		switch (len)
		{
		case 1:
			Set(index, (byte)value);
			break;
		case 2:
			Set(index, (short)value);
			Set(index, (byte)(GetByte(index) | 0x40));
			break;
		case 4:
			Set(index, (int)value);
			Set(index, (byte)(GetByte(index) | 0x80));
			break;
		case 8:
			Set(index, value);
			Set(index, (byte)(GetByte(index) | 0xC0));
			break;
		default:
			throw new ArgumentException("value");
		}
	}

	protected virtual int Get7BitEncodedIntLE(int index, out long value)
	{
		int result = 0;
		value = 0L;
		byte b;
		do
		{
			if (result++ == 9)
			{
				throw new FormatException("More than 63 bit");
			}
			b = GetByte(index++);
			value |= (b & 0x7F) << 7;
		}
		while ((b & 0x80) != 0);
		return result;
	}

	protected virtual int Get7BitEncodedIntBE(int index, out long value)
	{
		int result = 0;
		value = 0L;
		byte b;
		do
		{
			if (result++ == 9)
			{
				throw new FormatException("More than 63 bit");
			}
			b = GetByte(index++);
			value = (value << 7) | (b & 0x7F);
		}
		while ((b & 0x80) != 0);
		return result;
	}

	protected virtual void Set7BitEncodedIntLE(int index, long value, int len)
	{
		ulong num;
		for (num = (ulong)value; num >= 128; num >>= 7)
		{
			Set(index++, (byte)(num | 0x80));
		}
		Set(index++, (byte)num);
	}

	protected virtual void Set7BitEncodedIntBE(int index, long value, int len)
	{
		ulong num = (ulong)value;
		index += len;
		Set(--index, (byte)(num & 0x7F));
		while (num >= 128)
		{
			num >>= 7;
			Set(--index, (byte)(num | 0x80));
		}
	}

	public static int Get7BitEncodedLength(long value)
	{
		if (value < 0)
		{
			throw new ArgumentException($"value: {value} ,expected: 0 <= value <= 0x7FFFFFFFFFFFFFFFL");
		}
		if (value <= 127)
		{
			return 1;
		}
		if (value <= 16383)
		{
			return 2;
		}
		if (value <= 2097151)
		{
			return 3;
		}
		if (value <= 268435455)
		{
			return 4;
		}
		if (value <= int.MaxValue)
		{
			return 5;
		}
		if (value <= 4398046511103L)
		{
			return 6;
		}
		if (value <= 562949953421311L)
		{
			return 7;
		}
		if (value <= 72057594037927935L)
		{
			return 8;
		}
		if (value <= long.MaxValue)
		{
			return 9;
		}
		throw new ArgumentException($"value: {value} ,expected: 0 <= value <= 0x7FFFFFFFFFFFFFFFL");
	}

	public static int GetVariableIntLength(long value)
	{
		if (value < 0)
		{
			throw new ArgumentException($"value: {value} ,expected: 0 <= value <= 4611686018427387903L");
		}
		if (value <= 63)
		{
			return 1;
		}
		if (value <= 16383)
		{
			return 2;
		}
		if (value <= 1073741823)
		{
			return 4;
		}
		if (value <= 4611686018427387903L)
		{
			return 8;
		}
		throw new ArgumentException($"value: {value} ,expected: 0 <= value <= 4611686018427387903L");
	}

	public static int ReadVariableIntLength(byte b)
	{
		byte b2 = (byte)(b >> 6);
		if ((b2 & 1) != 0)
		{
			if ((b2 & 2) != 0)
			{
				return 8;
			}
			return 2;
		}
		if ((b2 & 2) != 0)
		{
			return 4;
		}
		return 1;
	}

	protected unsafe static float ToSingle(int value)
	{
		return *(float*)(&value);
	}

	protected unsafe static double ToDouble(long value)
	{
		return *(double*)(&value);
	}

	protected unsafe static int ToInt32(float value)
	{
		return *(int*)(&value);
	}

	protected unsafe static long ToInt64(double value)
	{
		return *(long*)(&value);
	}
}
