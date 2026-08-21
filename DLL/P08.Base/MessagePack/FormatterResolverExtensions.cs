using System;
using System.Linq.Expressions;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.ExceptionServices;
using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack;

public static class FormatterResolverExtensions
{
	private static readonly ThreadsafeTypeKeyHashTable<Func<IFormatterResolver, IMessagePackFormatter>> FormatterGetters = new ThreadsafeTypeKeyHashTable<Func<IFormatterResolver, IMessagePackFormatter>>();

	private static readonly MethodInfo GetFormatterRuntimeMethod = typeof(IFormatterResolver).GetRuntimeMethod("GetFormatter", Type.EmptyTypes);

	[MethodImpl((MethodImplOptions)256)]
	public static IMessagePackFormatter<T> GetFormatterWithVerify<T>(this IFormatterResolver resolver)
	{
		if (resolver == null)
		{
			throw new ArgumentNullException("resolver");
		}
		IMessagePackFormatter<T> formatter;
		try
		{
			formatter = resolver.GetFormatter<T>();
		}
		catch (TypeInitializationException ex)
		{
			Throw(ex);
			return null;
		}
		if (formatter == null)
		{
			Throw(typeof(T), resolver);
		}
		return formatter;
	}

	private static void Throw(TypeInitializationException ex)
	{
		ExceptionDispatchInfo.Capture(ex.InnerException ?? ex).Throw();
	}

	private static void Throw(Type t, IFormatterResolver resolver)
	{
		throw new FormatterNotRegisteredException(t.FullName + " is not registered in resolver: " + resolver.GetType());
	}

	public static object GetFormatterDynamic(this IFormatterResolver resolver, Type type)
	{
		if (resolver == null)
		{
			throw new ArgumentNullException("resolver");
		}
		if ((object)type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (!FormatterGetters.TryGetValue(type, out var value))
		{
			MethodInfo method = GetFormatterRuntimeMethod.MakeGenericMethod(type);
			ParameterExpression parameterExpression = Expression.Parameter(typeof(IFormatterResolver), "inputResolver");
			value = Expression.Lambda<Func<IFormatterResolver, IMessagePackFormatter>>(Expression.Call(parameterExpression, method), new ParameterExpression[1] { parameterExpression }).Compile();
			FormatterGetters.TryAdd(type, value);
		}
		return value(resolver);
	}

	internal static object GetFormatterDynamicWithVerify(this IFormatterResolver resolver, Type type)
	{
		object formatterDynamic = resolver.GetFormatterDynamic(type);
		if (formatterDynamic == null)
		{
			Throw(type, resolver);
		}
		return formatterDynamic;
	}
}
