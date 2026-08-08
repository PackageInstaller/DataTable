using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class P08AssetManifestFormatter : IMessagePackFormatter<P08AssetManifest>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, P08AssetManifest value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IFormatterResolver resolver = options.Resolver;
		writer.WriteArrayHeader(2);
		resolver.GetFormatterWithVerify<Dictionary<string, int>>().Serialize(ref writer, value.bundleDict, options);
		resolver.GetFormatterWithVerify<List<int[]>>().Serialize(ref writer, value.deps, options);
	}

	public P08AssetManifest Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		options.Security.DepthStep(ref reader);
		IFormatterResolver resolver = options.Resolver;
		int num = reader.ReadArrayHeader();
		P08AssetManifest p08AssetManifest = new P08AssetManifest();
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				p08AssetManifest.bundleDict = resolver.GetFormatterWithVerify<Dictionary<string, int>>().Deserialize(ref reader, options);
				break;
			case 1:
				p08AssetManifest.deps = resolver.GetFormatterWithVerify<List<int[]>>().Deserialize(ref reader, options);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		reader.Depth--;
		return p08AssetManifest;
	}
}
