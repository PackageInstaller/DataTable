using UnityEngine;

namespace ES3Types;

public class ES3Type_ShaderArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_ShaderArray()
		: base(typeof(Shader[]), ES3Type_Shader.Instance)
	{
		Instance = this;
	}
}
