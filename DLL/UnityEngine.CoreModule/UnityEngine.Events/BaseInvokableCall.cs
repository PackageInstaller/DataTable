using System;
using System.Reflection;

namespace UnityEngine.Events;

internal abstract class BaseInvokableCall
{
	protected BaseInvokableCall()
	{
	}

	protected BaseInvokableCall(object target, MethodInfo function)
	{
		if (function == null)
		{
			throw new ArgumentNullException("function");
		}
		if (function.IsStatic)
		{
			if (target != null)
			{
				throw new ArgumentException("target must be null");
			}
		}
		else if (target == null)
		{
			throw new ArgumentNullException("target");
		}
	}

	public abstract void Invoke(object[] args);

	protected static void ThrowOnInvalidArg<T>(object arg)
	{
		if (arg != null && !(arg is T))
		{
			throw new ArgumentException(UnityString.Format("Passed argument 'args[0]' is of the wrong type. Type:{0} Expected:{1}", arg.GetType(), typeof(T)));
		}
	}

	protected static bool AllowInvoke(Delegate @delegate)
	{
		object target = @delegate.Target;
		if (target == null)
		{
			return true;
		}
		if (target is Object obj)
		{
			return obj != null;
		}
		return true;
	}

	public abstract bool Find(object targetObj, MethodInfo method);
}
