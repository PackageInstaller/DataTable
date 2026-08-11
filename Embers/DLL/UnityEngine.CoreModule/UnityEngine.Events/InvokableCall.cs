using System;
using System.Reflection;

namespace UnityEngine.Events;

internal class InvokableCall : BaseInvokableCall
{
	private event UnityAction Delegate;

	public InvokableCall(object target, MethodInfo theFunction)
		: base(target, theFunction)
	{
		Delegate += (UnityAction)System.Delegate.CreateDelegate(typeof(UnityAction), target, theFunction);
	}

	public InvokableCall(UnityAction action)
	{
		Delegate += action;
	}

	public override void Invoke(object[] args)
	{
		if (BaseInvokableCall.AllowInvoke(Delegate))
		{
			Delegate();
		}
	}

	public void Invoke()
	{
		if (BaseInvokableCall.AllowInvoke(Delegate))
		{
			Delegate();
		}
	}

	public override bool Find(object targetObj, MethodInfo method)
	{
		return Delegate.Target == targetObj && Delegate.Method.Equals(method);
	}
}
internal class InvokableCall<T1> : BaseInvokableCall
{
	protected event UnityAction<T1> Delegate;

	public InvokableCall(object target, MethodInfo theFunction)
		: base(target, theFunction)
	{
		Delegate += (UnityAction<T1>)System.Delegate.CreateDelegate(typeof(UnityAction<T1>), target, theFunction);
	}

	public InvokableCall(UnityAction<T1> action)
	{
		Delegate += action;
	}

	public override void Invoke(object[] args)
	{
		if (args.Length != 1)
		{
			throw new ArgumentException("Passed argument 'args' is invalid size. Expected size is 1");
		}
		BaseInvokableCall.ThrowOnInvalidArg<T1>(args[0]);
		if (BaseInvokableCall.AllowInvoke(Delegate))
		{
			Delegate((T1)args[0]);
		}
	}

	public virtual void Invoke(T1 args0)
	{
		if (BaseInvokableCall.AllowInvoke(Delegate))
		{
			Delegate(args0);
		}
	}

	public override bool Find(object targetObj, MethodInfo method)
	{
		return Delegate.Target == targetObj && Delegate.Method.Equals(method);
	}
}
internal class InvokableCall<T1, T2> : BaseInvokableCall
{
	protected event UnityAction<T1, T2> Delegate;

	public InvokableCall(object target, MethodInfo theFunction)
		: base(target, theFunction)
	{
		Delegate = (UnityAction<T1, T2>)System.Delegate.CreateDelegate(typeof(UnityAction<T1, T2>), target, theFunction);
	}

	public InvokableCall(UnityAction<T1, T2> action)
	{
		Delegate += action;
	}

	public override void Invoke(object[] args)
	{
		if (args.Length != 2)
		{
			throw new ArgumentException("Passed argument 'args' is invalid size. Expected size is 1");
		}
		BaseInvokableCall.ThrowOnInvalidArg<T1>(args[0]);
		BaseInvokableCall.ThrowOnInvalidArg<T2>(args[1]);
		if (BaseInvokableCall.AllowInvoke(Delegate))
		{
			Delegate((T1)args[0], (T2)args[1]);
		}
	}

	public void Invoke(T1 args0, T2 args1)
	{
		if (BaseInvokableCall.AllowInvoke(Delegate))
		{
			Delegate(args0, args1);
		}
	}

	public override bool Find(object targetObj, MethodInfo method)
	{
		return Delegate.Target == targetObj && Delegate.Method.Equals(method);
	}
}
internal class InvokableCall<T1, T2, T3> : BaseInvokableCall
{
	protected event UnityAction<T1, T2, T3> Delegate;

	public InvokableCall(object target, MethodInfo theFunction)
		: base(target, theFunction)
	{
		Delegate = (UnityAction<T1, T2, T3>)System.Delegate.CreateDelegate(typeof(UnityAction<T1, T2, T3>), target, theFunction);
	}

	public InvokableCall(UnityAction<T1, T2, T3> action)
	{
		Delegate += action;
	}

	public override void Invoke(object[] args)
	{
		if (args.Length != 3)
		{
			throw new ArgumentException("Passed argument 'args' is invalid size. Expected size is 1");
		}
		BaseInvokableCall.ThrowOnInvalidArg<T1>(args[0]);
		BaseInvokableCall.ThrowOnInvalidArg<T2>(args[1]);
		BaseInvokableCall.ThrowOnInvalidArg<T3>(args[2]);
		if (BaseInvokableCall.AllowInvoke(Delegate))
		{
			Delegate((T1)args[0], (T2)args[1], (T3)args[2]);
		}
	}

	public void Invoke(T1 args0, T2 args1, T3 args2)
	{
		if (BaseInvokableCall.AllowInvoke(Delegate))
		{
			Delegate(args0, args1, args2);
		}
	}

	public override bool Find(object targetObj, MethodInfo method)
	{
		return Delegate.Target == targetObj && Delegate.Method.Equals(method);
	}
}
internal class InvokableCall<T1, T2, T3, T4> : BaseInvokableCall
{
	protected event UnityAction<T1, T2, T3, T4> Delegate;

	public InvokableCall(object target, MethodInfo theFunction)
		: base(target, theFunction)
	{
		Delegate = (UnityAction<T1, T2, T3, T4>)System.Delegate.CreateDelegate(typeof(UnityAction<T1, T2, T3, T4>), target, theFunction);
	}

	public InvokableCall(UnityAction<T1, T2, T3, T4> action)
	{
		Delegate += action;
	}

	public override void Invoke(object[] args)
	{
		if (args.Length != 4)
		{
			throw new ArgumentException("Passed argument 'args' is invalid size. Expected size is 1");
		}
		BaseInvokableCall.ThrowOnInvalidArg<T1>(args[0]);
		BaseInvokableCall.ThrowOnInvalidArg<T2>(args[1]);
		BaseInvokableCall.ThrowOnInvalidArg<T3>(args[2]);
		BaseInvokableCall.ThrowOnInvalidArg<T4>(args[3]);
		if (BaseInvokableCall.AllowInvoke(Delegate))
		{
			Delegate((T1)args[0], (T2)args[1], (T3)args[2], (T4)args[3]);
		}
	}

	public void Invoke(T1 args0, T2 args1, T3 args2, T4 args3)
	{
		if (BaseInvokableCall.AllowInvoke(Delegate))
		{
			Delegate(args0, args1, args2, args3);
		}
	}

	public override bool Find(object targetObj, MethodInfo method)
	{
		return Delegate.Target == targetObj && Delegate.Method.Equals(method);
	}
}
