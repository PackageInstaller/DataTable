using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "x", "y", "z" })]
public class ES3Type_Vector3Int : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Vector3Int()
		: base(typeof(Vector3Int))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Vector3Int vector3Int = (Vector3Int)obj;
		writer.WriteProperty("x", vector3Int.x, ES3Type_int.Instance);
		writer.WriteProperty("y", vector3Int.y, ES3Type_int.Instance);
		writer.WriteProperty("z", vector3Int.z, ES3Type_int.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Vector3Int(reader.ReadProperty<int>(ES3Type_int.Instance), reader.ReadProperty<int>(ES3Type_int.Instance), reader.ReadProperty<int>(ES3Type_int.Instance));
	}
}
