using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack.Resolvers;

internal abstract class CachingFormatterResolver : IFormatterResolver
{
	private readonly ThreadsafeTypeKeyHashTable<IMessagePackFormatter> formatters = new ThreadsafeTypeKeyHashTable<IMessagePackFormatter>();

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		if (!formatters.TryGetValue(typeof(T), out var value))
		{
			value = GetFormatterCore<T>();
			formatters.TryAdd(typeof(T), value);
		}
		return (IMessagePackFormatter<T>)value;
	}

	protected abstract IMessagePackFormatter<T> GetFormatterCore<T>();
}
