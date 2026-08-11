using System.Numerics;

namespace ES3Types;

public class ES3Type_BigIntegerArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_BigIntegerArray()
		: base(typeof(BigInteger[]), ES3Type_BigInteger.Instance)
	{
		Instance = this;
	}
}
