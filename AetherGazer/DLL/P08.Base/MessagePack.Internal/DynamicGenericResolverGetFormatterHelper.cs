using System;
using System.Buffers;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Reflection;
using MessagePack.Formatters;

namespace MessagePack.Internal;

internal static class DynamicGenericResolverGetFormatterHelper
{
	private static readonly Dictionary<Type, Type> FormatterMap = new Dictionary<Type, Type>
	{
		{
			typeof(List<>),
			typeof(ListFormatter<>)
		},
		{
			typeof(LinkedList<>),
			typeof(LinkedListFormatter<>)
		},
		{
			typeof(Queue<>),
			typeof(QueueFormatter<>)
		},
		{
			typeof(Stack<>),
			typeof(StackFormatter<>)
		},
		{
			typeof(HashSet<>),
			typeof(HashSetFormatter<>)
		},
		{
			typeof(ReadOnlyCollection<>),
			typeof(ReadOnlyCollectionFormatter<>)
		},
		{
			typeof(IList<>),
			typeof(InterfaceListFormatter2<>)
		},
		{
			typeof(ICollection<>),
			typeof(InterfaceCollectionFormatter2<>)
		},
		{
			typeof(IEnumerable<>),
			typeof(InterfaceEnumerableFormatter<>)
		},
		{
			typeof(Dictionary<, >),
			typeof(DictionaryFormatter<, >)
		},
		{
			typeof(IDictionary<, >),
			typeof(InterfaceDictionaryFormatter<, >)
		},
		{
			typeof(SortedDictionary<, >),
			typeof(SortedDictionaryFormatter<, >)
		},
		{
			typeof(SortedList<, >),
			typeof(SortedListFormatter<, >)
		},
		{
			typeof(ILookup<, >),
			typeof(InterfaceLookupFormatter<, >)
		},
		{
			typeof(IGrouping<, >),
			typeof(InterfaceGroupingFormatter<, >)
		},
		{
			typeof(ObservableCollection<>),
			typeof(ObservableCollectionFormatter<>)
		},
		{
			typeof(ReadOnlyObservableCollection<>),
			typeof(ReadOnlyObservableCollectionFormatter<>)
		},
		{
			typeof(IReadOnlyList<>),
			typeof(InterfaceReadOnlyListFormatter<>)
		},
		{
			typeof(IReadOnlyCollection<>),
			typeof(InterfaceReadOnlyCollectionFormatter<>)
		},
		{
			typeof(ISet<>),
			typeof(InterfaceSetFormatter<>)
		},
		{
			typeof(ConcurrentBag<>),
			typeof(ConcurrentBagFormatter<>)
		},
		{
			typeof(ConcurrentQueue<>),
			typeof(ConcurrentQueueFormatter<>)
		},
		{
			typeof(ConcurrentStack<>),
			typeof(ConcurrentStackFormatter<>)
		},
		{
			typeof(ReadOnlyDictionary<, >),
			typeof(ReadOnlyDictionaryFormatter<, >)
		},
		{
			typeof(IReadOnlyDictionary<, >),
			typeof(InterfaceReadOnlyDictionaryFormatter<, >)
		},
		{
			typeof(ConcurrentDictionary<, >),
			typeof(ConcurrentDictionaryFormatter<, >)
		},
		{
			typeof(Lazy<>),
			typeof(LazyFormatter<>)
		}
	};

