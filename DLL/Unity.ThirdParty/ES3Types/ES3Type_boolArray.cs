namespace ES3Types;

public class ES3Type_boolArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_boolArray()
		: base(typeof(bool[]), ES3Type_bool.Instance)
	{
		Instance = this;
	}
}
