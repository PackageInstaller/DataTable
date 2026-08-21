#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.CompilerServices;
using Ase.Serializing.Helping;
using GameFramework;
using UnityEngine;

namespace Ase.Serializing;

public class Reader
{
	public int Position;

	private byte[] _buffer;

	public int Capacity => _buffer.Length;

	public int Offset { get; private set; }

	public int Length { get; private set; }

	public int Remaining => Length + Offset - Position;

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Reader(byte[] bytes)
	{
		Initialize(bytes);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Reader(ArraySegment<byte> segment)
	{
		Initialize(segment);
	}

	public override string ToString()
	{
		return $"Position: {Position}, Length: {Length}, Buffer: {BitConverter.ToString(_buffer, Offset, Length)}.";
	}

	internal void Initialize(ArraySegment<byte> bytes)
	{
		if (bytes.Array == null)
		{
			if (_buffer == null)
			{
				_buffer = new byte[0];
			}
		}
		else
		{
			_buffer = bytes.Array;
		}
		Position = bytes.Offset;
		Offset = bytes.Offset;
		Length = bytes.Count;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	internal void Initialize(byte[] bytes)
	{
		Initialize(new ArraySegment<byte>(bytes));
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Obsolete("Use ReadDictionaryAllocated.")]
	public Dictionary<TKey, TValue> ReadDictionary<TKey, TValue>()
	{
		return ReadDictionaryAllocated<TKey, TValue>();
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Dictionary<TKey, TValue> ReadDictionaryAllocated<TKey, TValue>()
	{
		if (ReadBoolean())
		{
			return null;
		}
		int num = ReadInt32();
		Dictionary<TKey, TValue> dictionary = new Dictionary<TKey, TValue>(num);
		for (int i = 0; i < num; i++)
		{
			TKey key = Read<TKey>();
			TValue value = Read<TValue>();
			dictionary.Add(key, value);
		}
		return dictionary;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	internal int ReadLength()
	{
		return ReadInt32();
	}

	public void Skip(int value)
	{
		if (value >= 1 && Remaining >= value)
		{
			Position += value;
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Clear()
	{
		if (Remaining > 0)
		{
			Skip(Remaining);
		}
	}

	public ArraySegment<byte> GetArraySegmentBuffer()
	{
		return new ArraySegment<byte>(_buffer, Offset, Length);
	}

	public byte[] GetByteBuffer()
	{
		return _buffer;
	}

	public byte[] GetByteBufferAllocated()
	{
		byte[] array = new byte[Length];
		Buffer.BlockCopy(_buffer, Offset, array, 0, Length);
		return array;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void BlockCopy(ref byte[] target, int targetOffset, int count)
	{
		Buffer.BlockCopy(_buffer, Position, target, targetOffset, count);
		Position += count;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public byte ReadByte()
	{
		byte result = _buffer[Position];
		Position++;
		return result;
	}

	public void ReadBytes(ref byte[] buffer, int count)
	{
		if (buffer == null)
		{
			throw new EndOfStreamException("Target is null.");
		}
		if (count > buffer.Length)
		{
			throw new EndOfStreamException($"Count of {count} exceeds target length of {buffer.Length}.");
		}
		BlockCopy(ref buffer, 0, count);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public ArraySegment<byte> ReadArraySegment(int count)
	{
		ArraySegment<byte> result = new ArraySegment<byte>(_buffer, Position, count);
		Position += count;
		return result;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public sbyte ReadSByte()
	{
		return (sbyte)ReadByte();
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public char ReadChar()
	{
		return (char)ReadUInt16();
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public bool ReadBoolean()
	{
		if (ReadByte() != 1)
		{
			return false;
		}
		return true;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public ushort ReadUInt16()
	{
		return (ushort)((ushort)(0 | _buffer[Position++]) | (ushort)(_buffer[Position++] << 8));
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public short ReadInt16()
	{
		return (short)ReadUInt16();
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public uint ReadUInt32(AutoPackType packType = AutoPackType.Packed)
	{
		if (packType == AutoPackType.Packed)
		{
			return (uint)ReadPackedWhole();
		}
		return (uint)(0 | _buffer[Position++] | (_buffer[Position++] << 8) | (_buffer[Position++] << 16) | (_buffer[Position++] << 24));
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public int ReadInt32(AutoPackType packType = AutoPackType.Packed)
	{
		if (packType == AutoPackType.Packed)
		{
			return (int)ZigZagDecode(ReadPackedWhole());
		}
		return (int)ReadUInt32(packType);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public long ReadInt64(AutoPackType packType = AutoPackType.Packed)
	{
		if (packType == AutoPackType.Packed)
		{
			return (long)ZigZagDecode(ReadPackedWhole());
		}
		return (long)ReadUInt64(packType);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public ulong ReadUInt64(AutoPackType packType = AutoPackType.Packed)
	{
		if (packType == AutoPackType.Packed)
		{
			return ReadPackedWhole();
		}
		return 0uL | (ulong)_buffer[Position++] | ((ulong)_buffer[Position++] << 8) | ((ulong)_buffer[Position++] << 16) | ((ulong)_buffer[Position++] << 24) | ((ulong)_buffer[Position++] << 32) | ((ulong)_buffer[Position++] << 40) | ((ulong)_buffer[Position++] << 48) | ((ulong)_buffer[Position++] << 56);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public float ReadSingle(AutoPackType packType = AutoPackType.Unpacked)
	{
		if (packType == AutoPackType.Unpacked)
		{
			UIntFloat uIntFloat = new UIntFloat
			{
				UIntValue = ReadUInt32(AutoPackType.Unpacked)
			};
			return uIntFloat.FloatValue;
		}
		return (float)(long)ReadPackedWhole() / 100f;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public double ReadDouble()
	{
		UIntDouble uIntDouble = new UIntDouble
		{
			LongValue = ReadUInt64(AutoPackType.Unpacked)
		};
		return uIntDouble.DoubleValue;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public decimal ReadDecimal()
	{
		UIntDecimal uIntDecimal = new UIntDecimal
		{
			LongValue1 = ReadUInt64(AutoPackType.Unpacked),
			LongValue2 = ReadUInt64(AutoPackType.Unpacked)
		};
		return uIntDecimal.DecimalValue;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public string ReadString()
	{
		int num = ReadInt32();
		switch (num)
		{
		case -1:
			return null;
		case 0:
			return string.Empty;
		default:
			if (!CheckAllocationAttack(num))
			{
				return string.Empty;
			}
			return ReaderStatics.GetString(ReadArraySegment(num));
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public byte[] ReadBytesAndSizeAllocated()
	{
		int num = ReadInt32();
		if (num == -1)
		{
			return null;
		}
		return ReadBytesAllocated(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public int ReadBytesAndSize(ref byte[] target)
	{
		int num = ReadInt32();
		if (num > 0)
		{
			ReadBytes(ref target, num);
		}
		return num;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public ArraySegment<byte> ReadArraySegmentAndSize()
	{
		int num = ReadInt32();
		if (num == -1 || num == 0)
		{
			return default(ArraySegment<byte>);
		}
		return ReadArraySegment(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Vector2 ReadVector2()
	{
		return new Vector2(ReadSingle(), ReadSingle());
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Vector3 ReadVector3()
	{
		return new Vector3(ReadSingle(), ReadSingle(), ReadSingle());
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Vector4 ReadVector4()
	{
		return new Vector4(ReadSingle(), ReadSingle(), ReadSingle(), ReadSingle());
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Vector2Int ReadVector2Int(AutoPackType packType = AutoPackType.Packed)
	{
		return new Vector2Int(ReadInt32(packType), ReadInt32(packType));
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Vector3Int ReadVector3Int(AutoPackType packType = AutoPackType.Packed)
	{
		return new Vector3Int(ReadInt32(packType), ReadInt32(packType), ReadInt32(packType));
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Color ReadColor(AutoPackType packType = AutoPackType.Packed)
	{
		float r;
		float g;
		float b;
		float a;
		if (packType == AutoPackType.Unpacked)
		{
			r = ReadSingle();
			g = ReadSingle();
			b = ReadSingle();
			a = ReadSingle();
		}
		else
		{
			r = (float)(int)ReadByte() / 100f;
			g = (float)(int)ReadByte() / 100f;
			b = (float)(int)ReadByte() / 100f;
			a = (float)(int)ReadByte() / 100f;
		}
		return new Color(r, g, b, a);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Color32 ReadColor32()
	{
		return new Color32(ReadByte(), ReadByte(), ReadByte(), ReadByte());
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Quaternion ReadQuaternion(AutoPackType packType = AutoPackType.Packed)
	{
		return packType switch
		{
			AutoPackType.Packed => Quaternion32Compression.Decompress(ReadUInt32(AutoPackType.Unpacked)), 
			AutoPackType.PackedLess => Quaternion64Compression.Decompress(ReadUInt64(AutoPackType.Unpacked)), 
			_ => new Quaternion(ReadSingle(), ReadSingle(), ReadSingle(), ReadSingle()), 
		};
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Rect ReadRect()
	{
		return new Rect(ReadSingle(), ReadSingle(), ReadSingle(), ReadSingle());
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Plane ReadPlane()
	{
		return new Plane(ReadVector3(), ReadSingle());
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Ray ReadRay()
	{
		Vector3 origin = ReadVector3();
		Vector3 direction = ReadVector3();
		return new Ray(origin, direction);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Ray2D ReadRay2D()
	{
		Vector3 vector = ReadVector2();
		return new Ray2D(direction: ReadVector2(), origin: vector);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Matrix4x4 ReadMatrix4x4()
	{
		return new Matrix4x4
		{
			m00 = ReadSingle(),
			m01 = ReadSingle(),
			m02 = ReadSingle(),
			m03 = ReadSingle(),
			m10 = ReadSingle(),
			m11 = ReadSingle(),
			m12 = ReadSingle(),
			m13 = ReadSingle(),
			m20 = ReadSingle(),
			m21 = ReadSingle(),
			m22 = ReadSingle(),
			m23 = ReadSingle(),
			m30 = ReadSingle(),
			m31 = ReadSingle(),
			m32 = ReadSingle(),
			m33 = ReadSingle()
		};
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public byte[] ReadBytesAllocated(int count)
	{
		byte[] buffer = new byte[count];
		ReadBytes(ref buffer, count);
		return buffer;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Guid ReadGuid()
	{
		byte[] buffer = ReaderStatics.GetGuidBuffer();
		ReadBytes(ref buffer, 16);
		return new Guid(buffer);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public DateTime ReadDateTime()
	{
		return DateTime.FromBinary(ReadInt64());
	}

	public ulong ZigZagDecode(ulong value)
	{
		ulong num = value << 63;
		if (num != 0)
		{
			return ~(value >> 1) | num;
		}
		return value >> 1;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public ulong ReadPackedWhole()
	{
		byte b = ReadByte();
		ulong num = (ulong)(b & 0x7F);
		if ((b & 0x80) == 0)
		{
			return num;
		}
		b = ReadByte();
		num |= (ulong)((long)(b & 0x7F) << 7);
		if ((b & 0x80) == 0)
		{
			return num;
		}
		b = ReadByte();
		num |= (ulong)((long)(b & 0x7F) << 14);
		if ((b & 0x80) == 0)
		{
			return num;
		}
		b = ReadByte();
		num |= (ulong)((long)(b & 0x7F) << 21);
		if ((b & 0x80) == 0)
		{
			return num;
		}
		b = ReadByte();
		num |= (ulong)((long)(b & 0xF) << 28);
		switch (b >> 4)
		{
		case 1:
			num |= (ulong)ReadByte() << 32;
			break;
		case 2:
			num |= (ulong)ReadByte() << 32;
			num |= (ulong)ReadByte() << 40;
			break;
		case 3:
			num |= (ulong)ReadByte() << 32;
			num |= (ulong)ReadByte() << 40;
			num |= (ulong)ReadByte() << 48;
			break;
		case 4:
			num |= (ulong)ReadByte() << 32;
			num |= (ulong)ReadByte() << 40;
			num |= (ulong)ReadByte() << 48;
			num |= (ulong)ReadByte() << 56;
			break;
		}
		return num;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	private bool CheckAllocationAttack(int size)
	{
		if (size != -1 && size < 0)
		{
			Log.Error($"Size of {size} is invalid.");
			return false;
		}
		if (size > Remaining)
		{
			Log.Error($"Read size of {size} is larger than remaining data of {Remaining}.");
			return false;
		}
		return true;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public ListCache<T> ReadListCacheAllocated<T>()
	{
		List<T> collection = ReadListAllocated<T>();
		return new ListCache<T>
		{
			Collection = collection
		};
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public int ReadListCache<T>(ref ListCache<T> listCache)
	{
		listCache.Collection = ReadListAllocated<T>();
		return listCache.Collection.Count;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public List<T> ReadListAllocated<T>()
	{
		List<T> collection = null;
		ReadList(ref collection);
		return collection;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public int ReadList<T>(ref List<T> collection, bool allowNullification = false)
	{
		int num = ReadInt32();
		if (num == -1)
		{
			if (allowNullification)
			{
				collection = null;
			}
			return -1;
		}
		if (collection == null)
		{
			collection = new List<T>(num);
		}
		else
		{
			collection.Clear();
		}
		for (int i = 0; i < num; i++)
		{
			collection.Add(Read<T>());
		}
		return num;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T[] ReadArrayAllocated<T>()
	{
		T[] collection = null;
		ReadArray(ref collection);
		return collection;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public int ReadArray<T>(ref T[] collection)
	{
		int num = ReadInt32();
		switch (num)
		{
		case -1:
			return 0;
		case 0:
			if (collection == null)
			{
				collection = new T[0];
			}
			return 0;
		default:
		{
			if (collection == null)
			{
				collection = new T[num];
			}
			else if (collection.Length < num)
			{
				Array.Resize(ref collection, num);
			}
			for (int i = 0; i < num; i++)
			{
				collection[i] = Read<T>();
			}
			return num;
		}
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T Read<T>()
	{
		Type type = typeof(T);
		if (IsAutoPackType(type, out var packType))
		{
			Func<Reader, AutoPackType, T> readAutoPack = GenericReader<T>.ReadAutoPack;
			if (readAutoPack == null)
			{
				Log.Error(GetLogMessage());
				return default(T);
			}
			return readAutoPack(this, packType);
		}
		Func<Reader, T> read = GenericReader<T>.Read;
		if (read == null)
		{
			Log.Error(GetLogMessage());
			return default(T);
		}
		return read(this);
		string GetLogMessage()
		{
			return "Read method not found for " + type.FullName + ". Use a supported type or create a custom serializer.";
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	internal bool IsAutoPackType<T>(out AutoPackType packType)
	{
		return Writer.IsAutoPackType<T>(out packType);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	internal bool IsAutoPackType(Type type, out AutoPackType packType)
	{
		return Writer.IsAutoPackType(type, out packType);
	}
}
