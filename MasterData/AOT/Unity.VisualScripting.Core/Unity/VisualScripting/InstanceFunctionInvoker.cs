using System;
using System.Linq.Expressions;
using System.Reflection;

namespace Unity.VisualScripting;

public sealed class InstanceFunctionInvoker<TTarget, TResult> : InstanceFunctionInvokerBase<TTarget, TResult>
{
	private Func<TTarget, TResult> invoke;

	public InstanceFunctionInvoker(MethodInfo methodInfo)
		: base(methodInfo)
	{
	}

	public override object Invoke(object target, params object[] args)
	{
		if (args.Length != 0)
		{
			throw new TargetParameterCountException();
		}
		return Invoke(target);
	}

	public override object Invoke(object target)
	{
		if (OptimizedReflection.safeMode)
		{
			VerifyTarget(target);
			try
			{
				return InvokeUnsafe(target);
			}
			catch (TargetInvocationException)
			{
				throw;
			}
			catch (Exception inner)
			{
				throw new TargetInvocationException(inner);
			}
		}
		return InvokeUnsafe(target);
	}

	public object InvokeUnsafe(object target)
	{
		return invoke((TTarget)target);
	}

	protected override Type[] GetParameterTypes()
	{
		return Type.EmptyTypes;
	}

	protected override void CompileExpression(MethodCallExpression callExpression, ParameterExpression[] parameterExpressions)
	{
		invoke = Expression.Lambda<Func<TTarget, TResult>>(callExpression, parameterExpressions).Compile();
	}

	protected override void CreateDelegate()
	{
		invoke = (Func<TTarget, TResult>)methodInfo.CreateDelegate(typeof(Func<TTarget, TResult>));
	}
}
public sealed class InstanceFunctionInvoker<TTarget, TParam0, TResult> : InstanceFunctionInvokerBase<TTarget, TResult>
{
	private Func<TTarget, TParam0, TResult> invoke;

	public InstanceFunctionInvoker(MethodInfo methodInfo)
		: base(methodInfo)
	{
	}

	public override object Invoke(object target, params object[] args)
	{
		if (args.Length != 1)
		{
			throw new TargetParameterCountException();
		}
		return Invoke(target, args[0]);
	}

	public override object Invoke(object target, object arg0)
	{
		if (OptimizedReflection.safeMode)
		{
			VerifyTarget(target);
			VerifyArgument<TParam0>(methodInfo, 0, arg0);
			try
			{
				return InvokeUnsafe(target, arg0);
			}
			catch (TargetInvocationException)
			{
				throw;
			}
			catch (Exception inner)
			{
				throw new TargetInvocationException(inner);
			}
		}
		return InvokeUnsafe(target, arg0);
	}

	public object InvokeUnsafe(object target, object arg0)
	{
		return invoke((TTarget)target, (TParam0)arg0);
	}

	protected override Type[] GetParameterTypes()
	{
		return new Type[1] { typeof(TParam0) };
	}

	protected override void CompileExpression(MethodCallExpression callExpression, ParameterExpression[] parameterExpressions)
	{
		invoke = Expression.Lambda<Func<TTarget, TParam0, TResult>>(callExpression, parameterExpressions).Compile();
	}

	protected override void CreateDelegate()
	{
		invoke = (Func<TTarget, TParam0, TResult>)methodInfo.CreateDelegate(typeof(Func<TTarget, TParam0, TResult>));
	}
}
public sealed class InstanceFunctionInvoker<TTarget, TParam0, TParam1, TResult> : InstanceFunctionInvokerBase<TTarget, TResult>
{
	private Func<TTarget, TParam0, TParam1, TResult> invoke;

	public InstanceFunctionInvoker(MethodInfo methodInfo)
		: base(methodInfo)
	{
	}

	public override object Invoke(object target, params object[] args)
	{
		if (args.Length != 2)
		{
			throw new TargetParameterCountException();
		}
		return Invoke(target, args[0], args[1]);
	}

