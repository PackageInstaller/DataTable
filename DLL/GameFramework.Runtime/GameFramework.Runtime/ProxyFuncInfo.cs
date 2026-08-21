#define ENABLE_DEBUG_AND_ABOVE_LOG
using System;
using System.Reflection;

namespace GameFramework.Runtime;

public class ProxyFuncInfo<T, TResult> : ProxyMethodInfo, IProxyFuncInfo<T, TResult>, IProxyMethodInfo, IProxyMemberInfo
{
	private Func<T, TResult> function;

	public override Type DeclaringType => typeof(T);

	public ProxyFuncInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Func<T, TResult>)null)
	{
	}

	public ProxyFuncInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Func<T, TResult>)null)
	{
	}

	public ProxyFuncInfo(MethodInfo info)
		: this(info, (Func<T, TResult>)null)
	{
	}

	public ProxyFuncInfo(string methodName, Func<T, TResult> function)
		: this(typeof(T).GetMethod(methodName), function)
	{
	}

	public ProxyFuncInfo(string methodName, Type[] parameterTypes, Func<T, TResult> function)
		: this(typeof(T).GetMethod(methodName, parameterTypes), function)
	{
	}

	public ProxyFuncInfo(MethodInfo info, Func<T, TResult> function)
		: base(info)
	{
		if (IsStatic)
		{
			throw new ArgumentException("The method is static!");
		}
		if (!typeof(TResult).Equals(methodInfo.ReturnType) || !methodInfo.DeclaringType.IsAssignableFrom(typeof(T)))
		{
			throw new ArgumentException("The method types do not match!");
		}
		this.function = function;
		if (this.function == null)
		{
			this.function = MakeFunc(methodInfo);
		}
	}

	private Func<T, TResult> MakeFunc(MethodInfo methodInfo)
	{
		try
		{
			if (isValueType)
			{
				return null;
			}
			return (Func<T, TResult>)base.methodInfo.CreateDelegate(typeof(Func<T, TResult>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual TResult Invoke(T target)
	{
		if (function != null)
		{
			return function(target);
		}
		return (TResult)methodInfo.Invoke(target, null);
	}

	public override object Invoke(object target, params object[] args)
	{
		return Invoke((T)target);
	}
}
public class ProxyFuncInfo<T, P1, TResult> : ProxyMethodInfo, IProxyFuncInfo<T, P1, TResult>, IProxyMethodInfo, IProxyMemberInfo
{
	private Func<T, P1, TResult> function;

	public override Type DeclaringType => typeof(T);

	public ProxyFuncInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Func<T, P1, TResult>)null)
	{
	}

	public ProxyFuncInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Func<T, P1, TResult>)null)
	{
	}

	public ProxyFuncInfo(MethodInfo info)
		: this(info, (Func<T, P1, TResult>)null)
	{
	}

	public ProxyFuncInfo(string methodName, Type[] parameterTypes, Func<T, P1, TResult> function)
		: this(typeof(T).GetMethod(methodName, parameterTypes), function)
	{
	}

	public ProxyFuncInfo(string methodName, Func<T, P1, TResult> function)
		: this(typeof(T).GetMethod(methodName), function)
	{
	}

	public ProxyFuncInfo(MethodInfo info, Func<T, P1, TResult> function)
		: base(info)
	{
		if (IsStatic)
		{
			throw new ArgumentException("The method is static!");
		}
		if (!typeof(TResult).Equals(methodInfo.ReturnType) || !methodInfo.DeclaringType.IsAssignableFrom(typeof(T)))
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

	private Func<T, P1, TResult> MakeFunc(MethodInfo methodInfo)
	{
		try
		{
			if (isValueType)
			{
				return null;
			}
			return (Func<T, P1, TResult>)methodInfo.CreateDelegate(typeof(Func<T, P1, TResult>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual TResult Invoke(T target, P1 p1)
	{
		if (function != null)
		{
			return function(target, p1);
		}
		return (TResult)methodInfo.Invoke(target, new object[1] { p1 });
	}

	public override object Invoke(object target, params object[] args)
	{
		return Invoke((T)target, (P1)args[0]);
	}
}
public class ProxyFuncInfo<T, P1, P2, TResult> : ProxyMethodInfo, IProxyFuncInfo<T, P1, P2, TResult>, IProxyMethodInfo, IProxyMemberInfo
{
	private Func<T, P1, P2, TResult> function;

	public override Type DeclaringType => typeof(T);

	public ProxyFuncInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Func<T, P1, P2, TResult>)null)
	{
	}

	public ProxyFuncInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Func<T, P1, P2, TResult>)null)
	{
	}

	public ProxyFuncInfo(MethodInfo info)
		: this(info, (Func<T, P1, P2, TResult>)null)
	{
	}

	public ProxyFuncInfo(string methodName, Func<T, P1, P2, TResult> function)
		: this(typeof(T).GetMethod(methodName), function)
	{
	}

	public ProxyFuncInfo(string methodName, Type[] parameterTypes, Func<T, P1, P2, TResult> function)
		: this(typeof(T).GetMethod(methodName, parameterTypes), function)
	{
	}

	public ProxyFuncInfo(MethodInfo info, Func<T, P1, P2, TResult> function)
		: base(info)
	{
		if (IsStatic)
		{
			throw new ArgumentException("The method is static!");
		}
		if (!typeof(TResult).Equals(methodInfo.ReturnType) || !methodInfo.DeclaringType.IsAssignableFrom(typeof(T)))
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

	private Func<T, P1, P2, TResult> MakeFunc(MethodInfo methodInfo)
	{
		try
		{
			if (isValueType)
			{
				return null;
			}
			return (Func<T, P1, P2, TResult>)methodInfo.CreateDelegate(typeof(Func<T, P1, P2, TResult>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual TResult Invoke(T target, P1 p1, P2 p2)
	{
		if (function != null)
		{
			return function(target, p1, p2);
		}
		return (TResult)methodInfo.Invoke(target, new object[2] { p1, p2 });
	}

	public override object Invoke(object target, params object[] args)
	{
		return Invoke((T)target, (P1)args[0], (P2)args[1]);
	}
}
public class ProxyFuncInfo<T, P1, P2, P3, TResult> : ProxyMethodInfo, IProxyFuncInfo<T, P1, P2, P3, TResult>, IProxyMethodInfo, IProxyMemberInfo
{
	private Func<T, P1, P2, P3, TResult> function;

	public override Type DeclaringType => typeof(T);

	public ProxyFuncInfo(string methodName)
		: this(typeof(T).GetMethod(methodName), (Func<T, P1, P2, P3, TResult>)null)
	{
	}

	public ProxyFuncInfo(string methodName, Type[] parameterTypes)
		: this(typeof(T).GetMethod(methodName, parameterTypes), (Func<T, P1, P2, P3, TResult>)null)
	{
	}

	public ProxyFuncInfo(MethodInfo info)
		: this(info, (Func<T, P1, P2, P3, TResult>)null)
	{
	}

	public ProxyFuncInfo(string methodName, Func<T, P1, P2, P3, TResult> function)
		: this(typeof(T).GetMethod(methodName), function)
	{
	}

	public ProxyFuncInfo(string methodName, Type[] parameterTypes, Func<T, P1, P2, P3, TResult> function)
		: this(typeof(T).GetMethod(methodName, parameterTypes), function)
	{
	}

	public ProxyFuncInfo(MethodInfo info, Func<T, P1, P2, P3, TResult> function)
		: base(info)
	{
		if (IsStatic)
		{
			throw new ArgumentException("The method is static!");
		}
		if (!typeof(TResult).Equals(methodInfo.ReturnType) || !methodInfo.DeclaringType.IsAssignableFrom(typeof(T)))
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

	private Func<T, P1, P2, P3, TResult> MakeFunc(MethodInfo methodInfo)
	{
		try
		{
			if (isValueType)
			{
				return null;
			}
			return (Func<T, P1, P2, P3, TResult>)methodInfo.CreateDelegate(typeof(Func<T, P1, P2, P3, TResult>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public virtual TResult Invoke(T target, P1 p1, P2 p2, P3 p3)
	{
		if (function != null)
		{
			return function(target, p1, p2, p3);
		}
		return (TResult)methodInfo.Invoke(target, new object[3] { p1, p2, p3 });
	}

	public override object Invoke(object target, params object[] args)
	{
		return Invoke((T)target, (P1)args[0], (P2)args[1], (P3)args[2]);
	}
}
