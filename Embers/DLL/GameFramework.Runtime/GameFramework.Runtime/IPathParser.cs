using System.Linq.Expressions;

namespace GameFramework.Runtime;

public interface IPathParser
{
	Path Parse(LambdaExpression expression);

	Path Parse(string pathText);

	Path ParseStaticPath(string pathText);

	Path ParseStaticPath(LambdaExpression expression);

	string ParseMemberName(LambdaExpression expression);
}
