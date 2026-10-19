using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.Serialization;
using Sirenix.Serialization.Utilities;
using UnityEngine;

namespace Sirenix.Serialization;

public abstract class BaseFormatter<T> : IFormatter<T>, IFormatter
{
	protected delegate void SerializationCallback(ref T value, StreamingContext context);

	protected static readonly SerializationCallback[] OnSerializingCallbacks;

	protected static readonly SerializationCallback[] OnSerializedCallbacks;

	protected static readonly SerializationCallback[] OnDeserializingCallbacks;

	protected static readonly SerializationCallback[] OnDeserializedCallbacks;

	protected static readonly bool IsValueType;

	protected static readonly bool ImplementsISerializationCallbackReceiver;

	protected static readonly bool ImplementsIDeserializationCallback;

	protected static readonly bool ImplementsIObjectReference;

	public Type SerializedType => typeof(T);

	static BaseFormatter()
	{
		IsValueType = typeof(T).IsValueType;
		ImplementsISerializationCallbackReceiver = typeof(T).ImplementsOrInherits(typeof(ISerializationCallbackReceiver));
		ImplementsIDeserializationCallback = typeof(T).ImplementsOrInherits(typeof(IDeserializationCallback));
		ImplementsIObjectReference = typeof(T).ImplementsOrInherits(typeof(IObjectReference));
		if (typeof(T).ImplementsOrInherits(typeof(UnityEngine.Object)))
		{
			DefaultLoggers.DefaultLogger.LogWarning("A formatter has been created for the UnityEngine.Object type " + typeof(T).Name + " - this is *strongly* discouraged. Unity should be allowed to handle serialization and deserialization of its own weird objects. Remember to serialize with a UnityReferenceResolver as the external index reference resolver in the serialization context.\n\n Stacktrace: " + new StackTrace().ToString());
		}
		MethodInfo[] methods = typeof(T).GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		List<SerializationCallback> list = new List<SerializationCallback>();
		OnSerializingCallbacks = GetCallbacks(methods, typeof(OnSerializingAttribute), ref list);
		OnSerializedCallbacks = GetCallbacks(methods, typeof(OnSerializedAttribute), ref list);
		OnDeserializingCallbacks = GetCallbacks(methods, typeof(OnDeserializingAttribute), ref list);
		OnDeserializedCallbacks = GetCallbacks(methods, typeof(OnDeserializedAttribute), ref list);
	}

	private static SerializationCallback[] GetCallbacks(MethodInfo[] methods, Type callbackAttribute, ref List<SerializationCallback> list)
	{
		foreach (MethodInfo methodInfo in methods)
		{
			if (methodInfo.IsDefined(callbackAttribute, inherit: true))
			{
				SerializationCallback serializationCallback = CreateCallback(methodInfo);
				if (serializationCallback != null)
				{
					list.Add(serializationCallback);
				}
			}
		}
		SerializationCallback[] result = list.ToArray();
		list.Clear();
		return result;
	}

	private static SerializationCallback CreateCallback(MethodInfo info)
	{
		ParameterInfo[] parameters = info.GetParameters();
		if (parameters.Length == 0)
		{
			return delegate(ref T value, StreamingContext context)
			{
				object obj = value;
				info.Invoke(obj, null);
				value = (T)obj;
			};
		}
		if (parameters.Length == 1 && parameters[0].ParameterType == typeof(StreamingContext) && !parameters[0].ParameterType.IsByRef)
		{
			return delegate(ref T value, StreamingContext context)
			{
				object obj = value;
				info.Invoke(obj, new object[1] { context });
				value = (T)obj;
			};
		}
		DefaultLoggers.DefaultLogger.LogWarning("The method " + info.GetNiceName() + " has an invalid signature and will be ignored by the serialization system.");
		return null;
	}

	void IFormatter.Serialize(object value, IDataWriter writer)
	{
		Serialize((T)value, writer);
	}

	object IFormatter.Deserialize(IDataReader reader)
	{
		return Deserialize(reader);
	}

