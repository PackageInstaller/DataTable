using UnityEngine;

namespace ES3Types;

public class ES3Type_QuaternionArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_QuaternionArray()
		: base(typeof(Quaternion[]), ES3Type_Quaternion.Instance)
	{
		Instance = this;
	}
}
