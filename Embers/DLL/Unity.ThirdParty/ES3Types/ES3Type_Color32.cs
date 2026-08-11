using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "r", "g", "b", "a" })]
[Preserve]
public class ES3Type_Color32 : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Color32()
		: base(typeof(Color32))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Color32 color = (Color32)obj;
		writer.WriteProperty("r", color.r, ES3Type_byte.Instance);
		writer.WriteProperty("g", color.g, ES3Type_byte.Instance);
		writer.WriteProperty("b", color.b, ES3Type_byte.Instance);
		writer.WriteProperty("a", color.a, ES3Type_byte.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Color32(reader.ReadProperty<byte>(ES3Type_byte.Instance), reader.ReadProperty<byte>(ES3Type_byte.Instance), reader.ReadProperty<byte>(ES3Type_byte.Instance), reader.ReadProperty<byte>(ES3Type_byte.Instance));
	}

	public static bool Equals(Color32 a, Color32 b)
	{
		if (a.r != b.r || a.g != b.g || a.b != b.b || a.a != b.a)
		{
			return false;
		}
		return true;
	}
}
