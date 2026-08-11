using UnityEngine;

namespace ES3Types;

public class ES3Type_BoundsArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_BoundsArray()
		: base(typeof(Bounds[]), ES3Type_Bounds.Instance)
	{
		Instance = this;
	}
}
