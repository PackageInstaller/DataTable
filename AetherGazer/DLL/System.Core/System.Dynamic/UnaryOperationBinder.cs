using System.Dynamic.Utils;

namespace System.Dynamic;

public abstract class UnaryOperationBinder : DynamicMetaObjectBinder
{
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
