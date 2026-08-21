using System;

namespace ES3Types;

public class ES3Type_UIntPtrArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_UIntPtrArray()
		: base(typeof(UIntPtr[]), ES3Type_UIntPtr.Instance)
	{
		Instance = this;
	}
}
