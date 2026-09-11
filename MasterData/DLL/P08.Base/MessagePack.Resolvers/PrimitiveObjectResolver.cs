using MessagePack.Formatters;

namespace MessagePack.Resolvers;

public sealed class PrimitiveObjectResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			Formatter = ((typeof(T) == typeof(object)) ? ((IMessagePackFormatter<T>)PrimitiveObjectFormatter.Instance) : null);
		}
	}

	public static readonly PrimitiveObjectResolver Instance;

	public static readonly MessagePackSerializerOptions Options;

	static PrimitiveObjectResolver()
	{
		Instance = new PrimitiveObjectResolver();
		Options = new MessagePackSerializerOptions(Instance);
	}

	private PrimitiveObjectResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
