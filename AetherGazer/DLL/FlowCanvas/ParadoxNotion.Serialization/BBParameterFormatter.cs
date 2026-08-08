using MessagePack;
using MessagePack.Formatters;
using NodeCanvas.Framework;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public class BBParameterFormatter<T> : IMessagePackFormatter<BBParameter<T>>, IMessagePackFormatter
{
	public BBParameter<T> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (!reader.ReadBoolean())
		{
			return null;
		}
		BBParameter<T> bBParameter = new BBParameter<T>();
		options.Security.DepthStep(ref reader);
		try
		{
			reader.CancellationToken.ThrowIfCancellationRequested();
			bBParameter.SetName(reader.ReadString());
			bBParameter.targetVariableID = reader.ReadString();
			if (reader.ReadBoolean())
			{
				if (typeof(Object).IsAssignableFrom(typeof(T)))
				{
					IMessagePackFormatter<Object> formatterWithVerify = options.Resolver.GetFormatterWithVerify<Object>();
					bBParameter.value = (T)(object)formatterWithVerify.Deserialize(ref reader, options);
				}
				else
				{
					IMessagePackFormatter<T> formatterWithVerify2 = options.Resolver.GetFormatterWithVerify<T>();
					bBParameter.value = formatterWithVerify2.Deserialize(ref reader, options);
				}
			}
		}
		finally
		{
			reader.Depth--;
		}
		return bBParameter;
	}

	public void Serialize(ref MessagePackWriter writer, BBParameter<T> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.Write(value: false);
			return;
		}
		writer.Write(value: true);
		writer.CancellationToken.ThrowIfCancellationRequested();
		writer.Write(value.name);
		writer.Write(value.targetVariableID);
		if (value.value == null)
		{
			writer.Write(value: false);
			return;
		}
		writer.Write(value: true);
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
