using System;
using System.Buffers;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Numerics;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;
using MemoryPack.Formatters;
using MemoryPack.Internal;
using UnityEngine;

namespace MemoryPack;

public static class MemoryPackFormatterProvider
{
	private static class Check<T>
	{
		public static bool registered;
	}

	private static class Cache<T>
	{
		public static MemoryPackFormatter<T> formatter;

		static Cache()
		{
			if (Check<T>.registered)
			{
				return;
			}
			try
			{
				Type typeFromHandle = typeof(T);
				if (TryInvokeRegisterFormatter(typeFromHandle))
				{
					return;
				}
				if (TypeHelpers.IsAnonymous(typeFromHandle))
				{
					formatter = new ErrorMemoryPackFormatter<T>("Serialize anonymous type is not supported, use record or tuple instead.");
				}
				else
				{
					bool typeIsReferenceOrContainsReferences = RuntimeHelpers.IsReferenceOrContainsReferences<T>();
					formatter = (CreateGenericFormatter(typeFromHandle, typeIsReferenceOrContainsReferences) as MemoryPackFormatter<T>) ?? new ErrorMemoryPackFormatter<T>();
				}
			}
			catch (Exception exception)
			{
				formatter = new ErrorMemoryPackFormatter<T>(exception);
			}
			formatters[typeof(T)] = formatter;
			Check<T>.registered = true;
		}
	}

	private static readonly Dictionary<Type, Type> ArrayLikeFormatters;

	private static readonly Dictionary<Type, Type> CollectionFormatters;

	private static readonly Dictionary<Type, Type> InterfaceCollectionFormatters;

	private static readonly ConcurrentDictionary<Type, IMemoryPackFormatter> formatters;

	private static readonly ConcurrentDictionary<Type, Type> genericFormatterFactory;

	private static readonly ConcurrentDictionary<Type, Type> genericCollectionFormatterFactory;

	private static readonly Dictionary<Type, Type> KnownGenericTypeFormatters;

	private static void RegisterInitialFormatters()
	{
		UnityRegister<UnityEngine.Vector2>();
		UnityRegister<UnityEngine.Vector3>();
		UnityRegister<UnityEngine.Vector4>();
		UnityRegister<UnityEngine.Quaternion>();
		UnityRegister<Color>();
		UnityRegister<Bounds>();
		UnityRegister<Rect>();
		UnityRegister<Keyframe>();
		Register(new UnmanagedFormatter<WrapMode>());
		UnityRegister<UnityEngine.Matrix4x4>();
		UnityRegister<GradientColorKey>();
		UnityRegister<GradientAlphaKey>();
		Register(new UnmanagedFormatter<GradientMode>());
		UnityRegister<Color32>();
		UnityRegister<LayerMask>();
		UnityRegister<Vector2Int>();
		UnityRegister<Vector3Int>();
		UnityRegister<RangeInt>();
		UnityRegister<RectInt>();
		UnityRegister<BoundsInt>();
		if (!IsRegistered<AnimationCurve>())
		{
			Register(new AnimationCurveFormatter());
			Register(new ArrayFormatter<AnimationCurve>());
			Register(new ListFormatter<AnimationCurve>());
		}
		if (!IsRegistered<Gradient>())
		{
			Register(new GradientFormatter());
			Register(new ArrayFormatter<Gradient>());
			Register(new ListFormatter<Gradient>());
		}
		if (!IsRegistered<RectOffset>())
		{
			Register(new RectOffsetFormatter());
			Register(new ArrayFormatter<RectOffset>());
			Register(new ListFormatter<RectOffset>());
		}
	}

