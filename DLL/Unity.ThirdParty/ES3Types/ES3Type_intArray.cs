namespace ES3Types;

public class ES3Type_intArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_intArray()
		: base(typeof(int[]), ES3Type_int.Instance)
	{
		Instance = this;
	}
}
