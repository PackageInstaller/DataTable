using UnityEngine;

namespace ES3Types;

public class ES3Type_KeyframeArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_KeyframeArray()
		: base(typeof(Keyframe[]), ES3Type_Keyframe.Instance)
	{
		Instance = this;
	}
}
