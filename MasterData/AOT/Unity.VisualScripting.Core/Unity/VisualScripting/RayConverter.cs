using System;
using System.Collections.Generic;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

namespace Unity.VisualScripting;

public class RayConverter : fsDirectConverter<Ray>
{
	protected override fsResult DoSerialize(Ray model, Dictionary<string, fsData> serialized)
	{
		return fsResult.Success + SerializeMember(serialized, null, "origin", model.origin) + SerializeMember(serialized, null, "direction", model.direction);
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref Ray model)
	{
		fsResult success = fsResult.Success;
		Vector3 value = model.origin;
		fsResult fsResult2 = success + DeserializeMember<Vector3>(data, null, "origin", out value);
		model.origin = value;
		Vector3 value2 = model.direction;
		fsResult result = fsResult2 + DeserializeMember<Vector3>(data, null, "direction", out value2);
		model.direction = value2;
		return result;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return default(Ray);
	}
}
