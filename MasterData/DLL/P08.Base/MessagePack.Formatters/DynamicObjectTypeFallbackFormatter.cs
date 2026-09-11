using System;
using System.Collections;
using System.Linq.Expressions;
using System.Reflection;
using MessagePack.Internal;

namespace MessagePack.Formatters;

public sealed class DynamicObjectTypeFallbackFormatter : IMessagePackFormatter<object>, IMessagePackFormatter
{
	private delegate void SerializeMethod(object dynamicFormatter, ref MessagePackWriter writer, object value, MessagePackSerializerOptions options);

	public static readonly IMessagePackFormatter<object> Instance = new DynamicObjectTypeFallbackFormatter();

	private static readonly ThreadsafeTypeKeyHashTable<SerializeMethod> SerializerDelegates = new ThreadsafeTypeKeyHashTable<SerializeMethod>();

	private DynamicObjectTypeFallbackFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, object value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		Type type = value.GetType();
		TypeInfo typeInfo = type.GetTypeInfo();
		if (type == typeof(object))
		{
			writer.WriteMapHeader(0);
			return;
		}
		if (PrimitiveObjectFormatter.IsSupportedType(type, typeInfo, value) && !(value is IDictionary) && !(value is ICollection))
		{
			PrimitiveObjectFormatter.Instance.Serialize(ref writer, value, options);
			return;
		}
		object formatterDynamicWithVerify = options.Resolver.GetFormatterDynamicWithVerify(type);
		if (!SerializerDelegates.TryGetValue(type, out var value2))
		{
			lock (SerializerDelegates)
			{
				if (!SerializerDelegates.TryGetValue(type, out value2))
				{
					Type type2 = typeof(IMessagePackFormatter<>).MakeGenericType(type);
					ParameterExpression parameterExpression = Expression.Parameter(typeof(object), "formatter");
					ParameterExpression parameterExpression2 = Expression.Parameter(typeof(MessagePackWriter).MakeByRefType(), "writer");
					ParameterExpression parameterExpression3 = Expression.Parameter(typeof(object), "value");
					ParameterExpression parameterExpression4 = Expression.Parameter(typeof(MessagePackSerializerOptions), "options");
					MethodInfo runtimeMethod = type2.GetRuntimeMethod("Serialize", new Type[3]
					{
						typeof(MessagePackWriter).MakeByRefType(),
						type,
						typeof(MessagePackSerializerOptions)
					});
					value2 = Expression.Lambda<SerializeMethod>(Expression.Call(Expression.Convert(parameterExpression, type2), runtimeMethod, parameterExpression2, typeInfo.IsValueType ? Expression.Unbox(parameterExpression3, type) : Expression.Convert(parameterExpression3, type), parameterExpression4), new ParameterExpression[4] { parameterExpression, parameterExpression2, parameterExpression3, parameterExpression4 }).Compile();
					SerializerDelegates.TryAdd(type, value2);
				}
			}
		}
		value2(formatterDynamicWithVerify, ref writer, value, options);
	}

	public object Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return PrimitiveObjectFormatter.Instance.Deserialize(ref reader, options);
	}
}
