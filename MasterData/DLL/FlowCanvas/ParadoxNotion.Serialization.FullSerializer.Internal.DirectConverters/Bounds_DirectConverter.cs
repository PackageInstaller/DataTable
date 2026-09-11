using System;
using System.Collections.Generic;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer.Internal.DirectConverters;

public class Bounds_DirectConverter : fsDirectConverter<Bounds>
{
	protected override fsResult DoSerialize(Bounds model, Dictionary<string, fsData> serialized)
	{
		return fsResult.Success + SerializeMember(serialized, null, "center", model.center) + SerializeMember(serialized, null, "size", model.size);
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref Bounds model)
	{
		fsResult success = fsResult.Success;
		Vector3 value = model.center;
		fsResult obj = success + DeserializeMember<Vector3>(data, null, "center", out value);
		model.center = value;
		Vector3 value2 = model.size;
		fsResult result = obj + DeserializeMember<Vector3>(data, null, "size", out value2);
		model.size = value2;
		return result;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return default(Bounds);
	}
}
