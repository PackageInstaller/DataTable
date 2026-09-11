using System.Dynamic.Utils;

namespace System.Dynamic;

public abstract class CreateInstanceBinder : DynamicMetaObjectBinder
{
	public DynamicMetaObject FallbackCreateInstance(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		return FallbackCreateInstance(target, args, null);
	}

	public abstract DynamicMetaObject FallbackCreateInstance(DynamicMetaObject target, DynamicMetaObject[] args, DynamicMetaObject errorSuggestion);

	public sealed override DynamicMetaObject Bind(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		ContractUtils.RequiresNotNull(target, "target");
		ContractUtils.RequiresNotNullItems(args, "args");
		return target.BindCreateInstance(this, args);
	}
}
