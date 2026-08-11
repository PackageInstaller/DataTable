using UnityEngine;

namespace ES3Types;

public class ES3Type_BoneWeightArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_BoneWeightArray()
		: base(typeof(BoneWeight[]), ES3Type_BoneWeight.Instance)
	{
		Instance = this;
	}
}
