using UnityEngine;

namespace ES3Types;

public class ES3Type_FlareArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_FlareArray()
		: base(typeof(Flare[]), ES3Type_Flare.Instance)
	{
		Instance = this;
	}
}
