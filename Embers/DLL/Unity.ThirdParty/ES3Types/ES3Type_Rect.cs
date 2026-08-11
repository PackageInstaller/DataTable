using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "x", "y", "width", "height" })]
[Preserve]
public class ES3Type_Rect : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Rect()
		: base(typeof(Rect))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Rect rect = (Rect)obj;
		writer.WriteProperty("x", rect.x, ES3Type_float.Instance);
		writer.WriteProperty("y", rect.y, ES3Type_float.Instance);
		writer.WriteProperty("width", rect.width, ES3Type_float.Instance);
		writer.WriteProperty("height", rect.height, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Rect(reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance));
	}
}
