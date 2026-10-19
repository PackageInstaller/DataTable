using System.Reflection;

namespace System.Linq.Expressions;

internal class InstanceMethodCallExpression : MethodCallExpression, IArgumentProvider
{
	private readonly Expression _instance;

	public InstanceMethodCallExpression(MethodInfo method, Expression instance)
		: base(method)
	{
		_instance = instance;
	}

	internal override Expression GetInstance()
	{
		return _instance;
	}
}
