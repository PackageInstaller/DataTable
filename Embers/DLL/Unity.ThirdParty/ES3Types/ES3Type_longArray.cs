namespace ES3Types;

public class ES3Type_longArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_longArray()
		: base(typeof(long[]), ES3Type_long.Instance)
	{
		Instance = this;
	}
}
