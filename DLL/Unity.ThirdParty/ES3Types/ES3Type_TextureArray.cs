using UnityEngine;

namespace ES3Types;

public class ES3Type_TextureArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_TextureArray()
		: base(typeof(Texture[]), ES3Type_Texture.Instance)
	{
		Instance = this;
	}
}
