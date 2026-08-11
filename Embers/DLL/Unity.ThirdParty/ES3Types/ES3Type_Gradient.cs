using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "colorKeys", "alphaKeys", "mode" })]
public class ES3Type_Gradient : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Gradient()
		: base(typeof(Gradient))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Gradient gradient = (Gradient)obj;
		writer.WriteProperty("colorKeys", gradient.colorKeys, ES3Type_GradientColorKeyArray.Instance);
		writer.WriteProperty("alphaKeys", gradient.alphaKeys, ES3Type_GradientAlphaKeyArray.Instance);
		writer.WriteProperty("mode", gradient.mode);
	}

	public override object Read<T>(ES3Reader reader)
	{
		Gradient gradient = new Gradient();
		ReadInto<T>(reader, gradient);
		return gradient;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		Gradient gradient = (Gradient)obj;
		gradient.SetKeys(reader.ReadProperty<GradientColorKey[]>(ES3Type_GradientColorKeyArray.Instance), reader.ReadProperty<GradientAlphaKey[]>(ES3Type_GradientAlphaKeyArray.Instance));
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			if (text == "mode")
			{
				gradient.mode = reader.Read<GradientMode>();
			}
			else
			{
				reader.Skip();
			}
		}
	}
}
