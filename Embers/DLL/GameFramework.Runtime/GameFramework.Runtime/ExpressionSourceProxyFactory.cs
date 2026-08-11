using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace GameFramework.Runtime;

public class ExpressionSourceProxyFactory : TypedSourceProxyFactory<ExpressionSourceDescription>
{
	private ISourceProxyFactory factory;

	private IExpressionPathFinder pathFinder;

	public ExpressionSourceProxyFactory(ISourceProxyFactory factory, IExpressionPathFinder pathFinder)
	{
		this.factory = factory;
		this.pathFinder = pathFinder;
	}

	protected override bool TryCreateProxy(object source, ExpressionSourceDescription description, out ISourceProxy proxy)
	{
		proxy = null;
		LambdaExpression expression = description.Expression;
		List<ISourceProxy> list = new List<ISourceProxy>();
		List<Path> list2 = pathFinder.FindPaths(expression);
		foreach (Path item in list2)
		{
			if (item.IsStatic || (source != null && (!(item[0] is MemberNode memberNode) || !(memberNode.MemberInfo != null) || memberNode.MemberInfo.DeclaringType.IsAssignableFrom(source.GetType()))))
			{
				ISourceProxy sourceProxy = factory.CreateProxy(source, new ObjectSourceDescription
				{
					Path = item
				});
				if (sourceProxy != null)
				{
					list.Add(sourceProxy);
				}
			}
		}
		Func<object[], object> func = expression.DynamicCompile();
		proxy = new ExpressionSourceProxy(description.IsStatic ? null : source, func, description.ReturnType, list);
		if (proxy != null)
		{
			return true;
		}
		return false;
	}
}
