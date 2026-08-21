using System;
using System.Linq;
using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine.Events;

namespace FlowCanvas.Nodes;

[SpoofAOT]
public class ReflectedUnityEvent
{
	public delegate void UnityEventCallback(params object[] args);

	private Type _eventType;

	private MethodInfo _addListenerMethod;

	private MethodInfo _removeListenerMethod;

	private ParameterInfo[] _parameters;

	private MethodInfo _callMethod;

	public ParameterInfo[] parameters => _parameters;

	public Type eventType => _eventType;

	private event UnityEventCallback _callback;

	public ReflectedUnityEvent()
	{
	}

	public ReflectedUnityEvent(Type eventType)
	{
		InitForEventType(eventType);
	}

	public void InitForEventType(Type eventType)
	{
		_eventType = eventType;
		if (_eventType == null || !_eventType.RTIsSubclassOf(typeof(UnityEventBase)))
		{
			return;
		}
		MethodInfo method = _eventType.GetMethod("Invoke", BindingFlags.Instance | BindingFlags.Public);
		_parameters = method.GetParameters();
		Type type = GetType();
		if (_parameters.Length == 0)
		{
			_callMethod = type.RTGetMethod("CallbackMethod0");
		}
		if (_parameters.Length == 1)
		{
			_callMethod = type.RTGetMethod("CallbackMethod1");
		}
		if (_parameters.Length == 2)
		{
			_callMethod = type.RTGetMethod("CallbackMethod2");
		}
		if (_parameters.Length == 3)
		{
			_callMethod = type.RTGetMethod("CallbackMethod3");
		}
		if (_parameters.Length == 4)
		{
			_callMethod = type.RTGetMethod("CallbackMethod4");
		}
		if (_callMethod.IsGenericMethodDefinition)
		{
			_callMethod = _callMethod.MakeGenericMethod(_parameters.Select((ParameterInfo p) => p.ParameterType).ToArray());
		}
		Type[] types = new Type[2]
		{
			typeof(object),
			typeof(MethodInfo)
		};
		BindingFlags bindingAttr = BindingFlags.Instance | BindingFlags.NonPublic;
		_addListenerMethod = typeof(UnityEventBase).GetMethod("AddListener", bindingAttr, null, types, null);
		_removeListenerMethod = typeof(UnityEventBase).GetMethod("RemoveListener", bindingAttr, null, types, null);
	}

	public void StartListening(UnityEventBase targetEvent, UnityEventCallback callback)
	{
		_callback += callback;
		_addListenerMethod.Invoke(targetEvent, new object[2] { this, _callMethod });
	}

	public void StopListening(UnityEventBase targetEvent, UnityEventCallback callback)
	{
		_callback -= callback;
		_removeListenerMethod.Invoke(targetEvent, new object[2] { this, _callMethod });
	}

	public void CallbackMethod0()
	{
		_callback();
	}

	public void CallbackMethod1<T0>(T0 arg0)
	{
		_callback(arg0);
	}

	public void CallbackMethod2<T0, T1>(T0 arg0, T1 arg1)
	{
		_callback(arg0, arg1);
	}

	public void CallbackMethod3<T0, T1, T2>(T0 arg0, T1 arg1, T2 arg2)
	{
		_callback(arg0, arg1, arg2);
	}

	public void CallbackMethod4<T0, T1, T2, T3>(T0 arg0, T1 arg1, T2 arg2, T3 arg3)
	{
		_callback(arg0, arg1, arg2, arg3);
	}
}
