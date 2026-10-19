using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.FullSerializer;

public class Gradient_DirectConverter : fsDirectConverter<Gradient>
{
	protected override fsResult DoSerialize(Gradient model, Dictionary<string, fsData> serialized)
	{
		fsResult success = fsResult.Success;
		success += SerializeMember(serialized, null, "alphaKeys", model.alphaKeys);
		success += SerializeMember(serialized, null, "colorKeys", model.colorKeys);
		try
		{
			success += SerializeMember(serialized, null, "mode", model.mode);
		}
		catch (Exception)
		{
			LogWarning("serialized");
		}
		return success;
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref Gradient model)
	{
		fsResult success = fsResult.Success;
		GradientAlphaKey[] value = model.alphaKeys;
		success += DeserializeMember<GradientAlphaKey[]>(data, null, "alphaKeys", out value);
		model.alphaKeys = value;
		GradientColorKey[] value2 = model.colorKeys;
		success += DeserializeMember<GradientColorKey[]>(data, null, "colorKeys", out value2);
		model.colorKeys = value2;
		try
		{
			GradientMode value3 = model.mode;
			success += DeserializeMember<GradientMode>(data, null, "mode", out value3);
			model.mode = value3;
		}
		catch (Exception)
		{
			LogWarning("deserialized");
		}
		return success;
	}

	private static void LogWarning(string phase)
	{
		string text = "2021.3.9f1";
		text = "2022.2.0a18";
		Debug.LogWarning("Gradient.mode could not be " + phase + ". Please use Unity " + text + " or newer to resolve this issue.");
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return new Gradient();
	}
}
