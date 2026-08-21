using UnityEngine;

namespace ES3Types;

public class ES3Type_GradientAlphaKeyArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_GradientAlphaKeyArray()
		: base(typeof(GradientAlphaKey[]), ES3Type_GradientAlphaKey.Instance)
	{
		Instance = this;
	}
}
