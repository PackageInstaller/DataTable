using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Ase.Serializing;

public static class WriterExtensions
{
	internal static HashSet<Type> DefaultPackedTypes;

	static WriterExtensions()
	{
		DefaultPackedTypes = new HashSet<Type>();
		DefaultPackedTypes.Add(typeof(int));
		DefaultPackedTypes.Add(typeof(uint));
		DefaultPackedTypes.Add(typeof(long));
		DefaultPackedTypes.Add(typeof(ulong));
		DefaultPackedTypes.Add(typeof(Color));
		DefaultPackedTypes.Add(typeof(Vector2Int));
		DefaultPackedTypes.Add(typeof(Vector3Int));
		DefaultPackedTypes.Add(typeof(Quaternion));
	}

	internal static void WriteUInt32(byte[] dst, uint value, ref int position)
	{
		dst[position++] = (byte)value;
		dst[position++] = (byte)(value >> 8);
		dst[position++] = (byte)(value >> 16);
		dst[position++] = (byte)(value >> 24);
	}

	internal static void WriteUInt64(byte[] dst, ulong value, ref int position)
	{
		dst[position++] = (byte)value;
		dst[position++] = (byte)(value >> 8);
		dst[position++] = (byte)(value >> 16);
		dst[position++] = (byte)(value >> 24);
		dst[position++] = (byte)(value >> 32);
		dst[position++] = (byte)(value >> 40);
		dst[position++] = (byte)(value >> 48);
		dst[position++] = (byte)(value >> 56);
	}

	public static bool SequenceEqual(this PooledWriter writer1, PooledWriter writer2)
	{
		return writer1.GetArraySegment().SequenceEqual(writer2.GetArraySegment());
	}
}
