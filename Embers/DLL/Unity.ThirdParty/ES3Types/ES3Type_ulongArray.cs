namespace ES3Types;

public class ES3Type_ulongArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_ulongArray()
		: base(typeof(ulong[]), ES3Type_ulong.Instance)
	{
		Instance = this;
	}
}
