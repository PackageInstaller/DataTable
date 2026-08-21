using UnityEngine.UI;

namespace ES3Types;

public class ES3Type_RawImageArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_RawImageArray()
		: base(typeof(RawImage[]), ES3Type_RawImage.Instance)
	{
		Instance = this;
	}
}
