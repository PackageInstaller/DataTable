using UnityEngine;

namespace ES3Types;

public class ES3Type_SkinnedMeshRendererArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_SkinnedMeshRendererArray()
		: base(typeof(SkinnedMeshRenderer[]), ES3Type_SkinnedMeshRenderer.Instance)
	{
		Instance = this;
	}
}
