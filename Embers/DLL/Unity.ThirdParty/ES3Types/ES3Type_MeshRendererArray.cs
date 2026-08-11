using UnityEngine;

namespace ES3Types;

public class ES3Type_MeshRendererArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_MeshRendererArray()
		: base(typeof(MeshRenderer[]), ES3Type_MeshRenderer.Instance)
	{
		Instance = this;
	}
}
