using UnityEngine;

namespace ES3Types;

public class ES3Type_FontArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_FontArray()
		: base(typeof(Font[]), ES3Type_Font.Instance)
	{
		Instance = this;
	}
}
