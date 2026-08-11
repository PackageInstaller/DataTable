using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "x", "y" })]
[Preserve]
public class ES3Type_Vector2 : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Vector2()
		: base(typeof(Vector2))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Vector2 vector = (Vector2)obj;
		writer.WriteProperty("x", vector.x, ES3Type_float.Instance);
		writer.WriteProperty("y", vector.y, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Vector2(reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance));
	}
}
