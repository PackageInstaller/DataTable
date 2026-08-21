namespace ES3Types;

public class ES3Type_uintArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_uintArray()
		: base(typeof(uint[]), ES3Type_uint.Instance)
	{
		Instance = this;
	}
}
