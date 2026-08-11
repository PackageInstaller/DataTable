namespace ES3Types;

public class ES3Type_charArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_charArray()
		: base(typeof(char[]), ES3Type_char.Instance)
	{
		Instance = this;
	}
}
