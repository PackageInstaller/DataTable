using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "alpha", "time" })]
public class ES3Type_GradientAlphaKey : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_GradientAlphaKey()
		: base(typeof(GradientAlphaKey))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		GradientAlphaKey gradientAlphaKey = (GradientAlphaKey)obj;
		writer.WriteProperty("alpha", gradientAlphaKey.alpha, ES3Type_float.Instance);
		writer.WriteProperty("time", gradientAlphaKey.time, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new GradientAlphaKey(reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance));
	}
}
