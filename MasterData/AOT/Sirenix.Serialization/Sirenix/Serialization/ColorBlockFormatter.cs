using System.Reflection;
using UnityEngine;

namespace Sirenix.Serialization;

public class ColorBlockFormatter<T> : MinimalBaseFormatter<T>
{
	private static readonly Serializer<float> FloatSerializer = Serializer.Get<float>();

	private static readonly Serializer<Color> ColorSerializer = Serializer.Get<Color>();

	private static readonly PropertyInfo normalColor = typeof(T).GetProperty("normalColor");

	private static readonly PropertyInfo highlightedColor = typeof(T).GetProperty("highlightedColor");

	private static readonly PropertyInfo pressedColor = typeof(T).GetProperty("pressedColor");

	private static readonly PropertyInfo disabledColor = typeof(T).GetProperty("disabledColor");

	private static readonly PropertyInfo colorMultiplier = typeof(T).GetProperty("colorMultiplier");

	private static readonly PropertyInfo fadeDuration = typeof(T).GetProperty("fadeDuration");

	protected override void Read(ref T value, IDataReader reader)
	{
		object obj = value;
		normalColor.SetValue(obj, ColorSerializer.ReadValue(reader), null);
		highlightedColor.SetValue(obj, ColorSerializer.ReadValue(reader), null);
		pressedColor.SetValue(obj, ColorSerializer.ReadValue(reader), null);
		disabledColor.SetValue(obj, ColorSerializer.ReadValue(reader), null);
		colorMultiplier.SetValue(obj, FloatSerializer.ReadValue(reader), null);
		fadeDuration.SetValue(obj, FloatSerializer.ReadValue(reader), null);
		value = (T)obj;
	}

	protected override void Write(ref T value, IDataWriter writer)
	{
		ColorSerializer.WriteValue((Color)normalColor.GetValue(value, null), writer);
		ColorSerializer.WriteValue((Color)highlightedColor.GetValue(value, null), writer);
		ColorSerializer.WriteValue((Color)pressedColor.GetValue(value, null), writer);
		ColorSerializer.WriteValue((Color)disabledColor.GetValue(value, null), writer);
		FloatSerializer.WriteValue((float)colorMultiplier.GetValue(value, null), writer);
		FloatSerializer.WriteValue((float)fadeDuration.GetValue(value, null), writer);
	}
}
