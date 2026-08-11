using UnityEngine;

namespace ES3Types;

public class ES3Type_MaterialArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_MaterialArray()
		: base(typeof(Material[]), ES3Type_Material.Instance)
	{
		Instance = this;
	}
}
