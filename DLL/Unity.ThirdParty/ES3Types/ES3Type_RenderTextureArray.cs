using UnityEngine;

namespace ES3Types;

public class ES3Type_RenderTextureArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_RenderTextureArray()
		: base(typeof(RenderTexture[]), ES3Type_RenderTexture.Instance)
	{
		Instance = this;
	}
}
