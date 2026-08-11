using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "col0", "col1", "col2", "col3" })]
public class ES3Type_Matrix4x4 : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Matrix4x4()
		: base(typeof(Matrix4x4))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Matrix4x4 matrix4x = (Matrix4x4)obj;
		writer.WriteProperty("col0", matrix4x.GetColumn(0), ES3Type_Vector4.Instance);
		writer.WriteProperty("col1", matrix4x.GetColumn(1), ES3Type_Vector4.Instance);
		writer.WriteProperty("col2", matrix4x.GetColumn(2), ES3Type_Vector4.Instance);
		writer.WriteProperty("col3", matrix4x.GetColumn(3), ES3Type_Vector4.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		Matrix4x4 matrix4x = default(Matrix4x4);
		matrix4x.SetColumn(0, reader.ReadProperty<Vector4>(ES3Type_Vector4.Instance));
		matrix4x.SetColumn(1, reader.ReadProperty<Vector4>(ES3Type_Vector4.Instance));
		matrix4x.SetColumn(2, reader.ReadProperty<Vector4>(ES3Type_Vector4.Instance));
		matrix4x.SetColumn(3, reader.ReadProperty<Vector4>(ES3Type_Vector4.Instance));
		return matrix4x;
	}
}
