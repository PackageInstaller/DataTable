using UnityEngine;

namespace ES3Types;

public class ES3Type_PhysicMaterialArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_PhysicMaterialArray()
		: base(typeof(PhysicMaterial[]), ES3Type_PhysicMaterial.Instance)
	{
		Instance = this;
	}
}
