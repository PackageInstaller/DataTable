using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3Type_bool : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_bool()
		: base(typeof(bool))
	{
		isPrimitive = true;
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		writer.WritePrimitive((bool)obj);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return (T)(object)reader.Read_bool();
	}
}
