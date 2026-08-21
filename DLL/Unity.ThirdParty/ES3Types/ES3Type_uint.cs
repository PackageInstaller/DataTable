using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3Type_uint : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_uint()
		: base(typeof(uint))
	{
		isPrimitive = true;
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		writer.WritePrimitive((uint)obj);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return (T)(object)reader.Read_uint();
	}
}
