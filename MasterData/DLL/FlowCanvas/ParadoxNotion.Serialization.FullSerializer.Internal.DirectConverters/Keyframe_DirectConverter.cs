using System;
using System.Collections.Generic;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer.Internal.DirectConverters;

public class Keyframe_DirectConverter : fsDirectConverter<Keyframe>
{
	protected override fsResult DoSerialize(Keyframe model, Dictionary<string, fsData> serialized)
	{
		return fsResult.Success + SerializeMember(serialized, null, "time", model.time) + SerializeMember(serialized, null, "value", model.value) + SerializeMember(serialized, null, "tangentMode", model.tangentMode) + SerializeMember(serialized, null, "inTangent", model.inTangent) + SerializeMember(serialized, null, "outTangent", model.outTangent);
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref Keyframe model)
	{
		fsResult success = fsResult.Success;
		float value = model.time;
		fsResult obj = success + DeserializeMember<float>(data, null, "time", out value);
		model.time = value;
		float value2 = model.value;
		fsResult obj2 = obj + DeserializeMember<float>(data, null, "value", out value2);
		model.value = value2;
		int value3 = model.tangentMode;
		fsResult obj3 = obj2 + DeserializeMember<int>(data, null, "tangentMode", out value3);
		model.tangentMode = value3;
		float value4 = model.inTangent;
		fsResult obj4 = obj3 + DeserializeMember<float>(data, null, "inTangent", out value4);
		model.inTangent = value4;
		float value5 = model.outTangent;
		fsResult result = obj4 + DeserializeMember<float>(data, null, "outTangent", out value5);
		model.outTangent = value5;
		return result;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return default(Keyframe);
	}
}
