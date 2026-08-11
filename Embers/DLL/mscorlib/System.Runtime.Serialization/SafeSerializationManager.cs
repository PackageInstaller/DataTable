using System.Collections;
using System.Collections.Generic;
using System.Reflection;

namespace System.Runtime.Serialization;

[Serializable]
internal sealed class SafeSerializationManager : IObjectReference, ISerializable
{
	private IList<object> m_serializedStates;

	private SerializationInfo m_savedSerializationInfo;

	private object m_realObject;

	private RuntimeType m_realType;

	private const string RealTypeSerializationName = "CLR_SafeSerializationManager_RealType";

	internal bool IsActive => SerializeObjectState != null;

	internal event EventHandler<SafeSerializationEventArgs> SerializeObjectState;

	internal SafeSerializationManager()
	{
	}

	private SafeSerializationManager(SerializationInfo info, StreamingContext context)
	{
		RuntimeType runtimeType = info.GetValueNoThrow("CLR_SafeSerializationManager_RealType", typeof(RuntimeType)) as RuntimeType;
		if (runtimeType == null)
		{
			m_serializedStates = info.GetValue("m_serializedStates", typeof(List<object>)) as List<object>;
			return;
		}
		m_realType = runtimeType;
		m_savedSerializationInfo = info;
	}

	internal void CompleteSerialization(object serializedObject, SerializationInfo info, StreamingContext context)
	{
		m_serializedStates = null;
		EventHandler<SafeSerializationEventArgs> eventHandler = SerializeObjectState;
		if (eventHandler != null)
		{
			SafeSerializationEventArgs e = new SafeSerializationEventArgs(context);
			eventHandler(serializedObject, e);
			m_serializedStates = e.SerializedStates;
			info.AddValue("CLR_SafeSerializationManager_RealType", serializedObject.GetType(), typeof(RuntimeType));
			info.SetType(typeof(SafeSerializationManager));
		}
	}

	internal void CompleteDeserialization(object deserializedObject)
	{
		if (m_serializedStates == null)
		{
			return;
		}
		foreach (ISafeSerializationData serializedState in m_serializedStates)
		{
			serializedState.CompleteDeserialization(deserializedObject);
		}
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		info.AddValue("m_serializedStates", m_serializedStates, typeof(List<IDeserializationCallback>));
	}

	object IObjectReference.GetRealObject(StreamingContext context)
	{
		if (m_realObject != null)
		{
			return m_realObject;
		}
		if (m_realType == null)
		{
			return this;
		}
		Stack stack = new Stack();
		RuntimeType runtimeType = m_realType;
		do
		{
			stack.Push(runtimeType);
			runtimeType = runtimeType.BaseType as RuntimeType;
		}
		while (runtimeType != typeof(object));
		RuntimeConstructorInfo runtimeConstructorInfo = null;
		RuntimeType runtimeType2 = null;
		do
		{
			runtimeType2 = runtimeType;
			runtimeType = stack.Pop() as RuntimeType;
			runtimeConstructorInfo = runtimeType.GetSerializationCtor();
		}
		while (runtimeConstructorInfo != null && runtimeConstructorInfo.IsSecurityCritical);
		runtimeConstructorInfo = ObjectManager.GetConstructor(runtimeType2);
		object uninitializedObject = FormatterServices.GetUninitializedObject(m_realType);
		runtimeConstructorInfo.SerializationInvoke(uninitializedObject, m_savedSerializationInfo, context);
		m_savedSerializationInfo = null;
		m_realType = null;
		m_realObject = uninitializedObject;
		return uninitializedObject;
	}

	[OnDeserialized]
	private void OnDeserialized(StreamingContext context)
	{
		if (m_realObject != null)
		{
			SerializationEventsCache.GetSerializationEventsForType(m_realObject.GetType()).InvokeOnDeserialized(m_realObject, context);
			m_realObject = null;
		}
	}
}
