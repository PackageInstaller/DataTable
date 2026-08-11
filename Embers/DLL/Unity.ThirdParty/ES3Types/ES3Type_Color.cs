using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "r", "g", "b", "a" })]
public class ES3Type_Color : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Color()
		: base(typeof(Color))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Color color = (Color)obj;
		writer.WriteProperty("r", color.r, ES3Type_float.Instance);
		writer.WriteProperty("g", color.g, ES3Type_float.Instance);
		writer.WriteProperty("b", color.b, ES3Type_float.Instance);
		writer.WriteProperty("a", color.a, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Color(reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance));
	}
}
