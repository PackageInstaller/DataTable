namespace ES3Types;

public class ES3Type_ES3RefArray : ES3ArrayType
{
	public static ES3Type Instance = new ES3Type_ES3RefArray();

	public ES3Type_ES3RefArray()
		: base(typeof(ES3Ref[]), ES3Type_ES3Ref.Instance)
	{
		Instance = this;
	}
}
