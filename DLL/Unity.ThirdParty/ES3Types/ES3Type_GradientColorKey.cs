using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "color", "time" })]
public class ES3Type_GradientColorKey : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_GradientColorKey()
		: base(typeof(GradientColorKey))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		GradientColorKey gradientColorKey = (GradientColorKey)obj;
		writer.WriteProperty("color", gradientColorKey.color, ES3Type_Color.Instance);
		writer.WriteProperty("time", gradientColorKey.time, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new GradientColorKey(reader.ReadProperty<Color>(ES3Type_Color.Instance), reader.ReadProperty<float>(ES3Type_float.Instance));
	}
}
