using FlowCanvas;
using MessagePack;
using MessagePack.Formatters;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public class BinderConnectionFormatter<T> : IMessagePackFormatter<BinderConnection<T>>, IMessagePackFormatter
{
	public BinderConnection<T> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		BinderConnection<T> result = new BinderConnection<T>();
		options.Security.DepthStep(ref reader);
		try
		{
			reader.CancellationToken.ThrowIfCancellationRequested();
			formatterWithVerify.Deserialize(ref reader, options);
			reader.ReadString();
			reader.ReadString();
			reader.ReadInt32();
			reader.ReadInt32();
			Debug.LogError("BinderConnect todo: deserialize!!!!!!!!!!!!!");
			return result;
		}
		finally
		{
			reader.Depth--;
		}
	}

	public void Serialize(ref MessagePackWriter writer, BinderConnection<T> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		options.Resolver.GetFormatterWithVerify<T>();
		writer.CancellationToken.ThrowIfCancellationRequested();
		writer.Write(value.sourcePortID);
		writer.Write(value.targetPortID);
		int value2 = fsSerializationContext.graphData.nodes.IndexOf(value.sourceNode);
		int value3 = fsSerializationContext.graphData.nodes.IndexOf(value.targetNode);
		writer.WriteInt32(value2);
		writer.WriteInt32(value3);
	}
}
