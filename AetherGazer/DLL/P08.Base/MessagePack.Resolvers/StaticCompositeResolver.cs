using System;
using System.Collections.Generic;
using MessagePack.Formatters;

namespace MessagePack.Resolvers;

public class StaticCompositeResolver : IFormatterResolver
{
	private static class Cache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static Cache()
		{
			Instance.freezed = true;
			foreach (IMessagePackFormatter formatter3 in Instance.formatters)
			{
				if (formatter3 is IMessagePackFormatter<T> formatter)
				{
					Formatter = formatter;
					return;
				}
			}
			foreach (IFormatterResolver resolver in Instance.resolvers)
			{
				IMessagePackFormatter<T> formatter2 = resolver.GetFormatter<T>();
				if (formatter2 != null)
				{
					Formatter = formatter2;
					break;
				}
			}
		}
	}

	public static readonly StaticCompositeResolver Instance = new StaticCompositeResolver();

	private bool freezed;

	private IReadOnlyList<IMessagePackFormatter> formatters;

	private IReadOnlyList<IFormatterResolver> resolvers;

	private StaticCompositeResolver()
	{
		formatters = Array.Empty<IMessagePackFormatter>();
		resolvers = Array.Empty<IFormatterResolver>();
	}

	public void Register(params IMessagePackFormatter[] formatters)
	{
		if (freezed)
		{
			throw new InvalidOperationException("Register must call on startup(before use GetFormatter<T>).");
		}
		if (this.formatters == null)
		{
			throw new ArgumentNullException("formatters");
		}
		this.formatters = formatters;
		resolvers = Array.Empty<IFormatterResolver>();
	}

	public void Register(params IFormatterResolver[] resolvers)
	{
		if (freezed)
		{
			throw new InvalidOperationException("Register must call on startup(before use GetFormatter<T>).");
		}
		if (resolvers == null)
		{
			throw new ArgumentNullException("resolvers");
		}
		formatters = Array.Empty<IMessagePackFormatter>();
		this.resolvers = resolvers;
	}

	public void Register(IReadOnlyList<IMessagePackFormatter> formatters, IReadOnlyList<IFormatterResolver> resolvers)
	{
		if (freezed)
		{
			throw new InvalidOperationException("Register must call on startup(before use GetFormatter<T>).");
		}
		if (formatters == null)
		{
			throw new ArgumentNullException("formatters");
		}
		if (resolvers == null)
		{
			throw new ArgumentNullException("resolvers");
		}
		this.formatters = formatters;
		this.resolvers = resolvers;
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return Cache<T>.Formatter;
	}
}
