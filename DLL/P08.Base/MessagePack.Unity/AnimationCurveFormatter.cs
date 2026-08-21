using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class AnimationCurveFormatter : IMessagePackFormatter<AnimationCurve>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, AnimationCurve value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IFormatterResolver resolver = options.Resolver;
		writer.WriteArrayHeader(3);
		resolver.GetFormatterWithVerify<Keyframe[]>().Serialize(ref writer, value.keys, options);
		resolver.GetFormatterWithVerify<WrapMode>().Serialize(ref writer, value.postWrapMode, options);
		resolver.GetFormatterWithVerify<WrapMode>().Serialize(ref writer, value.preWrapMode, options);
	}

	public AnimationCurve Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			reader.ReadNil();
			return null;
		}
		IFormatterResolver resolver = options.Resolver;
		int num = reader.ReadArrayHeader();
		Keyframe[] keys = null;
		WrapMode postWrapMode = WrapMode.Default;
		WrapMode preWrapMode = WrapMode.Default;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				keys = resolver.GetFormatterWithVerify<Keyframe[]>().Deserialize(ref reader, options);
				break;
			case 1:
				postWrapMode = resolver.GetFormatterWithVerify<WrapMode>().Deserialize(ref reader, options);
				break;
			case 2:
				preWrapMode = resolver.GetFormatterWithVerify<WrapMode>().Deserialize(ref reader, options);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return new AnimationCurve
		{
			keys = keys,
			postWrapMode = postWrapMode,
			preWrapMode = preWrapMode
		};
	}
}