	static MemoryPackFormatterProvider()
	{
		ArrayLikeFormatters = new Dictionary<Type, Type>(4)
		{
			{
				typeof(ArraySegment<>),
				typeof(ArraySegmentFormatter<>)
			},
			{
				typeof(Memory<>),
				typeof(MemoryFormatter<>)
			},
			{
				typeof(ReadOnlyMemory<>),
				typeof(ReadOnlyMemoryFormatter<>)
			},
			{
				typeof(ReadOnlySequence<>),
				typeof(ReadOnlySequenceFormatter<>)
			}
		};
		CollectionFormatters = new Dictionary<Type, Type>(18)
		{
			{
				typeof(List<>),
				typeof(ListFormatter<>)
			},
			{
				typeof(Stack<>),
				typeof(StackFormatter<>)
			},
			{
				typeof(Queue<>),
				typeof(QueueFormatter<>)
			},
			{
				typeof(LinkedList<>),
				typeof(LinkedListFormatter<>)
			},
			{
				typeof(HashSet<>),
				typeof(HashSetFormatter<>)
			},
			{
				typeof(SortedSet<>),
				typeof(SortedSetFormatter<>)
			},
			{
				typeof(ObservableCollection<>),
				typeof(ObservableCollectionFormatter<>)
			},
			{
				typeof(Collection<>),
				typeof(CollectionFormatter<>)
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
				typeof(ConcurrentBag<>),
				typeof(ConcurrentBagFormatter<>)
			},
			{
				typeof(Dictionary<, >),
				typeof(DictionaryFormatter<, >)
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
				typeof(ConcurrentDictionary<, >),
				typeof(ConcurrentDictionaryFormatter<, >)
			},
			{
				typeof(ReadOnlyCollection<>),
				typeof(ReadOnlyCollectionFormatter<>)
			},
			{
				typeof(ReadOnlyObservableCollection<>),
				typeof(ReadOnlyObservableCollectionFormatter<>)
			},
			{
				typeof(BlockingCollection<>),
				typeof(BlockingCollectionFormatter<>)
			}
		};
		InterfaceCollectionFormatters = new Dictionary<Type, Type>(11)
		{
			{
				typeof(IEnumerable<>),
				typeof(InterfaceEnumerableFormatter<>)
			},
			{
				typeof(ICollection<>),
				typeof(InterfaceCollectionFormatter<>)
			},
			{
				typeof(IReadOnlyCollection<>),
				typeof(InterfaceReadOnlyCollectionFormatter<>)
			},
			{
				typeof(IList<>),
				typeof(InterfaceListFormatter<>)
			},
			{
				typeof(IReadOnlyList<>),
				typeof(InterfaceReadOnlyListFormatter<>)
			},
			{
				typeof(IDictionary<, >),
				typeof(InterfaceDictionaryFormatter<, >)
			},
			{
				typeof(IReadOnlyDictionary<, >),
				typeof(InterfaceReadOnlyDictionaryFormatter<, >)
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
				typeof(ISet<>),
				typeof(InterfaceSetFormatter<>)
			}
		};
		formatters = new ConcurrentDictionary<Type, IMemoryPackFormatter>(Environment.ProcessorCount, 150);
		genericFormatterFactory = new ConcurrentDictionary<Type, Type>();
		genericCollectionFormatterFactory = new ConcurrentDictionary<Type, Type>();
		KnownGenericTypeFormatters = new Dictionary<Type, Type>(3)
		{
			{
				typeof(KeyValuePair<, >),
				typeof(KeyValuePairFormatter<, >)
			},
			{
				typeof(Lazy<>),
				typeof(LazyFormatter<>)
			},
			{
				typeof(Nullable<>),
				typeof(NullableFormatter<>)
			}
		};
		RegisterWellKnownTypesFormatters();
		RegisterInitialFormatters();
	}

	public static bool IsRegistered<T>()
	{
		return Check<T>.registered;
	}

	public static void Register<T>(MemoryPackFormatter<T> formatter)
	{
		Check<T>.registered = true;
		formatters[typeof(T)] = formatter;
		Cache<T>.formatter = formatter;
	}

	public static void RegisterGenericType(Type genericType, Type genericFormatterType)
	{
		if (genericType.IsGenericType && genericFormatterType.IsGenericType)
		{
			genericFormatterFactory[genericType] = genericFormatterType;
		}
		else
		{
			MemoryPackSerializationException.ThrowMessage("Registered type is not generic type. genericType:" + genericType.FullName + ", formatterType:" + genericFormatterType.FullName);
		}
	}

	public static void RegisterCollection<TCollection, TElement>() where TCollection : ICollection<TElement?>, new()
	{
		Register(new GenericCollectionFormatter<TCollection, TElement>());
	}

