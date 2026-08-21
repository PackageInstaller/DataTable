using UnityEngine;

namespace ES3Types;

public class ES3Type_Vector4Array : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_Vector4Array()
		: base(typeof(Vector4[]), ES3Type_Vector4.Instance)
	{
		Instance = this;
	}
}
