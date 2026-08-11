using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Dynamic.Utils;
using System.Reflection;
using Unity;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(MemberExpressionProxy))]
public class MemberExpression : Expression
{
	public MemberInfo Member => GetMember();

	public Expression Expression { get; }

	public sealed override ExpressionType NodeType => ExpressionType.MemberAccess;

	internal MemberExpression(Expression expression)
	{
		Expression = expression;
	}

	internal static PropertyExpression Make(Expression expression, PropertyInfo property)
	{
		return new PropertyExpression(expression, property);
	}

	internal static FieldExpression Make(Expression expression, FieldInfo field)
	{
		return new FieldExpression(expression, field);
	}

	internal static MemberExpression Make(Expression expression, MemberInfo member)
	{
		FieldInfo fieldInfo = member as FieldInfo;
		if (!(fieldInfo == null))
		{
			return Make(expression, fieldInfo);
		}
		return Make(expression, (PropertyInfo)member);
	}

	[ExcludeFromCodeCoverage]
	internal virtual MemberInfo GetMember()
	{
		throw ContractUtils.Unreachable;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitMember(this);
	}

	public MemberExpression Update(Expression expression)
	{
		if (expression == Expression)
		{
			return this;
		}
		return Expression.MakeMemberAccess(expression, Member);
	}

	internal MemberExpression()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
