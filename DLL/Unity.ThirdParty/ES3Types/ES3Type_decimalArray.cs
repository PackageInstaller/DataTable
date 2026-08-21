namespace ES3Types;

public class ES3Type_decimalArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_decimalArray()
		: base(typeof(decimal[]), ES3Type_decimal.Instance)
	{
		Instance = this;
	}
}
