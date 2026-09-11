using System.Dynamic.Utils;
using System.Linq.Expressions;

namespace System.Dynamic;

public abstract class BinaryOperationBinder : DynamicMetaObjectBinder
{
	public ExpressionType Operation { get; }

	public DynamicMetaObject FallbackBinaryOperation(DynamicMetaObject target, DynamicMetaObject arg)
	{
		return FallbackBinaryOperation(target, arg, null);
	}

	public abstract DynamicMetaObject FallbackBinaryOperation(DynamicMetaObject target, DynamicMetaObject arg, DynamicMetaObject errorSuggestion);

	public sealed override DynamicMetaObject Bind(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		ContractUtils.RequiresNotNull(target, "target");
		ContractUtils.RequiresNotNull(args, "args");
		ContractUtils.Requires(args.Length == 1, "args");
		DynamicMetaObject dynamicMetaObject = args[0];
		ContractUtils.RequiresNotNull(dynamicMetaObject, "args");
		return target.BindBinaryOperation(this, dynamicMetaObject);
	}
}
