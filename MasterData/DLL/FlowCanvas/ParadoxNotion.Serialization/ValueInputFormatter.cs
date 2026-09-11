using FlowCanvas;
using MessagePack;
using MessagePack.Formatters;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public class ValueInputFormatter<T> : IMessagePackFormatter<ValueInput<T>>, IMessagePackFormatter
{
	public ValueInput<T> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (!reader.ReadBoolean())
		{
			return null;
		}
		ValueInput<T> valueInput = new ValueInput<T>();
		options.Security.DepthStep(ref reader);
		try
		{
			reader.CancellationToken.ThrowIfCancellationRequested();
			if (typeof(Object).IsAssignableFrom(typeof(T)))
			{
				T defaultAndSerializedValue = (T)(object)options.Resolver.GetFormatterWithVerify<Object>().Deserialize(ref reader, options);
				valueInput.SetDefaultAndSerializedValue(defaultAndSerializedValue);
			}
			else
			{
				T defaultAndSerializedValue2 = options.Resolver.GetFormatterWithVerify<T>().Deserialize(ref reader, options);
				valueInput.SetDefaultAndSerializedValue(defaultAndSerializedValue2);
			}
		}
		finally
		{
			reader.Depth--;
		}
		return valueInput;
	}

	public void Serialize(ref MessagePackWriter writer, ValueInput<T> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.Write(value: false);
			return;
		}
		writer.Write(value: true);
		writer.CancellationToken.ThrowIfCancellationRequested();
		if (value.value is Object)
		{
			options.Resolver.GetFormatterWithVerify<Object>().Serialize(ref writer, (Object)(object)value.value, options);
		}
		else
		{
			options.Resolver.GetFormatterWithVerify<T>().Serialize(ref writer, value.value, options);
		}
	}
}
