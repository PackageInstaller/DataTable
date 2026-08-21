using UnityEngine;

namespace ES3Types;

public class ES3Type_Vector2Array : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_Vector2Array()
		: base(typeof(Vector2[]), ES3Type_Vector2.Instance)
	{
		Instance = this;
	}
}
