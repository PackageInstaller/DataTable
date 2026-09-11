using System.Collections.Generic;
using System.Dynamic;

namespace MessagePack.Formatters;

public class ExpandoObjectFormatter : IMessagePackFormatter<ExpandoObject>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<ExpandoObject> Instance = new ExpandoObjectFormatter();

	private ExpandoObjectFormatter()
	{
	}

	public ExpandoObject Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		ExpandoObject expandoObject = new ExpandoObject();
		int num = reader.ReadMapHeader();
		if (num > 0)
		{
			IFormatterResolver resolver = options.Resolver;
			IMessagePackFormatter<string> formatterWithVerify = resolver.GetFormatterWithVerify<string>();
			IMessagePackFormatter<object> formatterWithVerify2 = resolver.GetFormatterWithVerify<object>();
			IDictionary<string, object> dictionary = expandoObject;
			options.Security.DepthStep(ref reader);
			try
			{
				for (int i = 0; i < num; i++)
				{
					string key = formatterWithVerify.Deserialize(ref reader, options);
					object value = formatterWithVerify2.Deserialize(ref reader, options);
					dictionary.Add(key, value);
				}
			}
			finally
			{
				reader.Depth--;
			}
		}
		return expandoObject;
	}

	public void Serialize(ref MessagePackWriter writer, ExpandoObject value, MessagePackSerializerOptions options)
	{
		IMessagePackFormatter<string> formatterWithVerify = options.Resolver.GetFormatterWithVerify<string>();
		IMessagePackFormatter<object> formatterWithVerify2 = options.Resolver.GetFormatterWithVerify<object>();
		writer.WriteMapHeader(((ICollection<KeyValuePair<string, object>>)value).Count);
		foreach (KeyValuePair<string, object> item in (IEnumerable<KeyValuePair<string, object>>)value)
		{
			formatterWithVerify.Serialize(ref writer, item.Key, options);
			formatterWithVerify2.Serialize(ref writer, item.Value, options);
		}
	}
}
