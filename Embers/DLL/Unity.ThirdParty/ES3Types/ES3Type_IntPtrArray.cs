using System;

namespace ES3Types;

public class ES3Type_IntPtrArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_IntPtrArray()
		: base(typeof(IntPtr[]), ES3Type_IntPtr.Instance)
	{
		Instance = this;
	}
}
