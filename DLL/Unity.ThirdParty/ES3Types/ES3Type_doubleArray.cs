namespace ES3Types;

public class ES3Type_doubleArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_doubleArray()
		: base(typeof(double[]), ES3Type_double.Instance)
	{
		Instance = this;
	}
}
