using System;
using System.Collections.Generic;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer.Internal.DirectConverters;

public class GUIStyleState_DirectConverter : fsDirectConverter<GUIStyleState>
{
	protected override fsResult DoSerialize(GUIStyleState model, Dictionary<string, fsData> serialized)
	{
		return fsResult.Success + SerializeMember(serialized, null, "background", model.background) + SerializeMember(serialized, null, "textColor", model.textColor);
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref GUIStyleState model)
	{
		fsResult success = fsResult.Success;
		Texture2D value = model.background;
		fsResult obj = success + DeserializeMember<Texture2D>(data, null, "background", out value);
		model.background = value;
		Color value2 = model.textColor;
		fsResult result = obj + DeserializeMember<Color>(data, null, "textColor", out value2);
		model.textColor = value2;
		return result;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return new GUIStyleState();
	}
}
