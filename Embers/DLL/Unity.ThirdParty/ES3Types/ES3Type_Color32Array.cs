using UnityEngine;

namespace ES3Types;

public class ES3Type_Color32Array : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_Color32Array()
		: base(typeof(Color32[]), ES3Type_Color32.Instance)
	{
		Instance = this;
	}
}
