#define ENABLE_LOG
using System;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace GameFramework.Runtime;

public static class WeakDelegateExtensions
{
	public static Action AsWeak(this Action action)
	{
		if (!IsCanWeaken(action))
		{
			return action;
		}
		Type type = action.Target.GetType();
		WeakReference targetRef = new WeakReference(action.Target);
		MethodInfo method = action.Method;
		return delegate
		{
			object target = targetRef.Target;
			if (target == null)
			{
				Log.Warning("You are trying to invoke a weak reference delegate({0}.{1}), and the target object has been destroyed.", type, method);
			}
			else
			{
				method.Invoke(target, null);
			}
		};
	}

	public static Action<T> AsWeak<T>(this Action<T> action)
	{
		if (!IsCanWeaken(action))
		{
			return action;
		}
		Type type = action.Target.GetType();
		WeakReference targetRef = new WeakReference(action.Target);
		MethodInfo method = action.Method;
		return delegate(T t)
		{
			object target = targetRef.Target;
			if (target == null)
			{
				Log.Warning("You are trying to invoke a weak reference delegate({0}.{1}), and the target object has been destroyed.", type, method);
			}
			else
			{
				method.Invoke(target, new object[1] { t });
			}
		};
	}

	public static Action<T1, T2> AsWeak<T1, T2>(this Action<T1, T2> action)
	{
		if (!IsCanWeaken(action))
		{
			return action;
		}
		Type type = action.Target.GetType();
		WeakReference targetRef = new WeakReference(action.Target);
		MethodInfo method = action.Method;
		return delegate(T1 t1, T2 t2)
		{
			object target = targetRef.Target;
			if (target == null)
			{
				Log.Warning("You are trying to invoke a weak reference delegate({0}.{1}), and the target object has been destroyed.", type, method);
			}
			else
			{
				method.Invoke(target, new object[2] { t1, t2 });
			}
		};
	}

	public static Action<T1, T2, T3> AsWeak<T1, T2, T3>(this Action<T1, T2, T3> action)
	{
		if (!IsCanWeaken(action))
		{
			return action;
		}
		Type type = action.Target.GetType();
		WeakReference targetRef = new WeakReference(action.Target);
		MethodInfo method = action.Method;
		return delegate(T1 t1, T2 t2, T3 t3)
		{
			object target = targetRef.Target;
			if (target == null)
			{
				Log.Warning("You are trying to invoke a weak reference delegate({0}.{1}), and the target object has been destroyed.", type, method);
			}
			else
			{
				method.Invoke(target, new object[3] { t1, t2, t3 });
			}
		};
	}

	public static Action<T1, T2, T3, T4> AsWeak<T1, T2, T3, T4>(this Action<T1, T2, T3, T4> action)
	{
		if (!IsCanWeaken(action))
		{
			return action;
		}
		Type type = action.Target.GetType();
		WeakReference targetRef = new WeakReference(action.Target);
		MethodInfo method = action.Method;
		return delegate(T1 t1, T2 t2, T3 t3, T4 t4)
		{
			object target = targetRef.Target;
			if (target == null)
			{
				Log.Warning("You are trying to invoke a weak reference delegate({0}.{1}), and the target object has been destroyed.", type, method);
			}
			else
			{
				method.Invoke(target, new object[4] { t1, t2, t3, t4 });
			}
		};
	}

	public static Func<TResult> AsWeak<TResult>(this Func<TResult> func)
	{
		if (!IsCanWeaken(func))
		{
			return func;
		}
		Type type = func.Target.GetType();
		WeakReference targetRef = new WeakReference(func.Target);
		MethodInfo method = func.Method;
		return delegate
		{
			object target = targetRef.Target;
			if (target == null)
			{
				Log.Warning("You are trying to invoke a weak reference delegate({0}.{1}), and the target object has been destroyed.", type, method);
				throw new Exception($"You are trying to invoke a weak reference delegate({type}.{method}), and the target object has been destroyed.");
			}
			return (TResult)method.Invoke(target, null);
		};
	}

