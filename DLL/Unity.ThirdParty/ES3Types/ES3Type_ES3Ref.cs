using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3Type_ES3Ref : ES3Type
{
	public static ES3Type Instance = new ES3Type_ES3Ref();

	public ES3Type_ES3Ref()
		: base(typeof(long))
	{
		isPrimitive = true;
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		writer.WritePrimitive(((long)obj).ToString());
	}

	public override object Read<T>(ES3Reader reader)
	{
		return (T)(object)new ES3Ref(reader.Read_ref());
	}
}
