using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Reflection;
using Sirenix.Serialization.Utilities;
using UnityEngine;

namespace Sirenix.Serialization;

public abstract class Serializer
{
	private static readonly Dictionary<Type, Type> PrimitiveReaderWriterTypes = new Dictionary<Type, Type>
	{
		{
			typeof(char),
			typeof(CharSerializer)
		},
		{
			typeof(string),
			typeof(StringSerializer)
		},
		{
			typeof(sbyte),
			typeof(SByteSerializer)
		},
		{
			typeof(short),
			typeof(Int16Serializer)
		},
		{
			typeof(int),
			typeof(Int32Serializer)
		},
		{
			typeof(long),
			typeof(Int64Serializer)
		},
		{
			typeof(byte),
			typeof(ByteSerializer)
		},
		{
			typeof(ushort),
			typeof(UInt16Serializer)
		},
		{
			typeof(uint),
			typeof(UInt32Serializer)
		},
		{
			typeof(ulong),
			typeof(UInt64Serializer)
		},
		{
			typeof(decimal),
			typeof(DecimalSerializer)
		},
		{
			typeof(bool),
			typeof(BooleanSerializer)
		},
		{
			typeof(float),
			typeof(SingleSerializer)
		},
		{
			typeof(double),
			typeof(DoubleSerializer)
		},
		{
			typeof(IntPtr),
			typeof(IntPtrSerializer)
		},
		{
			typeof(UIntPtr),
			typeof(UIntPtrSerializer)
		},
		{
			typeof(Guid),
			typeof(GuidSerializer)
		}
	};

	private static readonly object LOCK = new object();

	private static readonly Dictionary<Type, Serializer> Weak_ReaderWriterCache = new Dictionary<Type, Serializer>(FastTypeComparer.Instance);

	private static readonly Dictionary<Type, Serializer> Strong_ReaderWriterCache = new Dictionary<Type, Serializer>(FastTypeComparer.Instance);

	[Conditional("UNITY_EDITOR")]
	protected static void FireOnSerializedType(Type type)
	{
	}

	public static Serializer GetForValue(object value)
	{
		if (value == null)
		{
			return Get(typeof(object));
		}
		return Get(value.GetType());
	}

	public static Serializer<T> Get<T>()
	{
		return (Serializer<T>)Get(typeof(T), allowWeakFallback: false);
	}

	public static Serializer Get(Type type)
	{
		return Get(type, allowWeakFallback: true);
	}

	private static Serializer Get(Type type, bool allowWeakFallback)
	{
		if (type == null)
		{
			throw new ArgumentNullException();
		}
		Dictionary<Type, Serializer> dictionary = (allowWeakFallback ? Weak_ReaderWriterCache : Strong_ReaderWriterCache);
		Serializer value;
		lock (LOCK)
		{
			if (!dictionary.TryGetValue(type, out value))
			{
				value = Create(type, allowWeakFallback);
				dictionary.Add(type, value);
			}
		}
		return value;
	}

	public abstract object ReadValueWeak(IDataReader reader);

	public void WriteValueWeak(object value, IDataWriter writer)
	{
		WriteValueWeak(null, value, writer);
	}

	public abstract void WriteValueWeak(string name, object value, IDataWriter writer);

	private static Serializer Create(Type type, bool allowWeakfallback)
	{
		ExecutionEngineException ex = null;
		try
		{
			Type type2 = null;
			if (type.IsEnum)
			{
				if (allowWeakfallback && !EmitUtilities.CanEmit)
				{
					return new AnySerializer(type);
				}
				type2 = typeof(EnumSerializer<>).MakeGenericType(type);
			}
			else if (FormatterUtilities.IsPrimitiveType(type))
			{
				try
				{
					type2 = PrimitiveReaderWriterTypes[type];
				}
				catch (KeyNotFoundException)
				{
					Debug.LogError("Failed to find primitive serializer for " + type.Name);
				}
			}
			else
			{
				if (allowWeakfallback && !EmitUtilities.CanEmit)
				{
					return new AnySerializer(type);
				}
				type2 = typeof(ComplexTypeSerializer<>).MakeGenericType(type);
			}
			return (Serializer)Activator.CreateInstance(type2);
		}
		catch (TargetInvocationException ex3)
		{
			if (!(ex3.GetBaseException() is ExecutionEngineException))
			{
				throw ex3;
			}
			ex = ex3.GetBaseException() as ExecutionEngineException;
		}
		catch (TypeInitializationException ex4)
		{
			if (!(ex4.GetBaseException() is ExecutionEngineException))
			{
				throw ex4;
			}
			ex = ex4.GetBaseException() as ExecutionEngineException;
		}
		catch (ExecutionEngineException ex5)
		{
			ex = ex5;
		}
		if (allowWeakfallback)
		{
			return new AnySerializer(type);
		}
		LogAOTError(type, ex);
		throw ex;
	}

	private static void LogAOTError(Type type, ExecutionEngineException ex)
	{
		Debug.LogError("No AOT serializer was pre-generated for the type '" + type.GetNiceFullName() + "'. Please use Odin's AOT generation feature to generate an AOT dll before building, and ensure that '" + type.GetNiceFullName() + "' is in the list of supported types after a scan. If it is not, please report an issue and add it to the list manually.");
		throw new SerializationAbortException("AOT serializer was missing for type '" + type.GetNiceFullName() + "'.");
	}
}
public abstract class Serializer<T> : Serializer
{
	public override object ReadValueWeak(IDataReader reader)
	{
		return ReadValue(reader);
	}

	public override void WriteValueWeak(string name, object value, IDataWriter writer)
	{
		WriteValue(name, (T)value, writer);
	}

	public abstract T ReadValue(IDataReader reader);

	public void WriteValue(T value, IDataWriter writer)
	{
		WriteValue(null, value, writer);
	}

	public abstract void WriteValue(string name, T value, IDataWriter writer);

	[Conditional("UNITY_EDITOR")]
	protected static void FireOnSerializedType()
	{
	}
}
