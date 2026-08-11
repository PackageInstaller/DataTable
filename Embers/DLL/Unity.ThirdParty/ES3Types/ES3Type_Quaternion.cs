using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "x", "y", "z", "w" })]
public class ES3Type_Quaternion : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Quaternion()
		: base(typeof(Quaternion))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Quaternion quaternion = (Quaternion)obj;
		writer.WriteProperty("x", quaternion.x, ES3Type_float.Instance);
		writer.WriteProperty("y", quaternion.y, ES3Type_float.Instance);
		writer.WriteProperty("z", quaternion.z, ES3Type_float.Instance);
		writer.WriteProperty("w", quaternion.w, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Quaternion(reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance));
	}
}
