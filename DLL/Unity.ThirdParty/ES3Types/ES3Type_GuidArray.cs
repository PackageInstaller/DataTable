using System;

namespace ES3Types;

public class ES3Type_GuidArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_GuidArray()
		: base(typeof(Guid[]), ES3Type_Guid.Instance)
	{
		Instance = this;
	}
}
