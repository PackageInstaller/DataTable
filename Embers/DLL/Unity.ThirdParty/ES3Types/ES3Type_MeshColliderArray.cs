using UnityEngine;

namespace ES3Types;

public class ES3Type_MeshColliderArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_MeshColliderArray()
		: base(typeof(MeshCollider[]), ES3Type_MeshCollider.Instance)
	{
		Instance = this;
	}
}
