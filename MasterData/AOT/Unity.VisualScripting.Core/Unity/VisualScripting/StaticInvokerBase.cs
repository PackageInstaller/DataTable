using System;
using System.Linq.Expressions;
using System.Reflection;

namespace Unity.VisualScripting;

public abstract class StaticInvokerBase : InvokerBase
{
	protected StaticInvokerBase(MethodInfo methodInfo)
		: base(methodInfo)
	{
		if (OptimizedReflection.safeMode && !methodInfo.IsStatic)
		{
			throw new ArgumentException("The method isn't static.", "methodInfo");
		}
	}

	protected sealed override void CompileExpression()
	{
		ParameterExpression[] parameterExpressions = GetParameterExpressions();
		MethodInfo method = methodInfo;
		Expression[] arguments = parameterExpressions;
		MethodCallExpression callExpression = Expression.Call(method, arguments);
		CompileExpression(callExpression, parameterExpressions);
	}

	protected abstract void CompileExpression(MethodCallExpression callExpression, ParameterExpression[] parameterExpressions);

	protected override void VerifyTarget(object target)
	{
		OptimizedReflection.VerifyStaticTarget(targetType, target);
	}
}
