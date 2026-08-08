using System.Dynamic.Utils;

namespace System.Dynamic;

public abstract class ConvertBinder : DynamicMetaObjectBinder
{
	public Type Type { get; }

	public DynamicMetaObject FallbackConvert(DynamicMetaObject target)
	{
		return FallbackConvert(target, null);
	}

	public abstract DynamicMetaObject FallbackConvert(DynamicMetaObject target, DynamicMetaObject errorSuggestion);

	public sealed override DynamicMetaObject Bind(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		ContractUtils.RequiresNotNull(target, "target");
		ContractUtils.Requires(args == null || args.Length == 0, "args");
		return target.BindConvert(this);
	}
}
