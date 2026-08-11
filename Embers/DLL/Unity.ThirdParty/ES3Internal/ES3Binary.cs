using System;
using System.Collections.Generic;

namespace ES3Internal;

internal static class ES3Binary
{
	internal const string ObjectTerminator = ".";

	internal static readonly Dictionary<ES3SpecialByte, Type> IdToType = new Dictionary<ES3SpecialByte, Type>
	{
		{
			ES3SpecialByte.Null,
			null
		},
		{
			ES3SpecialByte.Bool,
			typeof(bool)
		},
		{
			ES3SpecialByte.Byte,
			typeof(byte)
		},
		{
			ES3SpecialByte.Sbyte,
			typeof(sbyte)
		},
		{
			ES3SpecialByte.Char,
			typeof(char)
		},
		{
			ES3SpecialByte.Decimal,
			typeof(decimal)
		},
		{
			ES3SpecialByte.Double,
			typeof(double)
		},
		{
			ES3SpecialByte.Float,
			typeof(float)
		},
		{
			ES3SpecialByte.Int,
			typeof(int)
		},
		{
			ES3SpecialByte.Uint,
			typeof(uint)
		},
		{
			ES3SpecialByte.Long,
			typeof(long)
		},
		{
			ES3SpecialByte.Ulong,
			typeof(ulong)
		},
		{
			ES3SpecialByte.Short,
			typeof(short)
		},
		{
			ES3SpecialByte.Ushort,
			typeof(ushort)
		},
		{
			ES3SpecialByte.String,
			typeof(string)
		},
		{
			ES3SpecialByte.ByteArray,
			typeof(byte[])
		}
	};

	internal static readonly Dictionary<Type, ES3SpecialByte> TypeToId = new Dictionary<Type, ES3SpecialByte>
	{
		{
			typeof(bool),
			ES3SpecialByte.Bool
		},
		{
			typeof(byte),
			ES3SpecialByte.Byte
		},
		{
			typeof(sbyte),
			ES3SpecialByte.Sbyte
		},
		{
			typeof(char),
			ES3SpecialByte.Char
		},
		{
			typeof(decimal),
			ES3SpecialByte.Decimal
		},
		{
			typeof(double),
			ES3SpecialByte.Double
		},
		{
			typeof(float),
			ES3SpecialByte.Float
		},
		{
			typeof(int),
			ES3SpecialByte.Int
		},
		{
			typeof(uint),
			ES3SpecialByte.Uint
		},
		{
			typeof(long),
			ES3SpecialByte.Long
		},
		{
			typeof(ulong),
			ES3SpecialByte.Ulong
		},
		{
			typeof(short),
			ES3SpecialByte.Short
		},
		{
			typeof(ushort),
			ES3SpecialByte.Ushort
		},
		{
			typeof(string),
			ES3SpecialByte.String
		},
		{
			typeof(byte[]),
			ES3SpecialByte.ByteArray
		}
	};

	internal static ES3SpecialByte TypeToByte(Type type)
	{
		if (TypeToId.TryGetValue(type, out var value))
		{
			return value;
		}
		return ES3SpecialByte.Object;
	}

	internal static Type ByteToType(ES3SpecialByte b)
	{
		return ByteToType((byte)b);
	}

	internal static Type ByteToType(byte b)
	{
		if (IdToType.TryGetValue((ES3SpecialByte)b, out var value))
		{
			return value;
		}
		return typeof(object);
	}

	internal static bool IsPrimitive(ES3SpecialByte b)
	{
		if (b - 1 <= ES3SpecialByte.String)
		{
			return true;
		}
		return false;
	}
}
