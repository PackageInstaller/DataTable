using System;
using System.Linq;
using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[SpoofAOT]
public class ReflectedDelegateEvent
{
	public delegate void DelegateEventCallback(params object[] args);

	private Delegate theDelegate;

	private event DelegateEventCallback onCallback;

	public ReflectedDelegateEvent()
	{
	}

	public ReflectedDelegateEvent(Type delegateType)
	{
		MethodInfo methodForDelegateType = GetMethodForDelegateType(delegateType);
		theDelegate = methodForDelegateType.RTCreateDelegate(delegateType, this);
	}

	public void Add(DelegateEventCallback callback)
	{
		onCallback += callback;
	}

	public void Remove(DelegateEventCallback callback)
	{
		onCallback -= callback;
	}

	public Delegate AsDelegate()
	{
		return theDelegate;
	}

	private MethodInfo GetMethodForDelegateType(Type delegateType)
	{
		ParameterInfo[] parameters = delegateType.GetMethod("Invoke").GetParameters();
		Type type = GetType();
		MethodInfo methodInfo = null;
		if (parameters.Length == 0)
		{
			methodInfo = type.GetMethod("Callback0");
		}
		else if (parameters.Length == 1)
		{
			methodInfo = type.GetMethod("Callback1");
		}
		else if (parameters.Length == 2)
		{
			methodInfo = type.GetMethod("Callback2");
		}
		else if (parameters.Length == 3)
		{
			methodInfo = type.GetMethod("Callback3");
		}
		else if (parameters.Length == 4)
		{
			methodInfo = type.GetMethod("Callback4");
		}
		else if (parameters.Length == 5)
		{
			methodInfo = type.GetMethod("Callback5");
		}
		else if (parameters.Length == 6)
		{
			methodInfo = type.GetMethod("Callback6");
		}
		else if (parameters.Length == 7)
		{
			methodInfo = type.GetMethod("Callback7");
		}
		else if (parameters.Length == 8)
		{
			methodInfo = type.GetMethod("Callback8");
		}
		else if (parameters.Length == 9)
		{
			methodInfo = type.GetMethod("Callback9");
		}
		else if (parameters.Length == 10)
		{
			methodInfo = type.GetMethod("Callback10");
		}
		try
		{
			if (methodInfo.IsGenericMethodDefinition)
			{
				methodInfo = methodInfo.MakeGenericMethod(parameters.Select((ParameterInfo p) => p.ParameterType).ToArray());
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return null;
		}
		return methodInfo;
	}

	public void Callback0()
	{
		onCallback();
	}

	public void Callback1<T0>(T0 arg0)
	{
		onCallback(arg0);
	}

	public void Callback2<T0, T1>(T0 arg0, T1 arg1)
	{
		onCallback(arg0, arg1);
	}

	public void Callback3<T0, T1, T2>(T0 arg0, T1 arg1, T2 arg2)
	{
		onCallback(arg0, arg1, arg2);
	}

	public void Callback4<T0, T1, T2, T3>(T0 arg0, T1 arg1, T2 arg2, T3 arg3)
	{
		onCallback(arg0, arg1, arg2, arg3);
	}

	public void Callback5<T0, T1, T2, T3, T4>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		onCallback(arg0, arg1, arg2, arg3, arg4);
	}

	public void Callback6<T0, T1, T2, T3, T4, T5>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		onCallback(arg0, arg1, arg2, arg3, arg4, arg5);
	}

	public void Callback7<T0, T1, T2, T3, T4, T5, T6>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		onCallback(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
	}

	public void Callback8<T0, T1, T2, T3, T4, T5, T6, T7>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		onCallback(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
	}

	public void Callback9<T0, T1, T2, T3, T4, T5, T6, T7, T8>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		onCallback(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
	}

	public void Callback10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		onCallback(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	}

	public static explicit operator Delegate(ReflectedDelegateEvent that)
	{
		return that.AsDelegate();
	}
}
