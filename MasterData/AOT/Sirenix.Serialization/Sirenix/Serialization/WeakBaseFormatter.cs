using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.Serialization;
using Sirenix.Serialization.Utilities;
using UnityEngine;

namespace Sirenix.Serialization;

public abstract class WeakBaseFormatter : IFormatter
{
	protected delegate void SerializationCallback(object value, StreamingContext context);

	protected readonly Type SerializedType;

	protected readonly SerializationCallback[] OnSerializingCallbacks;

	protected readonly SerializationCallback[] OnSerializedCallbacks;

	protected readonly SerializationCallback[] OnDeserializingCallbacks;

	protected readonly SerializationCallback[] OnDeserializedCallbacks;

	protected readonly bool IsValueType;

	protected readonly bool ImplementsISerializationCallbackReceiver;

	protected readonly bool ImplementsIDeserializationCallback;

	protected readonly bool ImplementsIObjectReference;

	Type IFormatter.SerializedType => SerializedType;

	public WeakBaseFormatter(Type serializedType)
	{
		SerializedType = serializedType;
		ImplementsISerializationCallbackReceiver = SerializedType.ImplementsOrInherits(typeof(ISerializationCallbackReceiver));
		ImplementsIDeserializationCallback = SerializedType.ImplementsOrInherits(typeof(IDeserializationCallback));
		ImplementsIObjectReference = SerializedType.ImplementsOrInherits(typeof(IObjectReference));
		if (SerializedType.ImplementsOrInherits(typeof(UnityEngine.Object)))
		{
			DefaultLoggers.DefaultLogger.LogWarning("A formatter has been created for the UnityEngine.Object type " + SerializedType.Name + " - this is *strongly* discouraged. Unity should be allowed to handle serialization and deserialization of its own weird objects. Remember to serialize with a UnityReferenceResolver as the external index reference resolver in the serialization context.\n\n Stacktrace: " + new StackTrace().ToString());
		}
		MethodInfo[] methods = SerializedType.GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
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
			return (object value, StreamingContext context) =>
			{
				info.Invoke(value, null);
			};
		}
		if (parameters.Length == 1 && parameters[0].ParameterType == typeof(StreamingContext) && !parameters[0].ParameterType.IsByRef)
		{
			return (object value, StreamingContext context) =>
			{
				info.Invoke(value, new object[1] { context });
			};
		}
		DefaultLoggers.DefaultLogger.LogWarning("The method " + info.GetNiceName() + " has an invalid signature and will be ignored by the serialization system.");
		return null;
	}

	public void Serialize(object value, IDataWriter writer)
	{
		SerializationContext context = writer.Context;
		for (int i = 0; i < OnSerializingCallbacks.Length; i++)
		{
			try
			{
				OnSerializingCallbacks[i](value, context.StreamingContext);
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
				value = serializationCallbackReceiver;
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
				OnSerializedCallbacks[j](value, context.StreamingContext);
			}
			catch (Exception exception4)
			{
				context.Config.DebugContext.LogException(exception4);
			}
		}
	}

	public object Deserialize(IDataReader reader)
	{
		DeserializationContext context = reader.Context;
		object value = GetUninitializedObject();
		if (IsValueType)
		{
			if (value == null)
			{
				value = Activator.CreateInstance(SerializedType);
			}
			InvokeOnDeserializingCallbacks(value, context);
		}
		else if (value != null)
		{
			RegisterReferenceID(value, reader);
			InvokeOnDeserializingCallbacks(value, context);
			if (ImplementsIObjectReference)
			{
				try
				{
					value = (value as IObjectReference).GetRealObject(context.StreamingContext);
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
					OnDeserializedCallbacks[i](value, context.StreamingContext);
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
				value = deserializationCallback;
			}
			if (ImplementsISerializationCallbackReceiver)
			{
				try
				{
					ISerializationCallbackReceiver serializationCallbackReceiver = value as ISerializationCallbackReceiver;
					serializationCallbackReceiver.OnAfterDeserialize();
					value = serializationCallbackReceiver;
				}
				catch (Exception exception4)
				{
					context.Config.DebugContext.LogException(exception4);
				}
			}
		}
		return value;
	}

	protected void RegisterReferenceID(object value, IDataReader reader)
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

	protected void InvokeOnDeserializingCallbacks(object value, DeserializationContext context)
	{
		for (int i = 0; i < OnDeserializingCallbacks.Length; i++)
		{
			try
			{
				OnDeserializingCallbacks[i](value, context.StreamingContext);
			}
			catch (Exception exception)
			{
				context.Config.DebugContext.LogException(exception);
			}
		}
	}

	protected virtual object GetUninitializedObject()
	{
		if (!IsValueType)
		{
			return FormatterServices.GetUninitializedObject(SerializedType);
		}
		return Activator.CreateInstance(SerializedType);
	}

	protected abstract void DeserializeImplementation(ref object value, IDataReader reader);

	protected abstract void SerializeImplementation(ref object value, IDataWriter writer);
}
