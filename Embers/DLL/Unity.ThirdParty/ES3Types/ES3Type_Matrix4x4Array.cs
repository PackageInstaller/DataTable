using UnityEngine;

namespace ES3Types;

public class ES3Type_Matrix4x4Array : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_Matrix4x4Array()
		: base(typeof(Matrix4x4[]), ES3Type_Matrix4x4.Instance)
	{
		Instance = this;
	}
}
