using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.FullSerializer;

public class AnimationCurve_DirectConverter : fsDirectConverter<AnimationCurve>
{
	protected override fsResult DoSerialize(AnimationCurve model, Dictionary<string, fsData> serialized)
	{
		return fsResult.Success + SerializeMember(serialized, null, "keys", model.keys) + SerializeMember(serialized, null, "preWrapMode", model.preWrapMode) + SerializeMember(serialized, null, "postWrapMode", model.postWrapMode);
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref AnimationCurve model)
	{
		fsResult success = fsResult.Success;
		Keyframe[] value = model.keys;
		fsResult fsResult2 = success + DeserializeMember<Keyframe[]>(data, null, "keys", out value);
		model.keys = value;
		WrapMode value2 = model.preWrapMode;
		fsResult fsResult3 = fsResult2 + DeserializeMember<WrapMode>(data, null, "preWrapMode", out value2);
		model.preWrapMode = value2;
		WrapMode value3 = model.postWrapMode;
		fsResult result = fsResult3 + DeserializeMember<WrapMode>(data, null, "postWrapMode", out value3);
		model.postWrapMode = value3;
		return result;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return new AnimationCurve();
	}
}
