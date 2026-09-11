using System.Dynamic.Utils;

namespace System.Dynamic;

public abstract class InvokeBinder : DynamicMetaObjectBinder
{
	public DynamicMetaObject FallbackInvoke(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		return FallbackInvoke(target, args, null);
	}

	public abstract DynamicMetaObject FallbackInvoke(DynamicMetaObject target, DynamicMetaObject[] args, DynamicMetaObject errorSuggestion);

	public sealed override DynamicMetaObject Bind(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		ContractUtils.RequiresNotNull(target, "target");
		ContractUtils.RequiresNotNullItems(args, "args");
		return target.BindInvoke(this, args);
	}
}
