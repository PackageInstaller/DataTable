using UnityEngine;

namespace ES3Types;

public class ES3Type_Vector3IntArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_Vector3IntArray()
		: base(typeof(Vector3Int[]), ES3Type_Vector3Int.Instance)
	{
		Instance = this;
	}
}
