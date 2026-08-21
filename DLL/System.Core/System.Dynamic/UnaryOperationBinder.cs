using System.Dynamic.Utils;
using System.Linq.Expressions;

namespace System.Dynamic;

public abstract class UnaryOperationBinder : DynamicMetaObjectBinder
{
	public sealed override Type ReturnType
	{
		get
		{
			ExpressionType operation = Operation;
			if ((uint)(operation - 83) <= 1u)
			{
				return typeof(bool);
			}
			return typeof(object);
		}
	}

	public ExpressionType Operation { get; }

	public DynamicMetaObject FallbackUnaryOperation(DynamicMetaObject target)
	{
		return FallbackUnaryOperation(target, null);
	}

	public abstract DynamicMetaObject FallbackUnaryOperation(DynamicMetaObject target, DynamicMetaObject errorSuggestion);

	public sealed override DynamicMetaObject Bind(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		ContractUtils.RequiresNotNull(target, "target");
		ContractUtils.Requires(args == null || args.Length == 0, "args");
		return target.BindUnaryOperation(this);
	}
}
