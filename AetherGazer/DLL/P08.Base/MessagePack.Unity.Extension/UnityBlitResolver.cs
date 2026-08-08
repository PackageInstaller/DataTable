using MessagePack.Formatters;

namespace MessagePack.Unity.Extension;

public class UnityBlitResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			Formatter = (IMessagePackFormatter<T>)UnityBlitResolverGetFormatterHelper.GetFormatter(typeof(T));
		}
	}

	public static readonly UnityBlitResolver Instance = new UnityBlitResolver();

	private UnityBlitResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
