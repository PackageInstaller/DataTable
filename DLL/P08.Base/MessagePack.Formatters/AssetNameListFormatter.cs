using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class AssetNameListFormatter : IMessagePackFormatter<AssetNameList>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, AssetNameList value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IFormatterResolver resolver = options.Resolver;
		writer.WriteArrayHeader(1);
		resolver.GetFormatterWithVerify<Dictionary<string, AssetName>>().Serialize(ref writer, value.assetNames, options);
	}

	public AssetNameList Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		options.Security.DepthStep(ref reader);
		IFormatterResolver resolver = options.Resolver;
		int num = reader.ReadArrayHeader();
		AssetNameList assetNameList = new AssetNameList();
		for (int i = 0; i < num; i++)
		{
			if (i == 0)
			{
				assetNameList.assetNames = resolver.GetFormatterWithVerify<Dictionary<string, AssetName>>().Deserialize(ref reader, options);
			}
			else
			{
				reader.Skip();
			}
		}
		reader.Depth--;
		return assetNameList;
	}
}
