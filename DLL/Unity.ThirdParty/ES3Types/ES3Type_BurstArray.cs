using UnityEngine;

namespace ES3Types;

public class ES3Type_BurstArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_BurstArray()
		: base(typeof(Burst[]), ES3Type_Burst.Instance)
	{
		Instance = this;
	}
}
