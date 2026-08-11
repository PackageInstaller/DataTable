namespace ES3Types;

public class ES3Type_floatArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_floatArray()
		: base(typeof(float[]), ES3Type_float.Instance)
	{
		Instance = this;
	}
}
