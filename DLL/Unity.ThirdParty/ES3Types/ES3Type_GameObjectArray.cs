using UnityEngine;

namespace ES3Types;

public class ES3Type_GameObjectArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_GameObjectArray()
		: base(typeof(GameObject[]), ES3Type_GameObject.Instance)
	{
		Instance = this;
	}
}
