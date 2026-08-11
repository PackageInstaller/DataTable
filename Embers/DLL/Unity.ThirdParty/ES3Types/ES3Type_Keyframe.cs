using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "time", "value", "inTangent", "outTangent" })]
public class ES3Type_Keyframe : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Keyframe()
		: base(typeof(Keyframe))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Keyframe keyframe = (Keyframe)obj;
		writer.WriteProperty("time", keyframe.time, ES3Type_float.Instance);
		writer.WriteProperty("value", keyframe.value, ES3Type_float.Instance);
		writer.WriteProperty("inTangent", keyframe.inTangent, ES3Type_float.Instance);
		writer.WriteProperty("outTangent", keyframe.outTangent, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new Keyframe(reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance), reader.ReadProperty<float>(ES3Type_float.Instance));
	}
}
