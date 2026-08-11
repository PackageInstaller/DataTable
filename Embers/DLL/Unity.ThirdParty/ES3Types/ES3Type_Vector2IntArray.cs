using UnityEngine;

namespace ES3Types;

public class ES3Type_Vector2IntArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_Vector2IntArray()
		: base(typeof(Vector2Int[]), ES3Type_Vector2Int.Instance)
	{
		Instance = this;
	}
}