	public static void RegisterCollection(Type genericCollectionType)
	{
		if (genericCollectionType.IsGenericType && genericCollectionType.GetGenericArguments().Length == 1)
		{
			genericCollectionFormatterFactory[genericCollectionType] = typeof(GenericCollectionFormatter<, >);
		}
		else
		{
			MemoryPackSerializationException.ThrowMessage("Registered generic collection is not filled generic formatter constraint. type: " + genericCollectionType.FullName);
		}
	}

	public static void RegisterSet<TSet, TElement>() where TSet : ISet<TElement?>, new()
	{
		Register(new GenericSetFormatter<TSet, TElement>());
	}

	public static void RegisterSet(Type genericSetType)
	{
		if (genericSetType.IsGenericType && genericSetType.GetGenericArguments().Length == 1)
		{
			genericCollectionFormatterFactory[genericSetType] = typeof(GenericSetFormatter<, >);
		}
		else
		{
			MemoryPackSerializationException.ThrowMessage("Registered generic set is not filled generic formatter constraint. type: " + genericSetType.FullName);
		}
	}

	public static void RegisterDictionary<TDictionary, TKey, TValue>() where TDictionary : IDictionary<TKey, TValue?>, new() where TKey : notnull
	{
		Register(new GenericDictionaryFormatter<TDictionary, TKey, TValue>());
	}

