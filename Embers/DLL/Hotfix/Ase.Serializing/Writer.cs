#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Ase.Serializing.Helping;
using GameFramework;
using UnityEngine;

namespace Ase.Serializing;

public class Writer
{
	public int Position;

	public int Length;

	private byte[] _buffer = new byte[64];

	internal const byte REPLICATE_DEFAULT_BYTE = 0;

	internal const byte REPLICATE_DUPLICATE_BYTE = 1;

	internal const byte REPLICATE_UNIQUE_BYTE = 2;

	internal const byte REPLICATE_REPEATING_BYTE = 3;

	internal const byte REPLICATE_ALL_DEFAULT_BYTE = 4;

	public const int UNSET_COLLECTION_SIZE_VALUE = -1;

	public int Capacity => _buffer.Length;

	public void Reset()
	{
		Length = 0;
		Position = 0;
		Array.Clear(_buffer, 0, _buffer.Length);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteDictionary<TKey, TValue>(Dictionary<TKey, TValue> dict)
	{
		if (dict == null)
		{
			WriteBoolean(value: true);
			return;
		}
		WriteBoolean(value: false);
		WriteInt32(dict.Count);
		foreach (KeyValuePair<TKey, TValue> item in dict)
		{
			Write(item.Key);
			Write(item.Value);
		}
	}

	public void EnsureBufferCapacity(int count)
	{
		if (Capacity < count)
		{
			Array.Resize(ref _buffer, count);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void EnsureBufferLength(int count)
	{
		if (Position + count > _buffer.Length)
		{
			int newSize = _buffer.Length * 2 + count;
			Array.Resize(ref _buffer, newSize);
		}
	}

	public byte[] GetBuffer()
	{
		return _buffer;
	}

	public ArraySegment<byte> GetArraySegment()
	{
		return new ArraySegment<byte>(_buffer, 0, Length);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Reserve(int count)
	{
		EnsureBufferLength(count);
		Position += count;
		Length = Math.Max(Length, Position);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	internal void WriteLength(int length)
	{
		WriteInt32(length);
	}

	public void FastInsertByte(byte value, int index)
	{
		_buffer[index] = value;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteByte(byte value)
	{
		EnsureBufferLength(1);
		_buffer[Position++] = value;
		Length = Math.Max(Length, Position);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteBytes(byte[] value, int offset, int count)
	{
		EnsureBufferLength(count);
		Buffer.BlockCopy(value, offset, _buffer, Position, count);
		Position += count;
		Length = Math.Max(Length, Position);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteBytesAndSize(byte[] value, int offset, int count)
	{
		if (value == null)
		{
			WriteInt32(-1);
			return;
		}
		WriteInt32(count);
		WriteBytes(value, offset, count);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteBytesAndSize(byte[] value)
	{
		int count = ((value != null) ? value.Length : 0);
		WriteBytesAndSize(value, 0, count);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteSByte(sbyte value)
	{
		EnsureBufferLength(1);
		_buffer[Position++] = (byte)value;
		Length = Math.Max(Length, Position);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteChar(char value)
	{
		EnsureBufferLength(2);
		_buffer[Position++] = (byte)value;
		_buffer[Position++] = (byte)((int)value >> 8);
		Length = Math.Max(Length, Position);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteBoolean(bool value)
	{
		EnsureBufferLength(1);
		_buffer[Position++] = (byte)(value ? 1 : 0);
		Length = Math.Max(Length, Position);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUInt16(ushort value)
	{
		EnsureBufferLength(2);
		_buffer[Position++] = (byte)value;
		_buffer[Position++] = (byte)(value >> 8);
		Length = Math.Max(Length, Position);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteInt16(short value)
	{
		EnsureBufferLength(2);
		_buffer[Position++] = (byte)value;
		_buffer[Position++] = (byte)(value >> 8);
		Length = Math.Max(Length, Position);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteInt32(int value, AutoPackType packType = AutoPackType.Packed)
	{
		if (packType == AutoPackType.Packed)
		{
			WritePackedWhole(ZigZagEncode((ulong)value));
		}
		else
		{
			WriteUInt32((uint)value, packType);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUInt32(uint value, AutoPackType packType = AutoPackType.Packed)
	{
		if (packType == AutoPackType.Unpacked)
		{
			EnsureBufferLength(4);
			WriterExtensions.WriteUInt32(_buffer, value, ref Position);
			Length = Math.Max(Length, Position);
		}
		else
		{
			WritePackedWhole(value);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteInt64(long value, AutoPackType packType = AutoPackType.Packed)
	{
		if (packType == AutoPackType.Packed)
		{
			WritePackedWhole(ZigZagEncode((ulong)value));
		}
		else
		{
			WriteUInt64((ulong)value, packType);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUInt64(ulong value, AutoPackType packType = AutoPackType.Packed)
	{
		if (packType == AutoPackType.Unpacked)
		{
			EnsureBufferLength(8);
			_buffer[Position++] = (byte)value;
			_buffer[Position++] = (byte)(value >> 8);
			_buffer[Position++] = (byte)(value >> 16);
			_buffer[Position++] = (byte)(value >> 24);
			_buffer[Position++] = (byte)(value >> 32);
			_buffer[Position++] = (byte)(value >> 40);
			_buffer[Position++] = (byte)(value >> 48);
			_buffer[Position++] = (byte)(value >> 56);
			Length = Math.Max(Position, Length);
		}
		else
		{
			WritePackedWhole(value);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteSingle(float value, AutoPackType packType = AutoPackType.Unpacked)
	{
		if (packType == AutoPackType.Unpacked)
		{
			UIntFloat uIntFloat = new UIntFloat
			{
				FloatValue = value
			};
			WriteUInt32(uIntFloat.UIntValue, AutoPackType.Unpacked);
		}
		else
		{
			long value2 = (long)(value * 100f);
			WritePackedWhole((ulong)value2);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteDouble(double value)
	{
		UIntDouble uIntDouble = new UIntDouble
		{
			DoubleValue = value
		};
		WriteUInt64(uIntDouble.LongValue, AutoPackType.Unpacked);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteDecimal(decimal value)
	{
		UIntDecimal uIntDecimal = new UIntDecimal
		{
			DecimalValue = value
		};
		WriteUInt64(uIntDecimal.LongValue1, AutoPackType.Unpacked);
		WriteUInt64(uIntDecimal.LongValue2, AutoPackType.Unpacked);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteString(string value)
	{
		if (value == null)
		{
			WriteInt32(-1);
			return;
		}
		if (value.Length == 0)
		{
			WriteInt32(0);
			return;
		}
		byte[] stringBuffer = WriterStatics.GetStringBuffer(value, out var size);
		WriteInt32(size);
		WriteBytes(stringBuffer, 0, size);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteArraySegmentAndSize(ArraySegment<byte> value)
	{
		WriteBytesAndSize(value.Array, value.Offset, value.Count);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteArraySegment(ArraySegment<byte> value)
	{
		WriteBytes(value.Array, value.Offset, value.Count);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteVector2(Vector2 value)
	{
		UIntFloat uIntFloat = new UIntFloat
		{
			FloatValue = value.x
		};
		WriteUInt32(uIntFloat.UIntValue, AutoPackType.Unpacked);
		uIntFloat = new UIntFloat
		{
			FloatValue = value.y
		};
		WriteUInt32(uIntFloat.UIntValue, AutoPackType.Unpacked);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteVector3(Vector3 value)
	{
		UIntFloat uIntFloat = new UIntFloat
		{
			FloatValue = value.x
		};
		WriteUInt32(uIntFloat.UIntValue, AutoPackType.Unpacked);
		uIntFloat = new UIntFloat
		{
			FloatValue = value.y
		};
		WriteUInt32(uIntFloat.UIntValue, AutoPackType.Unpacked);
		uIntFloat = new UIntFloat
		{
			FloatValue = value.z
		};
		WriteUInt32(uIntFloat.UIntValue, AutoPackType.Unpacked);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteVector4(Vector4 value)
	{
		UIntFloat uIntFloat = new UIntFloat
		{
			FloatValue = value.x
		};
		WriteUInt32(uIntFloat.UIntValue, AutoPackType.Unpacked);
		uIntFloat = new UIntFloat
		{
			FloatValue = value.y
		};
		WriteUInt32(uIntFloat.UIntValue, AutoPackType.Unpacked);
		uIntFloat = new UIntFloat
		{
			FloatValue = value.z
		};
		WriteUInt32(uIntFloat.UIntValue, AutoPackType.Unpacked);
		uIntFloat = new UIntFloat
		{
			FloatValue = value.w
		};
		WriteUInt32(uIntFloat.UIntValue, AutoPackType.Unpacked);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteVector2Int(Vector2Int value, AutoPackType packType = AutoPackType.Packed)
	{
		WriteInt32(value.x, packType);
		WriteInt32(value.y, packType);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteVector3Int(Vector3Int value, AutoPackType packType = AutoPackType.Packed)
	{
		WriteInt32(value.x, packType);
		WriteInt32(value.y, packType);
		WriteInt32(value.z, packType);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteColor(Color value, AutoPackType packType = AutoPackType.Packed)
	{
		if (packType == AutoPackType.Unpacked)
		{
			WriteSingle(value.r);
			WriteSingle(value.g);
			WriteSingle(value.b);
			WriteSingle(value.a);
		}
		else
		{
			EnsureBufferLength(4);
			_buffer[Position++] = (byte)(value.r * 100f);
			_buffer[Position++] = (byte)(value.g * 100f);
			_buffer[Position++] = (byte)(value.b * 100f);
			_buffer[Position++] = (byte)(value.a * 100f);
			Length = Math.Max(Length, Position);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteColor32(Color32 value)
	{
		EnsureBufferLength(4);
		_buffer[Position++] = value.r;
		_buffer[Position++] = value.g;
		_buffer[Position++] = value.b;
		_buffer[Position++] = value.a;
		Length = Math.Max(Length, Position);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteQuaternion(Quaternion value, AutoPackType packType = AutoPackType.Packed)
	{
		switch (packType)
		{
		case AutoPackType.Packed:
		{
			EnsureBufferLength(4);
			uint value3 = Quaternion32Compression.Compress(value);
			WriterExtensions.WriteUInt32(_buffer, value3, ref Position);
			Length = Math.Max(Length, Position);
			break;
		}
		case AutoPackType.PackedLess:
		{
			EnsureBufferLength(8);
			ulong value2 = Quaternion64Compression.Compress(value);
			WriterExtensions.WriteUInt64(_buffer, value2, ref Position);
			Length = Math.Max(Length, Position);
			break;
		}
		default:
			EnsureBufferLength(16);
			WriteSingle(value.x);
			WriteSingle(value.y);
			WriteSingle(value.z);
			WriteSingle(value.w);
			break;
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteRect(Rect value)
	{
		WriteSingle(value.xMin);
		WriteSingle(value.yMin);
		WriteSingle(value.width);
		WriteSingle(value.height);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WritePlane(Plane value)
	{
		WriteVector3(value.normal);
		WriteSingle(value.distance);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteRay(Ray value)
	{
		WriteVector3(value.origin);
		WriteVector3(value.direction);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteRay2D(Ray2D value)
	{
		WriteVector2(value.origin);
		WriteVector2(value.direction);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteMatrix4x4(Matrix4x4 value)
	{
		WriteSingle(value.m00);
		WriteSingle(value.m01);
		WriteSingle(value.m02);
		WriteSingle(value.m03);
		WriteSingle(value.m10);
		WriteSingle(value.m11);
		WriteSingle(value.m12);
		WriteSingle(value.m13);
		WriteSingle(value.m20);
		WriteSingle(value.m21);
		WriteSingle(value.m22);
		WriteSingle(value.m23);
		WriteSingle(value.m30);
		WriteSingle(value.m31);
		WriteSingle(value.m32);
		WriteSingle(value.m33);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteGuidAllocated(Guid value)
	{
		byte[] array = value.ToByteArray();
		WriteBytes(array, 0, array.Length);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteDateTime(DateTime dt)
	{
		WriteInt64(dt.ToBinary());
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteListCache<T>(ListCache<T> lc)
	{
		WriteList(lc.Collection);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteList<T>(List<T> value)
	{
		if (value == null)
		{
			WriteList<T>(null, 0, 0);
		}
		else
		{
			WriteList(value, 0, value.Count);
		}
	}

	public ulong ZigZagEncode(ulong value)
	{
		if (value >> 63 != 0)
		{
			return ~(value << 1) | 1;
		}
		return value << 1;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WritePackedWhole(ulong value)
	{
		if (value < 128)
		{
			EnsureBufferLength(1);
			_buffer[Position++] = (byte)(value & 0x7F);
		}
		else if (value < 16384)
		{
			EnsureBufferLength(2);
			_buffer[Position++] = (byte)(0x80 | (value & 0x7F));
			_buffer[Position++] = (byte)((value >> 7) & 0x7F);
		}
		else if (value < 2097152)
		{
			EnsureBufferLength(3);
			_buffer[Position++] = (byte)(0x80 | (value & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 7) & 0x7F));
			_buffer[Position++] = (byte)((value >> 14) & 0x7F);
		}
		else if (value < 268435456)
		{
			EnsureBufferLength(4);
			_buffer[Position++] = (byte)(0x80 | (value & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 7) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 14) & 0x7F));
			_buffer[Position++] = (byte)((value >> 21) & 0x7F);
		}
		else if (value < 4294967296L)
		{
			EnsureBufferLength(5);
			_buffer[Position++] = (byte)(0x80 | (value & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 7) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 14) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 21) & 0x7F));
			_buffer[Position++] = (byte)((value >> 28) & 0xF);
		}
		else if (value < 1099511627776L)
		{
			EnsureBufferLength(6);
			_buffer[Position++] = (byte)(0x80 | (value & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 7) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 14) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 21) & 0x7F));
			_buffer[Position++] = (byte)(0x10 | ((value >> 28) & 0xF));
			_buffer[Position++] = (byte)((value >> 32) & 0xFF);
		}
		else if (value < 281474976710656L)
		{
			EnsureBufferLength(7);
			_buffer[Position++] = (byte)(0x80 | (value & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 7) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 14) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 21) & 0x7F));
			_buffer[Position++] = (byte)(0x20 | ((value >> 28) & 0xF));
			_buffer[Position++] = (byte)((value >> 32) & 0xFF);
			_buffer[Position++] = (byte)((value >> 40) & 0xFF);
		}
		else if (value < 72057594037927936L)
		{
			EnsureBufferLength(8);
			_buffer[Position++] = (byte)(0x80 | (value & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 7) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 14) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 21) & 0x7F));
			_buffer[Position++] = (byte)(0x30 | ((value >> 28) & 0xF));
			_buffer[Position++] = (byte)((value >> 32) & 0xFF);
			_buffer[Position++] = (byte)((value >> 40) & 0xFF);
			_buffer[Position++] = (byte)((value >> 48) & 0xFF);
		}
		else
		{
			EnsureBufferLength(9);
			_buffer[Position++] = (byte)(0x80 | (value & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 7) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 14) & 0x7F));
			_buffer[Position++] = (byte)(0x80 | ((value >> 21) & 0x7F));
			_buffer[Position++] = (byte)(0x40 | ((value >> 28) & 0xF));
			_buffer[Position++] = (byte)((value >> 32) & 0xFF);
			_buffer[Position++] = (byte)((value >> 40) & 0xFF);
			_buffer[Position++] = (byte)((value >> 48) & 0xFF);
			_buffer[Position++] = (byte)((value >> 56) & 0xFF);
		}
		Length = Math.Max(Length, Position);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteList<T>(List<T> value, int offset, int count)
	{
		if (value == null)
		{
			WriteInt32(-1);
			return;
		}
		if (offset + count > value.Count)
		{
			count = 0;
		}
		WriteInt32(count);
		for (int i = 0; i < count; i++)
		{
			Write(value[i + offset]);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteList<T>(List<T> value, int offset)
	{
		if (value == null)
		{
			WriteList<T>(null, 0, 0);
		}
		else
		{
			WriteList(value, offset, value.Count - offset);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	internal void WriteReplicate<T>(List<T> values, int offset)
	{
		int count = values.Count;
		byte value = (byte)(count - offset);
		WriteByte(value);
		Func<T, T, bool> compare = GeneratedComparer<T>.Compare;
		Func<T, bool> isDefault = GeneratedComparer<T>.IsDefault;
		if (compare == null || isDefault == null)
		{
			LogError("ReplicateComparers not found for type " + typeof(T).FullName);
			return;
		}
		T arg = default(T);
		byte value2 = 0;
		bool flag = true;
		bool flag2 = true;
		for (int i = offset; i < count; i++)
		{
			T val = values[i];
			if (!isDefault(val))
			{
				flag2 = false;
			}
			if (i > offset && !compare(val, values[i - 1]))
			{
				flag = false;
				break;
			}
		}
		if (flag2)
		{
			value2 = 4;
		}
		else if (flag)
		{
			value2 = 3;
		}
		WriteByte(value2);
		if (flag)
		{
			if (!flag2)
			{
				Write(values[offset]);
			}
			return;
		}
		for (int j = offset; j < count; j++)
		{
			T val2 = values[j];
			if (isDefault(val2))
			{
				WriteByte(0);
				continue;
			}
			if (compare(val2, arg))
			{
				WriteByte(1);
				continue;
			}
			WriteByte(2);
			Write(val2);
			arg = val2;
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteArray<T>(T[] value, int offset, int count)
	{
		if (value == null)
		{
			WriteInt32(-1);
			return;
		}
		if (value.Length == 0 || offset >= count)
		{
			WriteInt32(0);
			return;
		}
		WriteInt32(count);
		for (int i = offset; i < count; i++)
		{
			Write(value[i]);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteArray<T>(T[] value, int offset)
	{
		if (value == null)
		{
			WriteArray<T>(null, 0, 0);
		}
		else
		{
			WriteArray(value, offset, value.Length - offset);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteArray<T>(T[] value)
	{
		if (value == null)
		{
			WriteArray<T>(null, 0, 0);
		}
		else
		{
			WriteArray(value, 0, value.Length);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Write<T>(T value)
	{
		Type type = typeof(T);
		if (IsAutoPackType(type, out var packType))
		{
			Action<Writer, T, AutoPackType> writeAutoPack = GenericWriter<T>.WriteAutoPack;
			if (writeAutoPack == null)
			{
				LogError(GetLogMessage());
			}
			else
			{
				writeAutoPack(this, value, packType);
			}
		}
		else
		{
			Action<Writer, T> write = GenericWriter<T>.Write;
			if (write == null)
			{
				LogError(GetLogMessage());
			}
			else
			{
				write(this, value);
			}
		}
		string GetLogMessage()
		{
			return "Write method not found for " + type.FullName + ". Use a supported type or create a custom serializer.";
		}
	}

	private void LogError(string msg)
	{
		Log.Error(msg);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	internal static bool IsAutoPackType<T>(out AutoPackType packType)
	{
		return IsAutoPackType(typeof(T), out packType);
	}

	internal static bool IsAutoPackType(Type type, out AutoPackType packType)
	{
		if (WriterExtensions.DefaultPackedTypes.Contains(type))
		{
			packType = AutoPackType.Packed;
			return true;
		}
		if (type == typeof(float))
		{
			packType = AutoPackType.Unpacked;
			return true;
		}
		packType = AutoPackType.Unpacked;
		return false;
	}
}
