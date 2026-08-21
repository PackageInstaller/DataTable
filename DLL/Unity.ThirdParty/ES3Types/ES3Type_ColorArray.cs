using UnityEngine;

namespace ES3Types;

public class ES3Type_ColorArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_ColorArray()
		: base(typeof(Color[]), ES3Type_Color.Instance)
	{
		Instance = this;
	}
}
