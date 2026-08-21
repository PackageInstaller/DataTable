using System.Linq;
using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack.Resolvers;

public sealed class ContractlessStandardResolverAllowPrivate : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			if (typeof(T) == typeof(object))
			{
				Formatter = PrimitiveObjectResolver.Instance.GetFormatter<T>();
				return;
			}
			IFormatterResolver[] resolvers = Resolvers;
			for (int i = 0; i < resolvers.Length; i++)
			{
				IMessagePackFormatter<T> formatter = resolvers[i].GetFormatter<T>();
				if (formatter != null)
				{
					Formatter = formatter;
					break;
				}
			}
		}
	}

	public static readonly ContractlessStandardResolverAllowPrivate Instance;

	public static readonly MessagePackSerializerOptions Options;

	private static readonly IFormatterResolver[] Resolvers;

	static ContractlessStandardResolverAllowPrivate()
	{
		Resolvers = StandardResolverHelper.DefaultResolvers.Concat(new IFormatterResolver[0]).ToArray();
		Instance = new ContractlessStandardResolverAllowPrivate();
		Options = new MessagePackSerializerOptions(Instance);
	}

	private ContractlessStandardResolverAllowPrivate()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
