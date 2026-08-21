using UnityEngine;

namespace ES3Types;

public class ES3Type_PolygonCollider2DArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_PolygonCollider2DArray()
		: base(typeof(PolygonCollider2D[]), ES3Type_PolygonCollider2D.Instance)
	{
		Instance = this;
	}
}
