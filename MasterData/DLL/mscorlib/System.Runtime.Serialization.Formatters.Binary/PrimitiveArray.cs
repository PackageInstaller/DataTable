using System.Globalization;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class PrimitiveArray
{
	private InternalPrimitiveTypeE code;

	private bool[] booleanA;

	private char[] charA;

	private double[] doubleA;

	private short[] int16A;

	private int[] int32A;

	private long[] int64A;

	private sbyte[] sbyteA;

	private float[] singleA;

	private ushort[] uint16A;

	private uint[] uint32A;

	private ulong[] uint64A;

	internal PrimitiveArray(InternalPrimitiveTypeE code, Array array)
	{
		Init(code, array);
	}

	internal void Init(InternalPrimitiveTypeE code, Array array)
	{
		this.code = code;
		switch (code)
		{
		case InternalPrimitiveTypeE.Boolean:
			booleanA = (bool[])array;
			break;
		case InternalPrimitiveTypeE.Char:
			charA = (char[])array;
			break;
		case InternalPrimitiveTypeE.Double:
			doubleA = (double[])array;
			break;
		case InternalPrimitiveTypeE.Int16:
			int16A = (short[])array;
			break;
		case InternalPrimitiveTypeE.Int32:
			int32A = (int[])array;
			break;
		case InternalPrimitiveTypeE.Int64:
			int64A = (long[])array;
			break;
		case InternalPrimitiveTypeE.SByte:
			sbyteA = (sbyte[])array;
			break;
		case InternalPrimitiveTypeE.Single:
			singleA = (float[])array;
			break;
		case InternalPrimitiveTypeE.UInt16:
			uint16A = (ushort[])array;
			break;
		case InternalPrimitiveTypeE.UInt32:
			uint32A = (uint[])array;
			break;
		case InternalPrimitiveTypeE.UInt64:
			uint64A = (ulong[])array;
			break;
		case InternalPrimitiveTypeE.Byte:
		case InternalPrimitiveTypeE.Currency:
		case InternalPrimitiveTypeE.Decimal:
		case InternalPrimitiveTypeE.TimeSpan:
		case InternalPrimitiveTypeE.DateTime:
			break;
		}
	}

	internal void SetValue(string value, int index)
	{
		switch (code)
		{
		case InternalPrimitiveTypeE.Boolean:
			booleanA[index] = bool.Parse(value);
			break;
		case InternalPrimitiveTypeE.Char:
			if (value[0] == '_' && value.Equals("_0x00_"))
			{
				charA[index] = '\0';
			}
			else
			{
				charA[index] = char.Parse(value);
			}
			break;
		case InternalPrimitiveTypeE.Double:
			doubleA[index] = double.Parse(value, CultureInfo.InvariantCulture);
			break;
		case InternalPrimitiveTypeE.Int16:
			int16A[index] = short.Parse(value, CultureInfo.InvariantCulture);
			break;
		case InternalPrimitiveTypeE.Int32:
			int32A[index] = int.Parse(value, CultureInfo.InvariantCulture);
			break;
		case InternalPrimitiveTypeE.Int64:
			int64A[index] = long.Parse(value, CultureInfo.InvariantCulture);
			break;
		case InternalPrimitiveTypeE.SByte:
			sbyteA[index] = sbyte.Parse(value, CultureInfo.InvariantCulture);
			break;
		case InternalPrimitiveTypeE.Single:
			singleA[index] = float.Parse(value, CultureInfo.InvariantCulture);
			break;
		case InternalPrimitiveTypeE.UInt16:
			uint16A[index] = ushort.Parse(value, CultureInfo.InvariantCulture);
			break;
		case InternalPrimitiveTypeE.UInt32:
			uint32A[index] = uint.Parse(value, CultureInfo.InvariantCulture);
			break;
		case InternalPrimitiveTypeE.UInt64:
			uint64A[index] = ulong.Parse(value, CultureInfo.InvariantCulture);
			break;
		case InternalPrimitiveTypeE.Byte:
		case InternalPrimitiveTypeE.Currency:
		case InternalPrimitiveTypeE.Decimal:
		case InternalPrimitiveTypeE.TimeSpan:
		case InternalPrimitiveTypeE.DateTime:
			break;
		}
	}
}
