#define ENABLE_DEBUG_AND_ABOVE_LOG
using System;
using System.Reflection;

namespace GameFramework.Runtime;

public class StaticProxyActionInfo<T> : ProxyMethodInfo, IStaticProxyActionInfo<T>, IProxyMethodInfo, IProxyMemberInfo
{
	private Action action;

	public override Type DeclaringType => typeof(T);

	public StaticProxyActionInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Action)null)
	{
	}

	public StaticProxyActionInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Action)null)
	{
	}

	public StaticProxyActionInfo(MethodInfo info)
		: this(info, (Action)null)
	{
	}

	public StaticProxyActionInfo(string methodName, Action action)
		: this(typeof(T).GetMethod(methodName), action)
	{
	}

	public StaticProxyActionInfo(string methodName, Type[] parameterTypes, Action action)
		: this(typeof(T).GetMethod(methodName, parameterTypes), action)
	{
	}

	public StaticProxyActionInfo(MethodInfo info, Action action)
		: base(info)
	{
		if (!methodInfo.IsStatic)
		{
			throw new ArgumentException("The method isn't static!");
		}
		if (!typeof(void).Equals(methodInfo.ReturnType) || !typeof(T).Equals(methodInfo.DeclaringType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		this.action = action;
		if (this.action == null)
		{
			this.action = MakeAction(methodInfo);
		}
	}

	private Action MakeAction(MethodInfo methodInfo)
	{
		try
		{
			return (Action)methodInfo.CreateDelegate(typeof(Action));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual void Invoke()
	{
		if (action != null)
		{
			action();
		}
		else
		{
			methodInfo.Invoke(null, null);
		}
	}

	public override object Invoke(object target, params object[] args)
	{
		Invoke();
		return null;
	}
}
public class StaticProxyActionInfo<T, P1> : ProxyMethodInfo, IStaticProxyActionInfo<T, P1>, IProxyMethodInfo, IProxyMemberInfo
{
	private Action<P1> action;

	public override Type DeclaringType => typeof(T);

	public StaticProxyActionInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Action<P1>)null)
	{
	}

	public StaticProxyActionInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Action<P1>)null)
	{
	}

	public StaticProxyActionInfo(MethodInfo info)
		: this(info, (Action<P1>)null)
	{
	}

	public StaticProxyActionInfo(string methodName, Action<P1> action)
		: this(typeof(T).GetMethod(methodName), action)
	{
	}

	public StaticProxyActionInfo(string methodName, Type[] parameterTypes, Action<P1> action)
		: this(typeof(T).GetMethod(methodName, parameterTypes), action)
	{
	}

	public StaticProxyActionInfo(MethodInfo info, Action<P1> action)
		: base(info)
	{
		if (!methodInfo.IsStatic)
		{
			throw new ArgumentException("The method isn't static!");
		}
		if (!typeof(void).Equals(methodInfo.ReturnType) || !typeof(T).Equals(methodInfo.DeclaringType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length != 1 || !typeof(P1).Equals(parameters[0].ParameterType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		this.action = action;
		if (this.action == null)
		{
			this.action = MakeAction(methodInfo);
		}
	}

	private Action<P1> MakeAction(MethodInfo methodInfo)
	{
		try
		{
			return (Action<P1>)methodInfo.CreateDelegate(typeof(Action<P1>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual void Invoke(P1 p1)
	{
		if (action != null)
		{
			action(p1);
			return;
		}
		methodInfo.Invoke(null, new object[1] { p1 });
	}

	public override object Invoke(object target, params object[] args)
	{
		Invoke((P1)args[0]);
		return null;
	}
}
public class StaticProxyActionInfo<T, P1, P2> : ProxyMethodInfo, IStaticProxyActionInfo<T, P1, P2>, IProxyMethodInfo, IProxyMemberInfo
{
	private Action<P1, P2> action;

	public override Type DeclaringType => typeof(T);

	public StaticProxyActionInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Action<P1, P2>)null)
	{
	}

	public StaticProxyActionInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Action<P1, P2>)null)
	{
	}

	public StaticProxyActionInfo(MethodInfo info)
		: this(info, (Action<P1, P2>)null)
	{
	}

	public StaticProxyActionInfo(string methodName, Action<P1, P2> action)
		: this(typeof(T).GetMethod(methodName), action)
	{
	}

	public StaticProxyActionInfo(string methodName, Type[] parameterTypes, Action<P1, P2> action)
		: this(typeof(T).GetMethod(methodName, parameterTypes), action)
	{
	}

	public StaticProxyActionInfo(MethodInfo info, Action<P1, P2> action)
		: base(info)
	{
		if (!methodInfo.IsStatic)
		{
			throw new ArgumentException("The method isn't static!");
		}
		if (!typeof(void).Equals(methodInfo.ReturnType) || !typeof(T).Equals(methodInfo.DeclaringType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length != 2 || !typeof(P1).Equals(parameters[0].ParameterType) || !typeof(P2).Equals(parameters[1].ParameterType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		this.action = action;
		if (this.action == null)
		{
			this.action = MakeAction(methodInfo);
		}
	}

	private Action<P1, P2> MakeAction(MethodInfo methodInfo)
	{
		try
		{
			return (Action<P1, P2>)methodInfo.CreateDelegate(typeof(Action<P1, P2>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual void Invoke(P1 p1, P2 p2)
	{
		if (action != null)
		{
			action(p1, p2);
			return;
		}
		methodInfo.Invoke(null, new object[2] { p1, p2 });
	}

	public override object Invoke(object target, params object[] args)
	{
		Invoke((P1)args[0], (P2)args[1]);
		return null;
	}
}
public class StaticProxyActionInfo<T, P1, P2, P3> : ProxyMethodInfo, IStaticProxyActionInfo<T, P1, P2, P3>, IProxyMethodInfo, IProxyMemberInfo
{
	private Action<P1, P2, P3> action;

	public override Type DeclaringType => typeof(T);

	public StaticProxyActionInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Action<P1, P2, P3>)null)
	{
	}

	public StaticProxyActionInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Action<P1, P2, P3>)null)
	{
	}

	public StaticProxyActionInfo(MethodInfo info)
		: this(info, (Action<P1, P2, P3>)null)
	{
	}

	public StaticProxyActionInfo(string methodName, Action<P1, P2, P3> action)
		: this(typeof(T).GetMethod(methodName), action)
	{
	}

	public StaticProxyActionInfo(string methodName, Type[] parameterTypes, Action<P1, P2, P3> action)
		: this(typeof(T).GetMethod(methodName, parameterTypes), action)
	{
	}

	public StaticProxyActionInfo(MethodInfo info, Action<P1, P2, P3> action)
		: base(info)
	{
		if (!methodInfo.IsStatic)
		{
			throw new ArgumentException("The method isn't static!");
		}
		if (!typeof(void).Equals(methodInfo.ReturnType) || !typeof(T).Equals(methodInfo.DeclaringType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length != 3 || !typeof(P1).Equals(parameters[0].ParameterType) || !typeof(P2).Equals(parameters[1].ParameterType) || !typeof(P3).Equals(parameters[2].ParameterType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		this.action = action;
		if (this.action == null)
		{
			this.action = MakeAction(methodInfo);
		}
	}

	private Action<P1, P2, P3> MakeAction(MethodInfo methodInfo)
	{
		try
		{
			return (Action<P1, P2, P3>)methodInfo.CreateDelegate(typeof(Action<P1, P2, P3>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual void Invoke(P1 p1, P2 p2, P3 p3)
	{
		if (action != null)
		{
			action(p1, p2, p3);
			return;
		}
		methodInfo.Invoke(null, new object[3] { p1, p2, p3 });
	}

	public override object Invoke(object target, params object[] args)
	{
		Invoke((P1)args[0], (P2)args[1], (P3)args[2]);
		return null;
	}
}
