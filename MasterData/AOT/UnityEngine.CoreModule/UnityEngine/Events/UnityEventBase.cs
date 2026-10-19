using System;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine.Scripting;
using UnityEngine.Serialization;

namespace UnityEngine.Events;

[Serializable]
[UsedByNativeCode]
public abstract class UnityEventBase : ISerializationCallbackReceiver
{
	private InvokableCallList m_Calls;

	[SerializeField]
	[FormerlySerializedAs("m_PersistentListeners")]
	private PersistentCallGroup m_PersistentCalls;

	private bool m_CallsDirty = true;

	protected UnityEventBase()
	{
		m_Calls = new InvokableCallList();
		m_PersistentCalls = new PersistentCallGroup();
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		DirtyPersistentCalls();
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		DirtyPersistentCalls();
	}

	protected MethodInfo FindMethod_Impl(string name, object targetObj)
	{
		return FindMethod_Impl(name, targetObj.GetType());
	}

	protected abstract MethodInfo FindMethod_Impl(string name, Type targetObjType);

	internal abstract BaseInvokableCall GetDelegate(object target, MethodInfo theFunction);

	internal MethodInfo FindMethod(PersistentCall call)
	{
		Type argumentType = typeof(Object);
		if (!string.IsNullOrEmpty(call.arguments.unityObjectArgumentAssemblyTypeName))
		{
			argumentType = Type.GetType(call.arguments.unityObjectArgumentAssemblyTypeName, throwOnError: false) ?? typeof(Object);
		}
		Type listenerType = ((call.target != null) ? call.target.GetType() : Type.GetType(call.targetAssemblyTypeName, throwOnError: false));
		return FindMethod(call.methodName, listenerType, call.mode, argumentType);
	}

	internal MethodInfo FindMethod(string name, Type listenerType, PersistentListenerMode mode, Type argumentType)
	{
		return mode switch
		{
			PersistentListenerMode.EventDefined => FindMethod_Impl(name, listenerType), 
			PersistentListenerMode.Void => GetValidMethodInfo(listenerType, name, new Type[0]), 
			PersistentListenerMode.Float => GetValidMethodInfo(listenerType, name, new Type[1] { typeof(float) }), 
			PersistentListenerMode.Int => GetValidMethodInfo(listenerType, name, new Type[1] { typeof(int) }), 
			PersistentListenerMode.Bool => GetValidMethodInfo(listenerType, name, new Type[1] { typeof(bool) }), 
			PersistentListenerMode.String => GetValidMethodInfo(listenerType, name, new Type[1] { typeof(string) }), 
			PersistentListenerMode.Object => GetValidMethodInfo(listenerType, name, new Type[1] { argumentType ?? typeof(Object) }), 
			_ => null, 
		};
	}

	internal int GetCallsCount()
	{
		return m_Calls.Count;
	}

	public int GetPersistentEventCount()
	{
		return m_PersistentCalls.Count;
	}

	public Object GetPersistentTarget(int index)
	{
		return m_PersistentCalls.GetListener(index)?.target;
	}

	public string GetPersistentMethodName(int index)
	{
		PersistentCall listener = m_PersistentCalls.GetListener(index);
		return (listener != null) ? listener.methodName : string.Empty;
	}

	private void DirtyPersistentCalls()
	{
		m_Calls.ClearPersistent();
		m_CallsDirty = true;
	}

	private void RebuildPersistentCallsIfNeeded()
	{
		if (m_CallsDirty)
		{
			m_PersistentCalls.Initialize(m_Calls, this);
			m_CallsDirty = false;
		}
	}

	public void SetPersistentListenerState(int index, UnityEventCallState state)
	{
		PersistentCall listener = m_PersistentCalls.GetListener(index);
		if (listener != null)
		{
			listener.callState = state;
		}
		DirtyPersistentCalls();
	}

	public UnityEventCallState GetPersistentListenerState(int index)
	{
		if (index < 0 || index > m_PersistentCalls.Count)
		{
			throw new IndexOutOfRangeException($"Index {index} is out of range of the {GetPersistentEventCount()} persistent listeners.");
		}
		return m_PersistentCalls.GetListener(index).callState;
	}

	protected void AddListener(object targetObj, MethodInfo method)
	{
		m_Calls.AddListener(GetDelegate(targetObj, method));
	}

	internal void AddCall(BaseInvokableCall call)
	{
		m_Calls.AddListener(call);
	}

	protected void RemoveListener(object targetObj, MethodInfo method)
	{
		m_Calls.RemoveListener(targetObj, method);
	}

	public void RemoveAllListeners()
	{
		m_Calls.Clear();
	}

	internal List<BaseInvokableCall> PrepareInvoke()
	{
		RebuildPersistentCallsIfNeeded();
		return m_Calls.PrepareInvoke();
	}

	protected void Invoke(object[] parameters)
	{
		List<BaseInvokableCall> list = PrepareInvoke();
		for (int i = 0; i < list.Count; i++)
		{
			list[i].Invoke(parameters);
		}
	}

	public override string ToString()
	{
		return base.ToString() + " " + GetType().FullName;
	}

	public static MethodInfo GetValidMethodInfo(object obj, string functionName, Type[] argumentTypes)
	{
		return GetValidMethodInfo(obj.GetType(), functionName, argumentTypes);
	}

	public static MethodInfo GetValidMethodInfo(Type objectType, string functionName, Type[] argumentTypes)
	{
		while (objectType != typeof(object) && objectType != null)
		{
			MethodInfo method = objectType.GetMethod(functionName, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic, null, argumentTypes, null);
			if (method != null)
			{
				ParameterInfo[] parameters = method.GetParameters();
				bool flag = true;
				int num = 0;
				ParameterInfo[] array = parameters;
				foreach (ParameterInfo parameterInfo in array)
				{
					Type type = argumentTypes[num];
					Type parameterType = parameterInfo.ParameterType;
					flag = type.IsPrimitive == parameterType.IsPrimitive;
					if (!flag)
					{
						break;
					}
					num++;
				}
				if (flag)
				{
					return method;
				}
			}
			objectType = objectType.BaseType;
		}
		return null;
	}
}
