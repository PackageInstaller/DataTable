using System;
using System.Reflection;
using UnityEngine;

namespace Sirenix.Serialization;

public class WeakColorBlockFormatter : WeakBaseFormatter
{
	private static readonly Serializer<float> FloatSerializer = Serializer.Get<float>();

	private static readonly Serializer<Color> ColorSerializer = Serializer.Get<Color>();

	private readonly PropertyInfo normalColor;

	private readonly PropertyInfo highlightedColor;

	private readonly PropertyInfo pressedColor;

	private readonly PropertyInfo disabledColor;

	private readonly PropertyInfo colorMultiplier;

	private readonly PropertyInfo fadeDuration;

	public WeakColorBlockFormatter(Type colorBlockType)
		: base(colorBlockType)
	{
		normalColor = colorBlockType.GetProperty("normalColor");
		highlightedColor = colorBlockType.GetProperty("highlightedColor");
		pressedColor = colorBlockType.GetProperty("pressedColor");
		disabledColor = colorBlockType.GetProperty("disabledColor");
		colorMultiplier = colorBlockType.GetProperty("colorMultiplier");
		fadeDuration = colorBlockType.GetProperty("fadeDuration");
	}

	protected override void DeserializeImplementation(ref object value, IDataReader reader)
	{
		normalColor.SetValue(value, ColorSerializer.ReadValue(reader), null);
		highlightedColor.SetValue(value, ColorSerializer.ReadValue(reader), null);
		pressedColor.SetValue(value, ColorSerializer.ReadValue(reader), null);
		disabledColor.SetValue(value, ColorSerializer.ReadValue(reader), null);
		colorMultiplier.SetValue(value, FloatSerializer.ReadValue(reader), null);
		fadeDuration.SetValue(value, FloatSerializer.ReadValue(reader), null);
	}

	protected override void SerializeImplementation(ref object value, IDataWriter writer)
	{
		ColorSerializer.WriteValue((Color)normalColor.GetValue(value, null), writer);
		ColorSerializer.WriteValue((Color)highlightedColor.GetValue(value, null), writer);
		ColorSerializer.WriteValue((Color)pressedColor.GetValue(value, null), writer);
		ColorSerializer.WriteValue((Color)disabledColor.GetValue(value, null), writer);
		FloatSerializer.WriteValue((float)colorMultiplier.GetValue(value, null), writer);
		FloatSerializer.WriteValue((float)fadeDuration.GetValue(value, null), writer);
	}
}
