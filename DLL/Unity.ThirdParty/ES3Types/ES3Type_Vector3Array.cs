using UnityEngine;

namespace ES3Types;

public class ES3Type_Vector3Array : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_Vector3Array()
		: base(typeof(Vector3[]), ES3Type_Vector3.Instance)
	{
		Instance = this;
	}
}
