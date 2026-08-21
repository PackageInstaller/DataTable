#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine.Events;

namespace GameFramework.Runtime;

public class UnityEventProxy : UnityEventProxyBase<UnityEvent>
{
	public override Type Type => typeof(UnityEvent);

	public UnityEventProxy(object target, UnityEvent unityEvent)
		: base(target, unityEvent)
	{
	}

	protected override void BindEvent()
	{
		unityEvent.AddListener(OnEvent);
	}

	protected override void UnbindEvent()
	{
		unityEvent.RemoveListener(OnEvent);
	}

	protected override bool IsValid(Delegate handler)
	{
		if (handler is UnityAction)
		{
			return true;
		}
		MethodInfo method = handler.Method;
		if (!method.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		List<Type> parameterTypes = method.GetParameterTypes();
		if (parameterTypes.Count != 0)
		{
			return false;
		}
		return true;
	}

	protected override bool IsValid(IProxyInvoker invoker)
	{
		IProxyMethodInfo proxyMethodInfo = invoker.ProxyMethodInfo;
		if (!proxyMethodInfo.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		ParameterInfo[] parameters = proxyMethodInfo.Parameters;
		if (parameters != null && parameters.Length != 0)
		{
			return false;
		}
		return true;
	}

	protected virtual void OnEvent()
	{
		try
		{
			if (command != null)
			{
				command.Execute(null);
			}
			else if (invoker != null)
			{
				invoker.Invoke();
			}
			else if ((object)handler != null)
			{
				if (handler is UnityAction)
				{
					(handler as UnityAction)();
				}
				else
				{
					handler.DynamicInvoke();
				}
			}
		}
		catch (Exception arg)
		{
			Log.Error("{0}", arg);
		}
	}
}
public class UnityEventProxy<T> : UnityEventProxyBase<UnityEvent<T>>
{
	public override Type Type => typeof(UnityEvent<T>);

	public UnityEventProxy(object target, UnityEvent<T> unityEvent)
		: base(target, unityEvent)
	{
	}

	protected override void BindEvent()
	{
		unityEvent.AddListener(OnEvent);
	}

	protected override void UnbindEvent()
	{
		unityEvent.RemoveListener(OnEvent);
	}

	protected override bool IsValid(Delegate handler)
	{
		if (handler is UnityAction<T>)
		{
			return true;
		}
		MethodInfo method = handler.Method;
		if (!method.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		List<Type> parameterTypes = method.GetParameterTypes();
		if (parameterTypes.Count != 1)
		{
			return false;
		}
		return parameterTypes[0].IsAssignableFrom(typeof(T));
	}

	protected override bool IsValid(IProxyInvoker invoker)
	{
		IProxyMethodInfo proxyMethodInfo = invoker.ProxyMethodInfo;
		if (!proxyMethodInfo.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		ParameterInfo[] parameters = proxyMethodInfo.Parameters;
		if (parameters == null || parameters.Length != 1)
		{
			return false;
		}
		return parameters[0].ParameterType.IsAssignableFrom(typeof(T));
	}

	protected virtual void OnEvent(T parameter)
	{
		try
		{
			if (command != null)
			{
				command.Execute(parameter);
			}
			else if (invoker != null)
			{
				invoker.Invoke(parameter);
			}
			else if ((object)handler != null)
			{
				if (handler is UnityAction<T>)
				{
					(handler as UnityAction<T>)(parameter);
					return;
				}
				handler.DynamicInvoke(parameter);
			}
		}
		catch (Exception arg)
		{
			Log.Error("{0}", arg);
		}
	}
}
public class UnityEventProxy<T0, T1> : UnityEventProxyBase<UnityEvent<T0, T1>>
{
	public override Type Type => typeof(UnityEvent<T0, T1>);

	public UnityEventProxy(object target, UnityEvent<T0, T1> unityEvent)
		: base(target, unityEvent)
	{
	}

	protected override void BindEvent()
	{
		unityEvent.AddListener(OnEvent);
	}

	protected override void UnbindEvent()
	{
		unityEvent.RemoveListener(OnEvent);
	}

	protected override bool IsValid(Delegate handler)
	{
		if (handler is UnityAction<T0, T1>)
		{
			return true;
		}
		MethodInfo method = handler.Method;
		if (!method.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		List<Type> parameterTypes = method.GetParameterTypes();
		if (parameterTypes.Count != 2)
		{
			return false;
		}
		return parameterTypes[0].IsAssignableFrom(typeof(T0)) && parameterTypes[1].IsAssignableFrom(typeof(T1));
	}

	protected override bool IsValid(IProxyInvoker invoker)
	{
		IProxyMethodInfo proxyMethodInfo = invoker.ProxyMethodInfo;
		if (!proxyMethodInfo.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		ParameterInfo[] parameters = proxyMethodInfo.Parameters;
		if (parameters == null || parameters.Length != 2)
		{
			return false;
		}
		return parameters[0].ParameterType.IsAssignableFrom(typeof(T0)) && parameters[1].ParameterType.IsAssignableFrom(typeof(T1));
	}

	protected virtual void OnEvent(T0 t0, T1 t1)
	{
		try
		{
			if (command != null)
			{
				command.Execute(new object[2] { t0, t1 });
			}
			else if (invoker != null)
			{
				invoker.Invoke(t0, t1);
			}
			else if ((object)handler != null)
			{
				if (handler is UnityAction<T0, T1>)
				{
					(handler as UnityAction<T0, T1>)(t0, t1);
					return;
				}
				handler.DynamicInvoke(t0, t1);
			}
		}
		catch (Exception arg)
		{
			Log.Error("{0}", arg);
		}
	}
}
public class UnityEventProxy<T0, T1, T2> : UnityEventProxyBase<UnityEvent<T0, T1, T2>>
{
	public override Type Type => typeof(UnityEvent<T0, T1, T2>);

	public UnityEventProxy(object target, UnityEvent<T0, T1, T2> unityEvent)
		: base(target, unityEvent)
	{
	}

	protected override void BindEvent()
	{
		unityEvent.AddListener(OnEvent);
	}

	protected override void UnbindEvent()
	{
		unityEvent.RemoveListener(OnEvent);
	}

	protected override bool IsValid(Delegate handler)
	{
		if (handler is UnityAction<T0, T1, T2>)
		{
			return true;
		}
		MethodInfo method = handler.Method;
		if (!method.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		List<Type> parameterTypes = method.GetParameterTypes();
		if (parameterTypes.Count != 3)
		{
			return false;
		}
		return parameterTypes[0].IsAssignableFrom(typeof(T0)) && parameterTypes[1].IsAssignableFrom(typeof(T1)) && parameterTypes[2].IsAssignableFrom(typeof(T2));
	}

	protected override bool IsValid(IProxyInvoker invoker)
	{
		IProxyMethodInfo proxyMethodInfo = invoker.ProxyMethodInfo;
		if (!proxyMethodInfo.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		ParameterInfo[] parameters = proxyMethodInfo.Parameters;
		if (parameters == null || parameters.Length != 3)
		{
			return false;
		}
		return parameters[0].ParameterType.IsAssignableFrom(typeof(T0)) && parameters[1].ParameterType.IsAssignableFrom(typeof(T1)) && parameters[2].ParameterType.IsAssignableFrom(typeof(T2));
	}

	protected virtual void OnEvent(T0 t0, T1 t1, T2 t2)
	{
		try
		{
			if (command != null)
			{
				command.Execute(new object[3] { t0, t1, t2 });
			}
			else if (invoker != null)
			{
				invoker.Invoke(t0, t1, t2);
			}
			else if ((object)handler != null)
			{
				if (handler is UnityAction<T0, T1, T2>)
				{
					(handler as UnityAction<T0, T1, T2>)(t0, t1, t2);
					return;
				}
				handler.DynamicInvoke(t0, t1, t2);
			}
		}
		catch (Exception arg)
		{
			Log.Error("{0}", arg);
		}
	}
}
public class UnityEventProxy<T0, T1, T2, T3> : UnityEventProxyBase<UnityEvent<T0, T1, T2, T3>>
{
	public override Type Type => typeof(UnityEvent<T0, T1, T2, T3>);

	public UnityEventProxy(object target, UnityEvent<T0, T1, T2, T3> unityEvent)
		: base(target, unityEvent)
	{
	}

	protected override void BindEvent()
	{
		unityEvent.AddListener(OnEvent);
	}

	protected override void UnbindEvent()
	{
		unityEvent.RemoveListener(OnEvent);
	}

	protected override bool IsValid(Delegate handler)
	{
		if (handler is UnityAction<T0, T1, T2, T3>)
		{
			return true;
		}
		MethodInfo method = handler.Method;
		if (!method.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		List<Type> parameterTypes = method.GetParameterTypes();
		if (parameterTypes.Count != 4)
		{
			return false;
		}
		return parameterTypes[0].IsAssignableFrom(typeof(T0)) && parameterTypes[1].IsAssignableFrom(typeof(T1)) && parameterTypes[2].IsAssignableFrom(typeof(T2)) && parameterTypes[3].IsAssignableFrom(typeof(T3));
	}

	protected override bool IsValid(IProxyInvoker invoker)
	{
		IProxyMethodInfo proxyMethodInfo = invoker.ProxyMethodInfo;
		if (!proxyMethodInfo.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		ParameterInfo[] parameters = proxyMethodInfo.Parameters;
		if (parameters == null || parameters.Length != 4)
		{
			return false;
		}
		return parameters[0].ParameterType.IsAssignableFrom(typeof(T0)) && parameters[1].ParameterType.IsAssignableFrom(typeof(T1)) && parameters[2].ParameterType.IsAssignableFrom(typeof(T2)) && parameters[3].ParameterType.IsAssignableFrom(typeof(T3));
	}

	protected virtual void OnEvent(T0 t0, T1 t1, T2 t2, T3 t3)
	{
		try
		{
			if (command != null)
			{
				command.Execute(new object[4] { t0, t1, t2, t3 });
			}
			else if (invoker != null)
			{
				invoker.Invoke(t0, t1, t2, t3);
			}
			else if ((object)handler != null)
			{
				if (handler is UnityAction<T0, T1, T2, T3>)
				{
					(handler as UnityAction<T0, T1, T2, T3>)(t0, t1, t2, t3);
					return;
				}
				handler.DynamicInvoke(t0, t1, t2, t3);
			}
		}
		catch (Exception arg)
		{
			Log.Error("{0}", arg);
		}
	}
}
