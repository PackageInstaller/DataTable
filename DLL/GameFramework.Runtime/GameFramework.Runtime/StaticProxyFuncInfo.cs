#define ENABLE_DEBUG_AND_ABOVE_LOG
using System;
using System.Reflection;

namespace GameFramework.Runtime;

public class StaticProxyFuncInfo<T, TResult> : ProxyMethodInfo, IStaticProxyFuncInfo<T, TResult>, IProxyMethodInfo, IProxyMemberInfo
{
	private Func<TResult> function;

	public override Type DeclaringType => typeof(T);

	public StaticProxyFuncInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Func<TResult>)null)
	{
	}

	public StaticProxyFuncInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Func<TResult>)null)
	{
	}

	public StaticProxyFuncInfo(MethodInfo info)
		: this(info, (Func<TResult>)null)
	{
	}

	public StaticProxyFuncInfo(string methodName, Func<TResult> function)
		: this(typeof(T).GetMethod(methodName), function)
	{
	}

	public StaticProxyFuncInfo(string methodName, Type[] parameterTypes, Func<TResult> function)
		: this(typeof(T).GetMethod(methodName, parameterTypes), function)
	{
	}

	public StaticProxyFuncInfo(MethodInfo info, Func<TResult> function)
		: base(info)
	{
		if (!methodInfo.IsStatic)
		{
			throw new ArgumentException("The method isn't static!");
		}
		if (!typeof(TResult).Equals(methodInfo.ReturnType) || !typeof(T).Equals(methodInfo.DeclaringType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		this.function = function;
		if (this.function == null)
		{
			this.function = MakeFunc(methodInfo);
		}
	}

	private Func<TResult> MakeFunc(MethodInfo methodInfo)
	{
		try
		{
			return (Func<TResult>)methodInfo.CreateDelegate(typeof(Func<TResult>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual TResult Invoke()
	{
		if (function != null)
		{
			return function();
		}
		return (TResult)methodInfo.Invoke(null, null);
	}

	public override object Invoke(object target, params object[] args)
	{
		return Invoke();
	}
}
public class StaticProxyFuncInfo<T, P1, TResult> : ProxyMethodInfo, IStaticProxyFuncInfo<T, P1, TResult>, IProxyMethodInfo, IProxyMemberInfo
{
	private Func<P1, TResult> function;

	public override Type DeclaringType => typeof(T);

	public StaticProxyFuncInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Func<P1, TResult>)null)
	{
	}

	public StaticProxyFuncInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Func<P1, TResult>)null)
	{
	}

	public StaticProxyFuncInfo(MethodInfo info)
		: this(info, (Func<P1, TResult>)null)
	{
	}

	public StaticProxyFuncInfo(string methodName, Func<P1, TResult> function)
		: this(typeof(T).GetMethod(methodName), function)
	{
	}

	public StaticProxyFuncInfo(string methodName, Type[] parameterTypes, Func<P1, TResult> function)
		: this(typeof(T).GetMethod(methodName, parameterTypes), function)
	{
	}

	public StaticProxyFuncInfo(MethodInfo info, Func<P1, TResult> function)
		: base(info)
	{
		if (!methodInfo.IsStatic)
		{
			throw new ArgumentException("The method isn't static!");
		}
		if (!typeof(TResult).Equals(methodInfo.ReturnType) || !typeof(T).Equals(methodInfo.DeclaringType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length != 1 || !typeof(P1).Equals(parameters[0].ParameterType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		this.function = function;
		if (this.function == null)
		{
			this.function = MakeFunc(methodInfo);
		}
	}

	private Func<P1, TResult> MakeFunc(MethodInfo methodInfo)
	{
		try
		{
			return (Func<P1, TResult>)methodInfo.CreateDelegate(typeof(Func<P1, TResult>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual TResult Invoke(P1 p1)
	{
		if (function != null)
		{
			return function(p1);
		}
		return (TResult)methodInfo.Invoke(null, new object[1] { p1 });
	}

	public override object Invoke(object target, params object[] args)
	{
		return Invoke((P1)args[0]);
	}
}
public class StaticProxyFuncInfo<T, P1, P2, TResult> : ProxyMethodInfo, IStaticProxyFuncInfo<T, P1, P2, TResult>, IProxyMethodInfo, IProxyMemberInfo
{
	private Func<P1, P2, TResult> function;

	public override Type DeclaringType => typeof(T);

	public StaticProxyFuncInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Func<P1, P2, TResult>)null)
	{
	}

	public StaticProxyFuncInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Func<P1, P2, TResult>)null)
	{
	}

	public StaticProxyFuncInfo(MethodInfo info)
		: this(info, (Func<P1, P2, TResult>)null)
	{
	}

	public StaticProxyFuncInfo(string methodName, Func<P1, P2, TResult> function)
		: this(typeof(T).GetMethod(methodName), function)
	{
	}

	public StaticProxyFuncInfo(string methodName, Type[] parameterTypes, Func<P1, P2, TResult> function)
		: this(typeof(T).GetMethod(methodName, parameterTypes), function)
	{
	}

	public StaticProxyFuncInfo(MethodInfo info, Func<P1, P2, TResult> function)
		: base(info)
	{
		if (!methodInfo.IsStatic)
		{
			throw new ArgumentException("The method isn't static!");
		}
		if (!typeof(TResult).Equals(methodInfo.ReturnType) || !typeof(T).Equals(methodInfo.DeclaringType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length != 2 || !typeof(P1).Equals(parameters[0].ParameterType) || !typeof(P2).Equals(parameters[1].ParameterType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		this.function = function;
		if (this.function == null)
		{
			this.function = MakeFunc(methodInfo);
		}
	}

	private Func<P1, P2, TResult> MakeFunc(MethodInfo methodInfo)
	{
		try
		{
			return (Func<P1, P2, TResult>)methodInfo.CreateDelegate(typeof(Func<P1, P2, TResult>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual TResult Invoke(P1 p1, P2 p2)
	{
		if (function != null)
		{
			return function(p1, p2);
		}
		return (TResult)methodInfo.Invoke(null, new object[2] { p1, p2 });
	}

	public override object Invoke(object target, params object[] args)
	{
		return Invoke((P1)args[0], (P2)args[1]);
	}
}
public class StaticProxyFuncInfo<T, P1, P2, P3, TResult> : ProxyMethodInfo, IStaticProxyFuncInfo<T, P1, P2, P3, TResult>, IProxyMethodInfo, IProxyMemberInfo
{
	private Func<P1, P2, P3, TResult> function;

	public override Type DeclaringType => typeof(T);

	public StaticProxyFuncInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Func<P1, P2, P3, TResult>)null)
	{
	}

	public StaticProxyFuncInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Func<P1, P2, P3, TResult>)null)
	{
	}

	public StaticProxyFuncInfo(MethodInfo info)
		: this(info, (Func<P1, P2, P3, TResult>)null)
	{
	}

	public StaticProxyFuncInfo(string methodName, Func<P1, P2, P3, TResult> function)
		: this(typeof(T).GetMethod(methodName), function)
	{
	}

	public StaticProxyFuncInfo(string methodName, Type[] parameterTypes, Func<P1, P2, P3, TResult> function)
		: this(typeof(T).GetMethod(methodName, parameterTypes), function)
	{
	}

	public StaticProxyFuncInfo(MethodInfo info, Func<P1, P2, P3, TResult> function)
		: base(info)
	{
		if (!methodInfo.IsStatic)
		{
			throw new ArgumentException("The method isn't static!");
		}
		if (!typeof(TResult).Equals(methodInfo.ReturnType) || !typeof(T).Equals(methodInfo.DeclaringType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length != 3 || !typeof(P1).Equals(parameters[0].ParameterType) || !typeof(P2).Equals(parameters[1].ParameterType) || !typeof(P3).Equals(parameters[2].ParameterType))
		{
			throw new ArgumentException("The method types do not match!");
		}
		this.function = function;
		if (this.function == null)
		{
			this.function = MakeFunc(methodInfo);
		}
	}

	private Func<P1, P2, P3, TResult> MakeFunc(MethodInfo methodInfo)
	{
		try
		{
			return (Func<P1, P2, P3, TResult>)methodInfo.CreateDelegate(typeof(Func<P1, P2, P3, TResult>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual TResult Invoke(P1 p1, P2 p2, P3 p3)
	{
		if (function != null)
		{
			return function(p1, p2, p3);
		}
		return (TResult)methodInfo.Invoke(null, new object[3] { p1, p2, p3 });
	}

	public override object Invoke(object target, params object[] args)
	{
		return Invoke((P1)args[0], (P2)args[1], (P3)args[2]);
	}
}
