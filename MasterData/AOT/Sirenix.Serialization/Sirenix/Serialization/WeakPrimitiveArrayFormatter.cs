using System;
using System.Collections.Generic;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public sealed class WeakPrimitiveArrayFormatter : WeakMinimalBaseFormatter
{
	public enum PrimitiveArrayType
	{
		PrimitiveArray_char,
		PrimitiveArray_sbyte,
		PrimitiveArray_short,
		PrimitiveArray_int,
		PrimitiveArray_long,
		PrimitiveArray_byte,
		PrimitiveArray_ushort,
		PrimitiveArray_uint,
		PrimitiveArray_ulong,
		PrimitiveArray_decimal,
		PrimitiveArray_bool,
		PrimitiveArray_float,
		PrimitiveArray_double,
		PrimitiveArray_Guid
	}

	private static readonly Dictionary<Type, PrimitiveArrayType> PrimitiveTypes = new Dictionary<Type, PrimitiveArrayType>(FastTypeComparer.Instance)
	{
		{
			typeof(char),
			PrimitiveArrayType.PrimitiveArray_char
		},
		{
			typeof(sbyte),
			PrimitiveArrayType.PrimitiveArray_sbyte
		},
		{
			typeof(short),
			PrimitiveArrayType.PrimitiveArray_short
		},
		{
			typeof(int),
			PrimitiveArrayType.PrimitiveArray_int
		},
		{
			typeof(long),
			PrimitiveArrayType.PrimitiveArray_long
		},
		{
			typeof(byte),
			PrimitiveArrayType.PrimitiveArray_byte
		},
		{
			typeof(ushort),
			PrimitiveArrayType.PrimitiveArray_ushort
		},
		{
			typeof(uint),
			PrimitiveArrayType.PrimitiveArray_uint
		},
		{
			typeof(ulong),
			PrimitiveArrayType.PrimitiveArray_ulong
		},
		{
			typeof(decimal),
			PrimitiveArrayType.PrimitiveArray_decimal
		},
		{
			typeof(bool),
			PrimitiveArrayType.PrimitiveArray_bool
		},
		{
			typeof(float),
			PrimitiveArrayType.PrimitiveArray_float
		},
		{
			typeof(double),
			PrimitiveArrayType.PrimitiveArray_double
		},
		{
			typeof(Guid),
			PrimitiveArrayType.PrimitiveArray_Guid
		}
	};

	private readonly Type ElementType;

	private readonly PrimitiveArrayType PrimitiveType;

	public WeakPrimitiveArrayFormatter(Type arrayType, Type elementType)
		: base(arrayType)
	{
		ElementType = elementType;
		if (!PrimitiveTypes.TryGetValue(elementType, out PrimitiveType))
		{
			throw new SerializationAbortException("The type '" + elementType.GetNiceFullName() + "' is not a type that can be written as a primitive array, yet the primitive array formatter is being used for it.");
		}
	}

	protected override object GetUninitializedObject()
	{
		return null;
	}

	protected override void Read(ref object value, IDataReader reader)
	{
		if (reader.PeekEntry(out var _) == EntryType.PrimitiveArray)
		{
			switch (PrimitiveType)
			{
			case PrimitiveArrayType.PrimitiveArray_char:
			{
				reader.ReadPrimitiveArray<char>(out var array14);
				value = array14;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_sbyte:
			{
				reader.ReadPrimitiveArray<sbyte>(out var array13);
				value = array13;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_short:
			{
				reader.ReadPrimitiveArray<short>(out var array12);
				value = array12;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_int:
			{
				reader.ReadPrimitiveArray<int>(out var array11);
				value = array11;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_long:
			{
				reader.ReadPrimitiveArray<long>(out var array10);
				value = array10;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_byte:
			{
				reader.ReadPrimitiveArray<byte>(out var array9);
				value = array9;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_ushort:
			{
				reader.ReadPrimitiveArray<ushort>(out var array8);
				value = array8;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_uint:
			{
				reader.ReadPrimitiveArray<uint>(out var array7);
				value = array7;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_ulong:
			{
				reader.ReadPrimitiveArray<ulong>(out var array6);
				value = array6;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_decimal:
			{
				reader.ReadPrimitiveArray<decimal>(out var array5);
				value = array5;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_bool:
			{
				reader.ReadPrimitiveArray<bool>(out var array4);
				value = array4;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_float:
			{
				reader.ReadPrimitiveArray<float>(out var array3);
				value = array3;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_double:
			{
				reader.ReadPrimitiveArray<double>(out var array2);
				value = array2;
				break;
			}
			case PrimitiveArrayType.PrimitiveArray_Guid:
			{
				reader.ReadPrimitiveArray<Guid>(out var array);
				value = array;
				break;
			}
			default:
				throw new NotImplementedException();
			}
			RegisterReferenceID(value, reader);
		}
		else
		{
			reader.SkipEntry();
		}
	}

	protected override void Write(ref object value, IDataWriter writer)
	{
		switch (PrimitiveType)
		{
		case PrimitiveArrayType.PrimitiveArray_char:
			writer.WritePrimitiveArray((char[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_sbyte:
			writer.WritePrimitiveArray((sbyte[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_short:
			writer.WritePrimitiveArray((short[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_int:
			writer.WritePrimitiveArray((int[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_long:
			writer.WritePrimitiveArray((long[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_byte:
			writer.WritePrimitiveArray((byte[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_ushort:
			writer.WritePrimitiveArray((ushort[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_uint:
			writer.WritePrimitiveArray((uint[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_ulong:
			writer.WritePrimitiveArray((ulong[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_decimal:
			writer.WritePrimitiveArray((decimal[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_bool:
			writer.WritePrimitiveArray((bool[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_float:
			writer.WritePrimitiveArray((float[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_double:
			writer.WritePrimitiveArray((double[])value);
			break;
		case PrimitiveArrayType.PrimitiveArray_Guid:
			writer.WritePrimitiveArray((Guid[])value);
			break;
		}
	}
}
