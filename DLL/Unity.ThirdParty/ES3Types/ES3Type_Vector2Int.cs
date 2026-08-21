using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "x", "y" })]
public class ES3Type_Vector2Int : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Vector2Int()
		: base(typeof(Vector2Int))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Vector2Int vector2Int = (Vector2Int)obj;
		writer.WriteProperty("x", vector2Int.x, ES3Type_int.Instance);
		writer.WriteProperty("y", vector2Int.y, ES3Type_int.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Vector2Int(reader.ReadProperty<int>(ES3Type_int.Instance), reader.ReadProperty<int>(ES3Type_int.Instance));
	}
}
