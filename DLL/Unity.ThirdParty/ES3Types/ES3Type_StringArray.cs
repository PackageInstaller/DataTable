namespace ES3Types;

public class ES3Type_StringArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_StringArray()
		: base(typeof(string[]), ES3Type_string.Instance)
	{
		Instance = this;
	}
}
