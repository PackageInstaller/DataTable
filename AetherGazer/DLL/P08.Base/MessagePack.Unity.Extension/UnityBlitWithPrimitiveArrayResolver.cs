using MessagePack.Formatters;

namespace MessagePack.Unity.Extension;

public class UnityBlitWithPrimitiveArrayResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		internal static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			Formatter = (IMessagePackFormatter<T>)UnityBlitWithPrimitiveResolverGetFormatterHelper.GetFormatter(typeof(T));
			if (Formatter == null)
			{
				Formatter = UnityBlitResolver.Instance.GetFormatter<T>();
			}
		}
	}

	public static readonly UnityBlitWithPrimitiveArrayResolver Instance = new UnityBlitWithPrimitiveArrayResolver();

	private UnityBlitWithPrimitiveArrayResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
