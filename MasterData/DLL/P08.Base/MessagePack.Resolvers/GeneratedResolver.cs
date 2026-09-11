using MessagePack.Formatters;

namespace MessagePack.Resolvers;

public class GeneratedResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		internal static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			object formatter = GeneratedResolverGetFormatterHelper.GetFormatter(typeof(T));
			if (formatter != null)
			{
				Formatter = (IMessagePackFormatter<T>)formatter;
			}
		}
	}

	public static readonly IFormatterResolver Instance = new GeneratedResolver();

	private GeneratedResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
