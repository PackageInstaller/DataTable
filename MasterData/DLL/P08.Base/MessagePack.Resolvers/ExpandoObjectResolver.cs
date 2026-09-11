using System.Collections.Generic;
using System.Dynamic;
using MessagePack.Formatters;

namespace MessagePack.Resolvers;

public static class ExpandoObjectResolver
{
	private class PrimitiveObjectWithExpandoMaps : PrimitiveObjectFormatter
	{
		protected override object DeserializeMap(ref MessagePackReader reader, int length, MessagePackSerializerOptions options)
		{
			IMessagePackFormatter<string> formatterWithVerify = options.Resolver.GetFormatterWithVerify<string>();
			IMessagePackFormatter<object> formatter = options.Resolver.GetFormatter<object>();
			IDictionary<string, object> dictionary = new ExpandoObject();
			for (int i = 0; i < length; i++)
			{
				string key = formatterWithVerify.Deserialize(ref reader, options);
				object value = formatter.Deserialize(ref reader, options);
				dictionary.Add(key, value);
			}
			return dictionary;
		}
	}

	public static readonly IFormatterResolver Instance = CompositeResolver.Create(new IMessagePackFormatter[2]
	{
		ExpandoObjectFormatter.Instance,
		new PrimitiveObjectWithExpandoMaps()
	}, new IFormatterResolver[1] { BuiltinResolver.Instance });

	public static readonly MessagePackSerializerOptions Options = MessagePackSerializerOptions.Standard.WithSecurity(MessagePackSecurity.UntrustedData).WithResolver(Instance);
}
