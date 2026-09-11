using MessagePack.Formatters;

namespace MessagePack.Unity;

public class UnityResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			Formatter = (IMessagePackFormatter<T>)UnityResolveryResolverGetFormatterHelper.GetFormatter(typeof(T));
		}
	}

	public static readonly UnityResolver Instance = new UnityResolver();

	private UnityResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