	public override object Invoke(object target, object arg0, object arg1)
	{
		if (OptimizedReflection.safeMode)
		{
			VerifyTarget(target);
			VerifyArgument<TParam0>(methodInfo, 0, arg0);
			VerifyArgument<TParam1>(methodInfo, 1, arg1);
			try
			{
				return InvokeUnsafe(target, arg0, arg1);
			}
			catch (TargetInvocationException)
			{
				throw;
			}
			catch (Exception inner)
			{
				throw new TargetInvocationException(inner);
			}
		}
		return InvokeUnsafe(target, arg0, arg1);
	}

	public object InvokeUnsafe(object target, object arg0, object arg1)
	{
		return invoke((TTarget)target, (TParam0)arg0, (TParam1)arg1);
	}

	protected override Type[] GetParameterTypes()
	{
		return new Type[2]
		{
			typeof(TParam0),
			typeof(TParam1)
		};
	}

	protected override void CompileExpression(MethodCallExpression callExpression, ParameterExpression[] parameterExpressions)
	{
		invoke = Expression.Lambda<Func<TTarget, TParam0, TParam1, TResult>>(callExpression, parameterExpressions).Compile();
	}

	protected override void CreateDelegate()
	{
		invoke = (Func<TTarget, TParam0, TParam1, TResult>)methodInfo.CreateDelegate(typeof(Func<TTarget, TParam0, TParam1, TResult>));
	}
}
public sealed class InstanceFunctionInvoker<TTarget, TParam0, TParam1, TParam2, TResult> : InstanceFunctionInvokerBase<TTarget, TResult>
{
	private Func<TTarget, TParam0, TParam1, TParam2, TResult> invoke;

	public InstanceFunctionInvoker(MethodInfo methodInfo)
		: base(methodInfo)
	{
	}

	public override object Invoke(object target, params object[] args)
	{
		if (args.Length != 3)
		{
			throw new TargetParameterCountException();
		}
		return Invoke(target, args[0], args[1], args[2]);
	}

	public override object Invoke(object target, object arg0, object arg1, object arg2)
	{
		if (OptimizedReflection.safeMode)
		{
			VerifyTarget(target);
			VerifyArgument<TParam0>(methodInfo, 0, arg0);
			VerifyArgument<TParam1>(methodInfo, 1, arg1);
			VerifyArgument<TParam2>(methodInfo, 2, arg2);
			try
			{
				return InvokeUnsafe(target, arg0, arg1, arg2);
			}
			catch (TargetInvocationException)
			{
				throw;
			}
			catch (Exception inner)
			{
				throw new TargetInvocationException(inner);
			}
		}
		return InvokeUnsafe(target, arg0, arg1, arg2);
	}

	public object InvokeUnsafe(object target, object arg0, object arg1, object arg2)
	{
		return invoke((TTarget)target, (TParam0)arg0, (TParam1)arg1, (TParam2)arg2);
	}

	protected override Type[] GetParameterTypes()
	{
		return new Type[3]
		{
			typeof(TParam0),
			typeof(TParam1),
			typeof(TParam2)
		};
	}

	protected override void CompileExpression(MethodCallExpression callExpression, ParameterExpression[] parameterExpressions)
	{
		invoke = Expression.Lambda<Func<TTarget, TParam0, TParam1, TParam2, TResult>>(callExpression, parameterExpressions).Compile();
	}

	protected override void CreateDelegate()
	{
		invoke = (Func<TTarget, TParam0, TParam1, TParam2, TResult>)methodInfo.CreateDelegate(typeof(Func<TTarget, TParam0, TParam1, TParam2, TResult>));
	}
}
public sealed class InstanceFunctionInvoker<TTarget, TParam0, TParam1, TParam2, TParam3, TResult> : InstanceFunctionInvokerBase<TTarget, TResult>
{
	private Func<TTarget, TParam0, TParam1, TParam2, TParam3, TResult> invoke;

	public InstanceFunctionInvoker(MethodInfo methodInfo)
		: base(methodInfo)
	{
	}

	public override object Invoke(object target, params object[] args)
	{
		if (args.Length != 4)
		{
			throw new TargetParameterCountException();
		}
		return Invoke(target, args[0], args[1], args[2], args[3]);
	}

