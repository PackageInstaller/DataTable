using System.Collections.Generic;
using System.Linq.Expressions;

namespace GameFramework.Runtime;

public interface IExpressionPathFinder
{
	List<Path> FindPaths(LambdaExpression expression);
}
