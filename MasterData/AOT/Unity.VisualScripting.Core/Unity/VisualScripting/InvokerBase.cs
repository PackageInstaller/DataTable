using System;
using System.Linq.Expressions;
using System.Reflection;

namespace Unity.VisualScripting;

public abstract class InvokerBase : IOptimizedInvoker
{
	protected readonly Type targetType;

	protected readonly MethodInfo methodInfo;

	protected InvokerBase(MethodInfo methodInfo)
	{
		if (OptimizedReflection.safeMode && methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		this.methodInfo = methodInfo;
		targetType = methodInfo.DeclaringType;
	}

	protected void VerifyArgument<TParam>(MethodInfo methodInfo, int argIndex, object arg)
	{
		if (!typeof(TParam).IsAssignableFrom(arg))
		{
			throw new ArgumentException(string.Format("The provided argument value for '{0}.{1}' does not match the parameter type.\nProvided: {2}\nExpected: {3}", targetType, methodInfo.Name, arg?.GetType().ToString() ?? "null", typeof(TParam)), methodInfo.GetParameters()[argIndex].Name);
		}
	}

	public void Compile()
	{
		if (OptimizedReflection.useJit)
		{
			CompileExpression();
		}
		else
		{
			CreateDelegate();
		}
	}

	protected ParameterExpression[] GetParameterExpressions()
	{
		ParameterInfo[] parameters = methodInfo.GetParameters();
		Type[] parameterTypes = GetParameterTypes();
		if (parameters.Length != parameterTypes.Length)
		{
			throw new ArgumentException("Parameter count of method info doesn't match generic argument count.", "methodInfo");
		}
		for (int i = 0; i < parameterTypes.Length; i++)
		{
			if (parameterTypes[i] != parameters[i].ParameterType)
			{
				throw new ArgumentException("Parameter type of method info doesn't match generic argument.", "methodInfo");
			}
		}
		ParameterExpression[] array = new ParameterExpression[parameterTypes.Length];
		for (int j = 0; j < parameterTypes.Length; j++)
		{
			array[j] = Expression.Parameter(parameterTypes[j], "parameter" + j);
		}
		return array;
	}

	protected abstract Type[] GetParameterTypes();

	public abstract object Invoke(object target, params object[] args);

	public virtual object Invoke(object target)
	{
		throw new TargetParameterCountException();
	}

	public virtual object Invoke(object target, object arg0)
	{
		throw new TargetParameterCountException();
	}

	public virtual object Invoke(object target, object arg0, object arg1)
	{
		throw new TargetParameterCountException();
	}

	public virtual object Invoke(object target, object arg0, object arg1, object arg2)
	{
		throw new TargetParameterCountException();
	}

	public virtual object Invoke(object target, object arg0, object arg1, object arg2, object arg3)
	{
		throw new TargetParameterCountException();
	}

	public virtual object Invoke(object target, object arg0, object arg1, object arg2, object arg3, object arg4)
	{
		throw new TargetParameterCountException();
	}

	protected abstract void CompileExpression();

	protected abstract void CreateDelegate();

	protected abstract void VerifyTarget(object target);
}
