using System;

namespace ES3Types;

public class ES3Type_DateTimeArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_DateTimeArray()
		: base(typeof(DateTime[]), ES3Type_DateTime.Instance)
	{
		Instance = this;
	}
}