	public T Deserialize(IDataReader reader)
	{
		DeserializationContext context = reader.Context;
		T value = GetUninitializedObject();
		if (IsValueType)
		{
			InvokeOnDeserializingCallbacks(ref value, context);
		}
		else if (value != null)
		{
			RegisterReferenceID(value, reader);
			InvokeOnDeserializingCallbacks(ref value, context);
			if (ImplementsIObjectReference)
			{
				try
				{
					value = (T)(value as IObjectReference).GetRealObject(context.StreamingContext);
					RegisterReferenceID(value, reader);
				}
				catch (Exception exception)
				{
					context.Config.DebugContext.LogException(exception);
				}
			}
		}
		try
		{
			DeserializeImplementation(ref value, reader);
		}
		catch (Exception exception2)
		{
			context.Config.DebugContext.LogException(exception2);
		}
		if (IsValueType || value != null)
		{
			for (int i = 0; i < OnDeserializedCallbacks.Length; i++)
			{
				try
				{
					OnDeserializedCallbacks[i](ref value, context.StreamingContext);
				}
				catch (Exception exception3)
				{
					context.Config.DebugContext.LogException(exception3);
				}
			}
			if (ImplementsIDeserializationCallback)
			{
				IDeserializationCallback deserializationCallback = value as IDeserializationCallback;
				deserializationCallback.OnDeserialization(this);
				value = (T)deserializationCallback;
			}
			if (ImplementsISerializationCallbackReceiver)
			{
				try
				{
					ISerializationCallbackReceiver serializationCallbackReceiver = value as ISerializationCallbackReceiver;
					serializationCallbackReceiver.OnAfterDeserialize();
					value = (T)serializationCallbackReceiver;
				}
				catch (Exception exception4)
				{
					context.Config.DebugContext.LogException(exception4);
				}
			}
		}
		return value;
	}

	public void Serialize(T value, IDataWriter writer)
	{
		SerializationContext context = writer.Context;
		for (int i = 0; i < OnSerializingCallbacks.Length; i++)
		{
			try
			{
				OnSerializingCallbacks[i](ref value, context.StreamingContext);
			}
			catch (Exception exception)
			{
				context.Config.DebugContext.LogException(exception);
			}
		}
		if (ImplementsISerializationCallbackReceiver)
		{
			try
			{
				ISerializationCallbackReceiver serializationCallbackReceiver = value as ISerializationCallbackReceiver;
				serializationCallbackReceiver.OnBeforeSerialize();
				value = (T)serializationCallbackReceiver;
			}
			catch (Exception exception2)
			{
				context.Config.DebugContext.LogException(exception2);
			}
		}
		try
		{
			SerializeImplementation(ref value, writer);
		}
		catch (Exception exception3)
		{
			context.Config.DebugContext.LogException(exception3);
		}
		for (int j = 0; j < OnSerializedCallbacks.Length; j++)
		{
			try
			{
				OnSerializedCallbacks[j](ref value, context.StreamingContext);
			}
			catch (Exception exception4)
			{
				context.Config.DebugContext.LogException(exception4);
			}
		}
	}

	protected virtual T GetUninitializedObject()
	{
		if (IsValueType)
		{
			return default;
		}
		return (T)FormatterServices.GetUninitializedObject(typeof(T));
	}

	protected void RegisterReferenceID(T value, IDataReader reader)
	{
		if (!IsValueType)
		{
			int currentNodeId = reader.CurrentNodeId;
			if (currentNodeId < 0)
			{
				reader.Context.Config.DebugContext.LogWarning("Reference type node is missing id upon deserialization. Some references may be broken. This tends to happen if a value type has changed to a reference type (IE, struct to class) since serialization took place.");
			}
			else
			{
				reader.Context.RegisterInternalReference(currentNodeId, value);
			}
		}
	}

	[Obsolete("Use the InvokeOnDeserializingCallbacks variant that takes a ref T value instead. This is for struct compatibility reasons.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	protected void InvokeOnDeserializingCallbacks(T value, DeserializationContext context)
	{
		InvokeOnDeserializingCallbacks(ref value, context);
	}

	protected void InvokeOnDeserializingCallbacks(ref T value, DeserializationContext context)
	{
		for (int i = 0; i < OnDeserializingCallbacks.Length; i++)
		{
			try
			{
				OnDeserializingCallbacks[i](ref value, context.StreamingContext);
			}
			catch (Exception exception)
			{
				context.Config.DebugContext.LogException(exception);
			}
		}
	}

	protected abstract void DeserializeImplementation(ref T value, IDataReader reader);

	protected abstract void SerializeImplementation(ref T value, IDataWriter writer);
}
