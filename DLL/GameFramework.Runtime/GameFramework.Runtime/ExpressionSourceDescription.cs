using System;
using System.Linq.Expressions;
using System.Reflection;

namespace GameFramework.Runtime;

public class ExpressionSourceDescription : SourceDescription
{
	private LambdaExpression expression;

	private Type returnType;

	public LambdaExpression Expression
	{
		get
		{
			return expression;
		}
		set
		{
			expression = value;
			Type[] genericArguments = expression.GetType().GetGenericArguments();
			Type type = genericArguments[0];
			if (!typeof(Delegate).IsAssignableFrom(type))
			{
				throw new NotSupportedException();
			}
			MethodInfo method = type.GetMethod("Invoke");
			returnType = method.ReturnType;
			ParameterInfo[] parameters = method.GetParameters();
			IsStatic = ((parameters == null || parameters.Length == 0) ? true : false);
		}
	}

	public Type ReturnType => returnType;

	public override string ToString()
	{
		return (expression == null) ? "Expression:null" : ("Expression:" + expression.ToString());
	}
}
