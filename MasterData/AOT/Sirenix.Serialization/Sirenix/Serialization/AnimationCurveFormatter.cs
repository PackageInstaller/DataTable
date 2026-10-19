using UnityEngine;

namespace Sirenix.Serialization;

public class AnimationCurveFormatter : MinimalBaseFormatter<AnimationCurve>
{
	private static readonly Serializer<Keyframe[]> KeyframeSerializer = Serializer.Get<Keyframe[]>();

	private static readonly Serializer<WrapMode> WrapModeSerializer = Serializer.Get<WrapMode>();

	protected override AnimationCurve GetUninitializedObject()
	{
		return null;
	}

	protected override void Read(ref AnimationCurve value, IDataReader reader)
	{
		Keyframe[] keys = KeyframeSerializer.ReadValue(reader);
		value = new AnimationCurve(keys);
		value.preWrapMode = WrapModeSerializer.ReadValue(reader);
		value.postWrapMode = WrapModeSerializer.ReadValue(reader);
	}

	protected override void Write(ref AnimationCurve value, IDataWriter writer)
	{
		KeyframeSerializer.WriteValue(value.keys, writer);
		WrapModeSerializer.WriteValue(value.preWrapMode, writer);
		WrapModeSerializer.WriteValue(value.postWrapMode, writer);
	}
}
