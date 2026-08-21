using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack.Resolvers;

public static class CompositeResolver
{
	private class CachingResolver : IFormatterResolver
	{
		private readonly ThreadsafeTypeKeyHashTable<IMessagePackFormatter> formattersCache = new ThreadsafeTypeKeyHashTable<IMessagePackFormatter>();

		private readonly IMessagePackFormatter[] subFormatters;

		private readonly IFormatterResolver[] subResolvers;

		internal CachingResolver(IMessagePackFormatter[] subFormatters, IFormatterResolver[] subResolvers)
		{
			this.subFormatters = subFormatters ?? throw new ArgumentNullException("subFormatters");
			this.subResolvers = subResolvers ?? throw new ArgumentNullException("subResolvers");
		}

		public IMessagePackFormatter<T> GetFormatter<T>()
		{
			if (!formattersCache.TryGetValue(typeof(T), out var value))
			{
				IMessagePackFormatter[] array = subFormatters;
				int num = 0;
				while (true)
				{
					if (num < array.Length)
					{
						IMessagePackFormatter messagePackFormatter = array[num];
						if (messagePackFormatter is IMessagePackFormatter<T>)
						{
							value = messagePackFormatter;
							break;
						}
						num++;
						continue;
					}
					IFormatterResolver[] array2 = subResolvers;
					for (num = 0; num < array2.Length; num++)
					{
						value = array2[num].GetFormatter<T>();
						if (value != null)
						{
							break;
						}
					}
					break;
				}
				formattersCache.TryAdd(typeof(T), value);
			}
			return (IMessagePackFormatter<T>)value;
		}
	}

	private static readonly ReadOnlyDictionary<Type, IMessagePackFormatter> EmptyFormattersByType = new ReadOnlyDictionary<Type, IMessagePackFormatter>(new Dictionary<Type, IMessagePackFormatter>());

	public static IFormatterResolver Create(IReadOnlyList<IMessagePackFormatter> formatters, IReadOnlyList<IFormatterResolver> resolvers)
	{
		if (formatters == null)
		{
			throw new ArgumentNullException("formatters");
		}
		if (resolvers == null)
		{
			throw new ArgumentNullException("resolvers");
		}
		IMessagePackFormatter[] subFormatters = formatters.ToArray();
		IFormatterResolver[] subResolvers = resolvers.ToArray();
		return new CachingResolver(subFormatters, subResolvers);
	}

	public static IFormatterResolver Create(params IFormatterResolver[] resolvers)
	{
		return Create(Array.Empty<IMessagePackFormatter>(), resolvers);
	}

	public static IFormatterResolver Create(params IMessagePackFormatter[] formatters)
	{
		return Create(formatters, Array.Empty<IFormatterResolver>());
	}
}
