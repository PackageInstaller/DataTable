namespace ES3Types;

public class ES3Type_shortArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_shortArray()
		: base(typeof(short[]), ES3Type_short.Instance)
	{
		Instance = this;
	}
}