	public static Func<T, TResult> AsWeak<T, TResult>(this Func<T, TResult> func)
	{
		if (!IsCanWeaken(func))
		{
			return func;
		}
		Type type = func.Target.GetType();
		WeakReference targetRef = new WeakReference(func.Target);
		MethodInfo method = func.Method;
		return delegate(T t)
		{
			object target = targetRef.Target;
			if (target == null)
			{
				Log.Warning("You are trying to invoke a weak reference delegate({0}.{1}), and the target object has been destroyed.", type, method);
				throw new Exception($"You are trying to invoke a weak reference delegate({type}.{method}), and the target object has been destroyed.");
			}
			return (TResult)method.Invoke(target, new object[1] { t });
		};
	}

	public static Func<T1, T2, TResult> AsWeak<T1, T2, TResult>(this Func<T1, T2, TResult> func)
	{
		if (!IsCanWeaken(func))
		{
			return func;
		}
		Type type = func.Target.GetType();
		WeakReference targetRef = new WeakReference(func.Target);
		MethodInfo method = func.Method;
		return delegate(T1 t1, T2 t2)
		{
			object target = targetRef.Target;
			if (target == null)
			{
				Log.Warning("You are trying to invoke a weak reference delegate({0}.{1}), and the target object has been destroyed.", type, method);
				throw new Exception($"You are trying to invoke a weak reference delegate({type}.{method}), and the target object has been destroyed.");
			}
			return (TResult)method.Invoke(target, new object[2] { t1, t2 });
		};
	}

	public static Func<T1, T2, T3, TResult> AsWeak<T1, T2, T3, TResult>(this Func<T1, T2, T3, TResult> func)
	{
		if (!IsCanWeaken(func))
		{
			return func;
		}
		Type type = func.Target.GetType();
		WeakReference targetRef = new WeakReference(func.Target);
		MethodInfo method = func.Method;
		return delegate(T1 t1, T2 t2, T3 t3)
		{
			object target = targetRef.Target;
			if (target == null)
			{
				Log.Warning("You are trying to invoke a weak reference delegate({0}.{1}), and the target object has been destroyed.", type, method);
				throw new Exception($"You are trying to invoke a weak reference delegate({type}.{method}), and the target object has been destroyed.");
			}
			return (TResult)method.Invoke(target, new object[3] { t1, t2, t3 });
		};
	}

	public static Func<T1, T2, T3, T4, TResult> AsWeak<T1, T2, T3, T4, TResult>(this Func<T1, T2, T3, T4, TResult> func)
	{
		if (!IsCanWeaken(func))
		{
			return func;
		}
		Type type = func.Target.GetType();
		WeakReference targetRef = new WeakReference(func.Target);
		MethodInfo method = func.Method;
		return delegate(T1 t1, T2 t2, T3 t3, T4 t4)
		{
			object target = targetRef.Target;
			if (target == null)
			{
				Log.Warning("You are trying to invoke a weak reference delegate({0}.{1}), and the target object has been destroyed.", type, method);
				throw new Exception($"You are trying to invoke a weak reference delegate({type}.{method}), and the target object has been destroyed.");
			}
			return (TResult)method.Invoke(target, new object[4] { t1, t2, t3, t4 });
		};
	}

	private static bool IsCanWeaken(Delegate del)
	{
		if ((object)del == null || del.Method.IsStatic || del.Target == null || IsClosure(del))
		{
			return false;
		}
		return true;
	}

	private static bool IsClosure(Delegate del)
	{
		if ((object)del == null || del.Method.IsStatic || del.Target == null)
		{
			return false;
		}
		Type type = del.Target.GetType();
		bool flag = !type.IsVisible;
		bool flag2 = type.GetCustomAttributes(typeof(CompilerGeneratedAttribute), inherit: false).Length != 0;
		bool flag3 = type.IsNested && type.MemberType == MemberTypes.NestedType;
		return flag3 & flag2 & flag;
	}
}
