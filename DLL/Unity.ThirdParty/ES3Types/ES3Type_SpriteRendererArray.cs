using UnityEngine;

namespace ES3Types;

public class ES3Type_SpriteRendererArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_SpriteRendererArray()
		: base(typeof(SpriteRenderer[]), ES3Type_SpriteRenderer.Instance)
	{
		Instance = this;
	}
}
