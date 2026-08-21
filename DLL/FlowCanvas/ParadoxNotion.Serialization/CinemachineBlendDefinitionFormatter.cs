using Cinemachine;
using MessagePack;
using MessagePack.Formatters;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public class CinemachineBlendDefinitionFormatter : IMessagePackFormatter<CinemachineBlendDefinition>, IMessagePackFormatter
{
	public CinemachineBlendDefinition Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		CinemachineBlendDefinition result = default(CinemachineBlendDefinition);
		result.m_Style = (CinemachineBlendDefinition.Style)reader.ReadInt32();
		result.m_Time = reader.ReadSingle();
		IMessagePackFormatter<AnimationCurve> formatterWithVerify = options.Resolver.GetFormatterWithVerify<AnimationCurve>();
		result.m_CustomCurve = formatterWithVerify.Deserialize(ref reader, options);
		return result;
	}

	public void Serialize(ref MessagePackWriter writer, CinemachineBlendDefinition value, MessagePackSerializerOptions options)
	{
		writer.Write((int)value.m_Style);
		writer.Write(value.m_Time);
		options.Resolver.GetFormatterWithVerify<AnimationCurve>().Serialize(ref writer, value.m_CustomCurve, options);
	}
}
