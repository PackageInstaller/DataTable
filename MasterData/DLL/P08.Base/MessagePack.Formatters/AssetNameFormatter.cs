namespace MessagePack.Formatters;

public sealed class AssetNameFormatter : IMessagePackFormatter<AssetName>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, AssetName value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IFormatterResolver resolver = options.Resolver;
		writer.WriteArrayHeader(3);
		resolver.GetFormatterWithVerify<string>().Serialize(ref writer, value.loadName, options);
		resolver.GetFormatterWithVerify<string>().Serialize(ref writer, value.bundleName, options);
		resolver.GetFormatterWithVerify<string>().Serialize(ref writer, value.assetName, options);
	}

	public AssetName Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		options.Security.DepthStep(ref reader);
		IFormatterResolver resolver = options.Resolver;
		int num = reader.ReadArrayHeader();
		AssetName assetName = new AssetName();
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				assetName.loadName = resolver.GetFormatterWithVerify<string>().Deserialize(ref reader, options);
				break;
			case 1:
				assetName.bundleName = resolver.GetFormatterWithVerify<string>().Deserialize(ref reader, options);
				break;
			case 2:
				assetName.assetName = resolver.GetFormatterWithVerify<string>().Deserialize(ref reader, options);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		reader.Depth--;
		return assetName;
	}
}
