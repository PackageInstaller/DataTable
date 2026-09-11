using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack.Resolvers;

public sealed class NativeDateTimeResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			Formatter = (IMessagePackFormatter<T>)NativeDateTimeResolverGetFormatterHelper.GetFormatter(typeof(T));
		}
	}

	public static readonly NativeDateTimeResolver Instance;

	public static readonly MessagePackSerializerOptions Options;

	static NativeDateTimeResolver()
	{
		Instance = new NativeDateTimeResolver();
		Options = new MessagePackSerializerOptions(Instance);
	}

	private NativeDateTimeResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