	public static void RegisterDictionary(Type genericDictionaryType)
	{
		if (genericDictionaryType.IsGenericType && genericDictionaryType.GetGenericArguments().Length == 2)
		{
			genericCollectionFormatterFactory[genericDictionaryType] = typeof(GenericDictionaryFormatter<, , >);
		}
		else
		{
			MemoryPackSerializationException.ThrowMessage("Registered generic collection is not filled generic formatter constraint. type: " + genericDictionaryType.FullName);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	internal static MemoryPackFormatter<T> GetFormatter<T>()
	{
		return Cache<T>.formatter;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	internal static IMemoryPackFormatter GetFormatter(Type type)
	{
		if (formatters.TryGetValue(type, out IMemoryPackFormatter value))
		{
			return value;
		}
		if (TryInvokeRegisterFormatter(type) && formatters.TryGetValue(type, out value))
		{
			return value;
		}
		if (TypeHelpers.IsAnonymous(type))
		{
			value = new ErrorMemoryPackFormatter(type, "Serialize anonymous type is not supported, use record or tuple instead.");
		}
		else
		{
			IMemoryPackFormatter memoryPackFormatter = CreateGenericFormatter(type, typeIsReferenceOrContainsReferences: true) as IMemoryPackFormatter;
			if (memoryPackFormatter == null)
			{
				memoryPackFormatter = new ErrorMemoryPackFormatter(type);
			}
			value = memoryPackFormatter;
		}
		formatters[type] = value;
		return value;
	}

	private static bool TryInvokeRegisterFormatter(Type type)
	{
		if (typeof(IMemoryPackFormatterRegister).IsAssignableFrom(type))
		{
			MethodInfo method = type.GetMethod("MemoryPack.IMemoryPackFormatterRegister.RegisterFormatter", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
			if (method == null)
			{
				method = type.GetMethod("RegisterFormatter", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
			}
			if (method == null)
			{
				throw new InvalidOperationException("Type implements IMemoryPackFormatterRegister but can not found RegisterFormatter. Type: " + type.FullName);
			}
			method.Invoke(null, null);
			return true;
		}
		return false;
	}

	internal static object? CreateGenericFormatter(Type type, bool typeIsReferenceOrContainsReferences)
	{
		Type type2 = null;
		if (type.IsArray)
		{
			if (type.IsSZArray)
			{
				type2 = (typeIsReferenceOrContainsReferences ? typeof(ArrayFormatter<>).MakeGenericType(type.GetElementType()) : typeof(DangerousUnmanagedArrayFormatter<>).MakeGenericType(type.GetElementType()));
			}
			else
			{
				switch (type.GetArrayRank())
				{
				case 2:
					type2 = typeof(TwoDimensionalArrayFormatter<>).MakeGenericType(type.GetElementType());
					break;
				case 3:
					type2 = typeof(ThreeDimensionalArrayFormatter<>).MakeGenericType(type.GetElementType());
					break;
				case 4:
					type2 = typeof(FourDimensionalArrayFormatter<>).MakeGenericType(type.GetElementType());
					break;
				default:
					return null;
				}
			}
		}
		else if (type.IsEnum || !typeIsReferenceOrContainsReferences)
		{
			type2 = typeof(DangerousUnmanagedFormatter<>).MakeGenericType(type);
		}
		else
		{
			type2 = TryCreateGenericFormatterType(type, TupleFormatterTypes.TupleFormatters);
			if (!(type2 != null))
			{
				type2 = TryCreateGenericFormatterType(type, KnownGenericTypeFormatters);
				if (!(type2 != null))
				{
					type2 = TryCreateGenericFormatterType(type, ArrayLikeFormatters);
					if (!(type2 != null))
					{
						type2 = TryCreateGenericFormatterType(type, CollectionFormatters);
						if (!(type2 != null))
						{
							type2 = TryCreateGenericFormatterType(type, InterfaceCollectionFormatters);
							if (!(type2 != null))
							{
								type2 = TryCreateGenericFormatterType(type, genericFormatterFactory);
								if (!(type2 != null))
								{
									type2 = TryCreateGenericCollectionFormatterType(type);
									if (!(type2 != null))
									{
										return null;
									}
								}
							}
						}
					}
				}
			}
		}
		return Activator.CreateInstance(type2);
	}

	private static Type? TryCreateGenericFormatterType(Type type, IDictionary<Type, Type> knownTypes)
	{
		if (type.IsGenericType)
		{
			Type genericTypeDefinition = type.GetGenericTypeDefinition();
			if (knownTypes.TryGetValue(genericTypeDefinition, out Type value))
			{
				return value.MakeGenericType(type.GetGenericArguments());
			}
		}
		return null;
	}

	private static Type? TryCreateGenericCollectionFormatterType(Type type)
	{
		if (type.IsGenericType && genericCollectionFormatterFactory.TryGetValue(type, out Type value))
		{
			Type[] genericArguments = type.GetGenericTypeDefinition().GetGenericArguments();
			return value.MakeGenericType(genericArguments.Prepend<Type>(type).ToArray());
		}
		return null;
	}

	internal static void RegisterWellKnownTypesFormatters()
	{
		Register(new UnmanagedFormatter<sbyte>());
		Register(new UnmanagedArrayFormatter<sbyte>());
		Register(new NullableFormatter<sbyte>());
		Register(new UnmanagedFormatter<byte>());
		Register(new UnmanagedArrayFormatter<byte>());
		Register(new NullableFormatter<byte>());
		Register(new UnmanagedFormatter<short>());
		Register(new UnmanagedArrayFormatter<short>());
		Register(new NullableFormatter<short>());
		Register(new UnmanagedFormatter<ushort>());
		Register(new UnmanagedArrayFormatter<ushort>());
		Register(new NullableFormatter<ushort>());
		Register(new UnmanagedFormatter<int>());
		Register(new UnmanagedArrayFormatter<int>());
		Register(new NullableFormatter<int>());
		Register(new UnmanagedFormatter<uint>());
		Register(new UnmanagedArrayFormatter<uint>());
		Register(new NullableFormatter<uint>());
		Register(new UnmanagedFormatter<long>());
		Register(new UnmanagedArrayFormatter<long>());
		Register(new NullableFormatter<long>());
		Register(new UnmanagedFormatter<ulong>());
		Register(new UnmanagedArrayFormatter<ulong>());
		Register(new NullableFormatter<ulong>());
		Register(new UnmanagedFormatter<char>());
		Register(new UnmanagedArrayFormatter<char>());
		Register(new NullableFormatter<char>());
		Register(new UnmanagedFormatter<float>());
		Register(new UnmanagedArrayFormatter<float>());
		Register(new NullableFormatter<float>());
		Register(new UnmanagedFormatter<double>());
		Register(new UnmanagedArrayFormatter<double>());
		Register(new NullableFormatter<double>());
		Register(new UnmanagedFormatter<decimal>());
		Register(new UnmanagedArrayFormatter<decimal>());
		Register(new NullableFormatter<decimal>());
		Register(new UnmanagedFormatter<bool>());
		Register(new UnmanagedArrayFormatter<bool>());
		Register(new NullableFormatter<bool>());
		Register(new UnmanagedFormatter<IntPtr>());
		Register(new UnmanagedArrayFormatter<IntPtr>());
		Register(new NullableFormatter<IntPtr>());
		Register(new UnmanagedFormatter<UIntPtr>());
		Register(new UnmanagedArrayFormatter<UIntPtr>());
		Register(new NullableFormatter<UIntPtr>());
		Register(new UnmanagedFormatter<DateTime>());
		Register(new UnmanagedArrayFormatter<DateTime>());
		Register(new NullableFormatter<DateTime>());
		Register(new UnmanagedFormatter<DateTimeOffset>());
		Register(new UnmanagedArrayFormatter<DateTimeOffset>());
		Register(new NullableFormatter<DateTimeOffset>());
		Register(new UnmanagedFormatter<TimeSpan>());
		Register(new UnmanagedArrayFormatter<TimeSpan>());
		Register(new NullableFormatter<TimeSpan>());
		Register(new UnmanagedFormatter<Guid>());
		Register(new UnmanagedArrayFormatter<Guid>());
		Register(new NullableFormatter<Guid>());
		Register(new UnmanagedFormatter<Complex>());
		Register(new UnmanagedArrayFormatter<Complex>());
		Register(new NullableFormatter<Complex>());
		Register(new UnmanagedFormatter<System.Numerics.Plane>());
		Register(new UnmanagedArrayFormatter<System.Numerics.Plane>());
		Register(new NullableFormatter<System.Numerics.Plane>());
		Register(new UnmanagedFormatter<System.Numerics.Quaternion>());
		Register(new UnmanagedArrayFormatter<System.Numerics.Quaternion>());
		Register(new NullableFormatter<System.Numerics.Quaternion>());
		Register(new UnmanagedFormatter<Matrix3x2>());
		Register(new UnmanagedArrayFormatter<Matrix3x2>());
		Register(new NullableFormatter<Matrix3x2>());
		Register(new UnmanagedFormatter<System.Numerics.Matrix4x4>());
		Register(new UnmanagedArrayFormatter<System.Numerics.Matrix4x4>());
		Register(new NullableFormatter<System.Numerics.Matrix4x4>());
		Register(new UnmanagedFormatter<System.Numerics.Vector2>());
		Register(new UnmanagedArrayFormatter<System.Numerics.Vector2>());
		Register(new NullableFormatter<System.Numerics.Vector2>());
		Register(new UnmanagedFormatter<System.Numerics.Vector3>());
		Register(new UnmanagedArrayFormatter<System.Numerics.Vector3>());
		Register(new NullableFormatter<System.Numerics.Vector3>());
		Register(new UnmanagedFormatter<System.Numerics.Vector4>());
		Register(new UnmanagedArrayFormatter<System.Numerics.Vector4>());
		Register(new NullableFormatter<System.Numerics.Vector4>());
		Register(new StringFormatter());
		Register(new ArrayFormatter<string>());
		Register(new VersionFormatter());
		Register(new ArrayFormatter<Version>());
		Register(new UriFormatter());
		Register(new ArrayFormatter<Uri>());
		Register(new TimeZoneInfoFormatter());
		Register(new ArrayFormatter<TimeZoneInfo>());
		Register(new BigIntegerFormatter());
		Register(new ArrayFormatter<BigInteger>());
		Register(new BitArrayFormatter());
		Register(new ArrayFormatter<BitArray>());
		Register(new StringBuilderFormatter());
		Register(new ArrayFormatter<StringBuilder>());
		Register(new TypeFormatter());
		Register(new ArrayFormatter<Type>());
		Register(new CultureInfoFormatter());
		Register(new ArrayFormatter<CultureInfo>());
	}

	private static void UnityRegister<T>() where T : unmanaged
	{
		Register(new UnmanagedFormatter<T>());
		Register(new UnmanagedArrayFormatter<T>());
		Register(new ListFormatter<T>());
		Register(new NullableFormatter<T>());
	}
}
