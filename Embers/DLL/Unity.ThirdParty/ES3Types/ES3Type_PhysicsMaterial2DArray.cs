using UnityEngine;

namespace ES3Types;

public class ES3Type_PhysicsMaterial2DArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_PhysicsMaterial2DArray()
		: base(typeof(PhysicsMaterial2D[]), ES3Type_PhysicsMaterial2D.Instance)
	{
		Instance = this;
	}
}
