using System.Collections.Generic;
using System.Reflection;

namespace System.Runtime.Serialization;

internal sealed class SerializationEvents
{
	private readonly List<MethodInfo> _onSerializingMethods;

	private readonly List<MethodInfo> _onSerializedMethods;

	private readonly List<MethodInfo> _onDeserializingMethods;

	private readonly List<MethodInfo> _onDeserializedMethods;

	internal bool HasOnSerializingEvents
	{
		get
		{
			if (_onSerializingMethods == null)
			{
				return _onSerializedMethods != null;
			}
			return true;
		}
	}

	internal SerializationEvents(Type t)
	{
		_onSerializingMethods = GetMethodsWithAttribute(typeof(OnSerializingAttribute), t);
		_onSerializedMethods = GetMethodsWithAttribute(typeof(OnSerializedAttribute), t);
		_onDeserializingMethods = GetMethodsWithAttribute(typeof(OnDeserializingAttribute), t);
		_onDeserializedMethods = GetMethodsWithAttribute(typeof(OnDeserializedAttribute), t);
	}

	private List<MethodInfo> GetMethodsWithAttribute(Type attribute, Type t)
	{
		List<MethodInfo> list = null;
		Type type = t;
		while (type != null && type != typeof(object))
		{
			MethodInfo[] methods = type.GetMethods(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			foreach (MethodInfo methodInfo in methods)
			{
				if (methodInfo.IsDefined(attribute, inherit: false))
				{
					if (list == null)
					{
						list = new List<MethodInfo>();
					}
					list.Add(methodInfo);
				}
			}
			type = type.BaseType;
		}
		list?.Reverse();
		return list;
	}

	internal void InvokeOnSerializing(object obj, StreamingContext context)
	{
		InvokeOnDelegate(obj, context, _onSerializingMethods);
	}

	internal void InvokeOnDeserializing(object obj, StreamingContext context)
	{
		InvokeOnDelegate(obj, context, _onDeserializingMethods);
	}

	internal void InvokeOnDeserialized(object obj, StreamingContext context)
	{
		InvokeOnDelegate(obj, context, _onDeserializedMethods);
	}

	internal SerializationEventHandler AddOnSerialized(object obj, SerializationEventHandler handler)
	{
		return AddOnDelegate(obj, handler, _onSerializedMethods);
	}

	internal SerializationEventHandler AddOnDeserialized(object obj, SerializationEventHandler handler)
	{
		return AddOnDelegate(obj, handler, _onDeserializedMethods);
	}

	private static void InvokeOnDelegate(object obj, StreamingContext context, List<MethodInfo> methods)
	{
		AddOnDelegate(obj, null, methods)?.Invoke(context);
	}

	private static SerializationEventHandler AddOnDelegate(object obj, SerializationEventHandler handler, List<MethodInfo> methods)
	{
		if (methods != null)
		{
			foreach (MethodInfo method in methods)
			{
				SerializationEventHandler b = (SerializationEventHandler)method.CreateDelegate(typeof(SerializationEventHandler), obj);
				handler = (SerializationEventHandler)Delegate.Combine(handler, b);
			}
		}
		return handler;
	}
}