	internal static object GetFormatter(Type t)
	{
		TypeInfo typeInfo = t.GetTypeInfo();
		if (t.IsArray)
		{
			switch (t.GetArrayRank())
			{
			case 1:
				if (t.GetElementType() == typeof(byte))
				{
					return ByteArrayFormatter.Instance;
				}
				return Activator.CreateInstance(typeof(ArrayFormatter<>).MakeGenericType(t.GetElementType()));
			case 2:
				return Activator.CreateInstance(typeof(TwoDimensionalArrayFormatter<>).MakeGenericType(t.GetElementType()));
			case 3:
				return Activator.CreateInstance(typeof(ThreeDimensionalArrayFormatter<>).MakeGenericType(t.GetElementType()));
			case 4:
				return Activator.CreateInstance(typeof(FourDimensionalArrayFormatter<>).MakeGenericType(t.GetElementType()));
			default:
				return null;
			}
		}
		if (typeInfo.IsGenericType)
		{
			Type genericTypeDefinition = typeInfo.GetGenericTypeDefinition();
			bool flag = genericTypeDefinition.GetTypeInfo().IsNullable();
			Type type = (flag ? typeInfo.GenericTypeArguments[0] : null);
			if (genericTypeDefinition == typeof(KeyValuePair<, >))
			{
				return CreateInstance(typeof(KeyValuePairFormatter<, >), typeInfo.GenericTypeArguments);
			}
			if (typeInfo.FullName.StartsWith("System.Tuple"))
			{
				Type genericType = null;
				switch (typeInfo.GenericTypeArguments.Length)
				{
				case 1:
					genericType = typeof(TupleFormatter<>);
					break;
				case 2:
					genericType = typeof(TupleFormatter<, >);
					break;
				case 3:
					genericType = typeof(TupleFormatter<, , >);
					break;
				case 4:
					genericType = typeof(TupleFormatter<, , , >);
					break;
				case 5:
					genericType = typeof(TupleFormatter<, , , , >);
					break;
				case 6:
					genericType = typeof(TupleFormatter<, , , , , >);
					break;
				case 7:
					genericType = typeof(TupleFormatter<, , , , , , >);
					break;
				case 8:
					genericType = typeof(TupleFormatter<, , , , , , , >);
					break;
				}
				return CreateInstance(genericType, typeInfo.GenericTypeArguments);
			}
			if (typeInfo.FullName.StartsWith("System.ValueTuple"))
			{
				Type genericType2 = null;
				switch (typeInfo.GenericTypeArguments.Length)
				{
				case 1:
					genericType2 = typeof(ValueTupleFormatter<>);
					break;
				case 2:
					genericType2 = typeof(ValueTupleFormatter<, >);
					break;
				case 3:
					genericType2 = typeof(ValueTupleFormatter<, , >);
					break;
				case 4:
					genericType2 = typeof(ValueTupleFormatter<, , , >);
					break;
				case 5:
					genericType2 = typeof(ValueTupleFormatter<, , , , >);
					break;
				case 6:
					genericType2 = typeof(ValueTupleFormatter<, , , , , >);
					break;
				case 7:
					genericType2 = typeof(ValueTupleFormatter<, , , , , , >);
					break;
				case 8:
					genericType2 = typeof(ValueTupleFormatter<, , , , , , , >);
					break;
				}
				return CreateInstance(genericType2, typeInfo.GenericTypeArguments);
			}
			if (genericTypeDefinition == typeof(ArraySegment<>))
			{
				if (typeInfo.GenericTypeArguments[0] == typeof(byte))
				{
					return ByteArraySegmentFormatter.Instance;
				}
				return CreateInstance(typeof(ArraySegmentFormatter<>), typeInfo.GenericTypeArguments);
			}
			if (genericTypeDefinition == typeof(Memory<>))
			{
				if (typeInfo.GenericTypeArguments[0] == typeof(byte))
				{
					return ByteMemoryFormatter.Instance;
				}
				return CreateInstance(typeof(MemoryFormatter<>), typeInfo.GenericTypeArguments);
			}
			if (genericTypeDefinition == typeof(ReadOnlyMemory<>))
			{
				if (typeInfo.GenericTypeArguments[0] == typeof(byte))
				{
					return ByteReadOnlyMemoryFormatter.Instance;
				}
				return CreateInstance(typeof(ReadOnlyMemoryFormatter<>), typeInfo.GenericTypeArguments);
			}
			if (genericTypeDefinition == typeof(ReadOnlySequence<>))
			{
				if (typeInfo.GenericTypeArguments[0] == typeof(byte))
				{
					return ByteReadOnlySequenceFormatter.Instance;
				}
				return CreateInstance(typeof(ReadOnlySequenceFormatter<>), typeInfo.GenericTypeArguments);
			}
			if (flag)
			{
				return CreateInstance(typeof(NullableFormatter<>), new Type[1] { type });
			}
			if (FormatterMap.TryGetValue(genericTypeDefinition, out var value))
			{
				return CreateInstance(value, typeInfo.GenericTypeArguments);
			}
		}
		else
		{
			if (typeInfo.IsEnum)
			{
				return CreateInstance(typeof(GenericEnumFormatter<>), new Type[1] { t });
			}
			if (t == typeof(IEnumerable))
			{
				return NonGenericInterfaceEnumerableFormatter.Instance;
			}
			if (t == typeof(ICollection))
			{
				return NonGenericInterfaceCollectionFormatter.Instance;
			}
			if (t == typeof(IList))
			{
				return NonGenericInterfaceListFormatter.Instance;
			}
			if (t == typeof(IDictionary))
			{
				return NonGenericInterfaceDictionaryFormatter.Instance;
			}
			if (typeof(IList).GetTypeInfo().IsAssignableFrom(typeInfo) && typeInfo.DeclaredConstructors.Any((ConstructorInfo x) => x.GetParameters().Length == 0))
			{
				return Activator.CreateInstance(typeof(NonGenericListFormatter<>).MakeGenericType(t));
			}
			if (typeof(IDictionary).GetTypeInfo().IsAssignableFrom(typeInfo) && typeInfo.DeclaredConstructors.Any((ConstructorInfo x) => x.GetParameters().Length == 0))
			{
				return Activator.CreateInstance(typeof(NonGenericDictionaryFormatter<>).MakeGenericType(t));
			}
		}
		Type type2 = typeInfo.ImplementedInterfaces.FirstOrDefault((Type x) => x.GetTypeInfo().IsConstructedGenericType() && x.GetGenericTypeDefinition() == typeof(IDictionary<, >));
		if (type2 != null && typeInfo.DeclaredConstructors.Any((ConstructorInfo x) => x.GetParameters().Length == 0))
		{
			Type type3 = type2.GenericTypeArguments[0];
			Type type4 = type2.GenericTypeArguments[1];
			return CreateInstance(typeof(GenericDictionaryFormatter<, , >), new Type[3] { type3, type4, t });
		}
		Type type5 = typeInfo.ImplementedInterfaces.FirstOrDefault((Type x) => x.GetTypeInfo().IsConstructedGenericType() && x.GetGenericTypeDefinition() == typeof(ICollection<>));
		if (type5 != null && typeInfo.DeclaredConstructors.Any((ConstructorInfo x) => x.GetParameters().Length == 0))
		{
			Type type6 = type5.GenericTypeArguments[0];
			return CreateInstance(typeof(GenericCollectionFormatter<, >), new Type[2] { type6, t });
		}
		return null;
	}

	private static object CreateInstance(Type genericType, Type[] genericTypeArguments, params object[] arguments)
	{
		return Activator.CreateInstance(genericType.MakeGenericType(genericTypeArguments), arguments);
	}
}
