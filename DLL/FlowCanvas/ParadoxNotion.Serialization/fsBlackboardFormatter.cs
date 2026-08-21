using System;
using MessagePack;
using MessagePack.Formatters;
using NodeCanvas.Framework.Internal;

namespace ParadoxNotion.Serialization;

public class fsBlackboardFormatter : IMessagePackFormatter<BlackboardSource>, IMessagePackFormatter
{
	public BlackboardSource Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		BlackboardSource blackboardSource = new BlackboardSource();
		blackboardSource.name = reader.ReadString();
		int num = reader.ReadInt32();
		for (int i = 0; i < num; i++)
		{
			string varName = reader.ReadString();
			Type varType = fsSerializationContext.GetVarType(reader.ReadInt32());
			blackboardSource.AddVariable(varName, varType, fullType: true).Deserialize(ref reader, options);
		}
		return blackboardSource;
	}

	public void Serialize(ref MessagePackWriter writer, BlackboardSource value, MessagePackSerializerOptions options)
	{
	}
}
