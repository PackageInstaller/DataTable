using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.FullSerializer;

public class LayerMask_DirectConverter : fsDirectConverter<LayerMask>
{
	protected override fsResult DoSerialize(LayerMask model, Dictionary<string, fsData> serialized)
	{
		return fsResult.Success + SerializeMember(serialized, null, "value", model.value);
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref LayerMask model)
	{
		fsResult success = fsResult.Success;
		int value = model.value;
		fsResult result = success + DeserializeMember<int>(data, null, "value", out value);
		model.value = value;
		return result;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return default(LayerMask);
	}
}
