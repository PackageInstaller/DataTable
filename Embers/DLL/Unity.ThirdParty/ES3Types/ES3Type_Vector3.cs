using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "x", "y", "z" })]
public class ES3Type_Vector3 : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Vector3()
		: base(typeof(Vector3))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Vector3 vector = (Vector3)obj;
		writer.WriteProperty("x", vector.x, ES3Type_float.Instance);
		writer.WriteProperty("y", vector.y, ES3Type_float.Instance);
		writer.WriteProperty("z", vector.z, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Vector3(reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance));
	}
}
