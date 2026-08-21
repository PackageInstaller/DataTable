using System.Diagnostics;
using Unity;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(ConstantExpressionProxy))]
public class ConstantExpression : Expression
{
	public override Type Type
	{
		get
		{
			if (Value == null)
			{
				return typeof(object);
			}
			return Value.GetType();
		}
	}

	public sealed override ExpressionType NodeType => ExpressionType.Constant;

	public object Value { get; }

	internal ConstantExpression(object value)
	{
		Value = value;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitConstant(this);
	}

	internal ConstantExpression()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
