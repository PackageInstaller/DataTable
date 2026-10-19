using System;
using System.Linq.Expressions;
using System.Reflection;

namespace Unity.VisualScripting;

public abstract class InstanceInvokerBase<TTarget> : InvokerBase
{
	protected InstanceInvokerBase(MethodInfo methodInfo)
		: base(methodInfo)
	{
		if (OptimizedReflection.safeMode)
		{
			if (methodInfo.DeclaringType != typeof(TTarget))
			{
				throw new ArgumentException("Declaring type of method info doesn't match generic type.", "methodInfo");
			}
			if (methodInfo.IsStatic)
			{
				throw new ArgumentException("The method is static.", "methodInfo");
			}
		}
	}

	protected sealed override void CompileExpression()
	{
		ParameterExpression parameterExpression = Expression.Parameter(typeof(TTarget), "target");
		ParameterExpression[] parameterExpressions = GetParameterExpressions();
		ParameterExpression[] array = new ParameterExpression[1 + parameterExpressions.Length];
		array[0] = parameterExpression;
		Array.Copy(parameterExpressions, 0, array, 1, parameterExpressions.Length);
		MethodInfo method = methodInfo;
		Expression[] arguments = parameterExpressions;
		MethodCallExpression callExpression = Expression.Call(parameterExpression, method, arguments);
		CompileExpression(callExpression, array);
	}

	protected abstract void CompileExpression(MethodCallExpression callExpression, ParameterExpression[] parameterExpressions);

	protected override void VerifyTarget(object target)
	{
		OptimizedReflection.VerifyInstanceTarget<TTarget>(target);
	}
}
