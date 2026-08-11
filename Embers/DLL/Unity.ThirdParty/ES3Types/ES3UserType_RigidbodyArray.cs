using UnityEngine;

namespace ES3Types;

public class ES3UserType_RigidbodyArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3UserType_RigidbodyArray()
		: base(typeof(Rigidbody[]), ES3Type_Rigidbody.Instance)
	{
		Instance = this;
	}
}
