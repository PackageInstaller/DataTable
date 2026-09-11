using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack.Resolvers;

public sealed class DynamicGenericResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			Formatter = (IMessagePackFormatter<T>)DynamicGenericResolverGetFormatterHelper.GetFormatter(typeof(T));
		}
	}

	public static readonly DynamicGenericResolver Instance = new DynamicGenericResolver();

	private DynamicGenericResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
