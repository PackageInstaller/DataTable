using System;
using System.Reflection;
using UnityEngine;

namespace Sirenix.Serialization;

public class GradientFormatter : MinimalBaseFormatter<Gradient>
{
	private static readonly Serializer<GradientAlphaKey[]> AlphaKeysSerializer = Serializer.Get<GradientAlphaKey[]>();

	private static readonly Serializer<GradientColorKey[]> ColorKeysSerializer = Serializer.Get<GradientColorKey[]>();

	private static readonly PropertyInfo ModeProperty = typeof(Gradient).GetProperty("mode", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);

	private static readonly Serializer<object> EnumSerializer = ((ModeProperty != null) ? Serializer.Get<object>() : null);

	protected override Gradient GetUninitializedObject()
	{
		return new Gradient();
	}

	protected override void Read(ref Gradient value, IDataReader reader)
	{
		value.alphaKeys = AlphaKeysSerializer.ReadValue(reader);
		value.colorKeys = ColorKeysSerializer.ReadValue(reader);
		reader.PeekEntry(out var name);
		if (!(name == "mode"))
		{
			return;
		}
		try
		{
			if (ModeProperty != null)
			{
				ModeProperty.SetValue(value, EnumSerializer.ReadValue(reader), null);
			}
			else
			{
				reader.SkipEntry();
			}
		}
		catch (Exception)
		{
			reader.Context.Config.DebugContext.LogWarning("Failed to read Gradient.mode, due to Unity's API disallowing setting of this member on other threads than the main thread. Gradient.mode value will have been lost.");
		}
	}

	protected override void Write(ref Gradient value, IDataWriter writer)
	{
		AlphaKeysSerializer.WriteValue(value.alphaKeys, writer);
		ColorKeysSerializer.WriteValue(value.colorKeys, writer);
		if (ModeProperty != null)
		{
			try
			{
				EnumSerializer.WriteValue("mode", ModeProperty.GetValue(value, null), writer);
			}
			catch (Exception)
			{
				writer.Context.Config.DebugContext.LogWarning("Failed to write Gradient.mode, due to Unity's API disallowing setting of this member on other threads than the main thread. Gradient.mode will have been lost upon deserialization.");
			}
		}
	}
}
