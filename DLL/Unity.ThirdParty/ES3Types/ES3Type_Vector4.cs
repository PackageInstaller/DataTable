using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "x", "y", "z", "w" })]
public class ES3Type_Vector4 : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Vector4()
		: base(typeof(Vector4))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Vector4 vector = (Vector4)obj;
		writer.WriteProperty("x", vector.x, ES3Type_float.Instance);
		writer.WriteProperty("y", vector.y, ES3Type_float.Instance);
		writer.WriteProperty("z", vector.z, ES3Type_float.Instance);
		writer.WriteProperty("w", vector.w, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Vector4(reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance));
	}

	public static bool Equals(Vector4 a, Vector4 b)
	{
		if (Mathf.Approximately(a.x, b.x) && Mathf.Approximately(a.y, b.y) && Mathf.Approximately(a.z, b.z))
		{
			return Mathf.Approximately(a.w, b.w);
		}
		return false;
	}
}
