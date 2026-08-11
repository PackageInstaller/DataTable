using UnityEngine;

namespace ES3Types;

public class ES3Type_MeshFilterArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_MeshFilterArray()
		: base(typeof(MeshFilter[]), ES3Type_MeshFilter.Instance)
	{
		Instance = this;
	}
}
