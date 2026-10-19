using System;
using System.Collections.Generic;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

namespace Unity.VisualScripting;

public class Ray2DConverter : fsDirectConverter<Ray2D>
{
	protected override fsResult DoSerialize(Ray2D model, Dictionary<string, fsData> serialized)
	{
		return fsResult.Success + SerializeMember(serialized, null, "origin", model.origin) + SerializeMember(serialized, null, "direction", model.direction);
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref Ray2D model)
	{
		fsResult success = fsResult.Success;
		Vector2 value = model.origin;
		fsResult fsResult2 = success + DeserializeMember<Vector2>(data, null, "origin", out value);
		model.origin = value;
		Vector2 value2 = model.direction;
		fsResult result = fsResult2 + DeserializeMember<Vector2>(data, null, "direction", out value2);
		model.direction = value2;
		return result;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return default(Ray2D);
	}
}
