namespace ES3Types;

public class ES3Type_ushortArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_ushortArray()
		: base(typeof(ushort[]), ES3Type_ushort.Instance)
	{
		Instance = this;
	}
}
