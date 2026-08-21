using UnityEngine.UI;

namespace ES3Types;

public class ES3Type_ImageArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_ImageArray()
		: base(typeof(Image[]), ES3Type_Image.Instance)
	{
		Instance = this;
	}
}
