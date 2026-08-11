using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "center", "size" })]
public class ES3Type_Bounds : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Bounds()
		: base(typeof(Bounds))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Bounds bounds = (Bounds)obj;
		writer.WriteProperty("center", bounds.center, ES3Type_Vector3.Instance);
		writer.WriteProperty("size", bounds.size, ES3Type_Vector3.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Bounds(reader.ReadProperty<Vector3>(ES3Type_Vector3.Instance), reader.ReadProperty<Vector3>(ES3Type_Vector3.Instance));
	}
}
