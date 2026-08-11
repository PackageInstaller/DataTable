using UnityEngine;

namespace ES3Types;

public class ES3Type_Texture2DArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_Texture2DArray()
		: base(typeof(Texture2D[]), ES3Type_Texture2D.Instance)
	{
		Instance = this;
	}
}