	public override object Invoke(object target, object arg0, object arg1, object arg2, object arg3)
	{
		if (OptimizedReflection.safeMode)
		{
			VerifyTarget(target);
			VerifyArgument<TParam0>(methodInfo, 0, arg0);
			VerifyArgument<TParam1>(methodInfo, 1, arg1);
			VerifyArgument<TParam2>(methodInfo, 2, arg2);
			VerifyArgument<TParam3>(methodInfo, 3, arg3);
			try
			{
				return InvokeUnsafe(target, arg0, arg1, arg2, arg3);
			}
			catch (TargetInvocationException)
			{
				throw;
			}
			catch (Exception inner)
			{
				throw new TargetInvocationException(inner);
			}
		}
		return InvokeUnsafe(target, arg0, arg1, arg2, arg3);
	}

	public object InvokeUnsafe(object target, object arg0, object arg1, object arg2, object arg3)
	{
		return invoke((TTarget)target, (TParam0)arg0, (TParam1)arg1, (TParam2)arg2, (TParam3)arg3);
	}

	protected override Type[] GetParameterTypes()
	{
		return new Type[4]
		{
			typeof(TParam0),
			typeof(TParam1),
			typeof(TParam2),
			typeof(TParam3)
		};
	}

	protected override void CompileExpression(MethodCallExpression callExpression, ParameterExpression[] parameterExpressions)
	{
		invoke = Expression.Lambda<Func<TTarget, TParam0, TParam1, TParam2, TParam3, TResult>>(callExpression, parameterExpressions).Compile();
	}

	protected override void CreateDelegate()
	{
		invoke = (Func<TTarget, TParam0, TParam1, TParam2, TParam3, TResult>)methodInfo.CreateDelegate(typeof(Func<TTarget, TParam0, TParam1, TParam2, TParam3, TResult>));
	}
}
public sealed class InstanceFunctionInvoker<TTarget, TParam0, TParam1, TParam2, TParam3, TParam4, TResult> : InstanceFunctionInvokerBase<TTarget, TResult>
{
	private Func<TTarget, TParam0, TParam1, TParam2, TParam3, TParam4, TResult> invoke;

	public InstanceFunctionInvoker(MethodInfo methodInfo)
		: base(methodInfo)
	{
	}

	public override object Invoke(object target, params object[] args)
	{
		if (args.Length != 5)
		{
			throw new TargetParameterCountException();
		}
		return Invoke(target, args[0], args[1], args[2], args[3], args[4]);
	}

	public override object Invoke(object target, object arg0, object arg1, object arg2, object arg3, object arg4)
	{
		if (OptimizedReflection.safeMode)
		{
			VerifyTarget(target);
			VerifyArgument<TParam0>(methodInfo, 0, arg0);
			VerifyArgument<TParam1>(methodInfo, 1, arg1);
			VerifyArgument<TParam2>(methodInfo, 2, arg2);
			VerifyArgument<TParam3>(methodInfo, 3, arg3);
			VerifyArgument<TParam4>(methodInfo, 4, arg4);
			try
			{
				return InvokeUnsafe(target, arg0, arg1, arg2, arg3, arg4);
			}
			catch (TargetInvocationException)
			{
				throw;
			}
			catch (Exception inner)
			{
				throw new TargetInvocationException(inner);
			}
		}
		return InvokeUnsafe(target, arg0, arg1, arg2, arg3, arg4);
	}

	public object InvokeUnsafe(object target, object arg0, object arg1, object arg2, object arg3, object arg4)
	{
		return invoke((TTarget)target, (TParam0)arg0, (TParam1)arg1, (TParam2)arg2, (TParam3)arg3, (TParam4)arg4);
	}

	protected override Type[] GetParameterTypes()
	{
		return new Type[5]
		{
			typeof(TParam0),
			typeof(TParam1),
			typeof(TParam2),
			typeof(TParam3),
			typeof(TParam4)
		};
	}

	protected override void CompileExpression(MethodCallExpression callExpression, ParameterExpression[] parameterExpressions)
	{
		invoke = Expression.Lambda<Func<TTarget, TParam0, TParam1, TParam2, TParam3, TParam4, TResult>>(callExpression, parameterExpressions).Compile();
	}

	protected override void CreateDelegate()
	{
		invoke = (Func<TTarget, TParam0, TParam1, TParam2, TParam3, TParam4, TResult>)methodInfo.CreateDelegate(typeof(Func<TTarget, TParam0, TParam1, TParam2, TParam3, TParam4, TResult>));
	}
}
