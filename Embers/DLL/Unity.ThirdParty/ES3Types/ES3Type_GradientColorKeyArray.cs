using UnityEngine;

namespace ES3Types;

public class ES3Type_GradientColorKeyArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_GradientColorKeyArray()
		: base(typeof(GradientColorKey[]), ES3Type_GradientColorKey.Instance)
	{
		Instance = this;
	}
}
