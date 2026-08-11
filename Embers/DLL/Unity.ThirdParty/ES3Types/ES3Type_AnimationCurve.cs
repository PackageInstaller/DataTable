using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "keys", "preWrapMode", "postWrapMode" })]
public class ES3Type_AnimationCurve : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_AnimationCurve()
		: base(typeof(AnimationCurve))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		AnimationCurve animationCurve = (AnimationCurve)obj;
		writer.WriteProperty("keys", animationCurve.keys, ES3Type_KeyframeArray.Instance);
		writer.WriteProperty("preWrapMode", animationCurve.preWrapMode);
		writer.WriteProperty("postWrapMode", animationCurve.postWrapMode);
	}

	public override object Read<T>(ES3Reader reader)
	{
		AnimationCurve animationCurve = new AnimationCurve();
		ReadInto<T>(reader, animationCurve);
		return animationCurve;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		AnimationCurve animationCurve = (AnimationCurve)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "keys":
				animationCurve.keys = reader.Read<Keyframe[]>();
				break;
			case "preWrapMode":
				animationCurve.preWrapMode = reader.Read<WrapMode>();
				break;
			case "postWrapMode":
				animationCurve.postWrapMode = reader.Read<WrapMode>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
