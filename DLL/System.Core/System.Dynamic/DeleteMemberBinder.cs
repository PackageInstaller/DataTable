using System.Dynamic.Utils;

namespace System.Dynamic;

public abstract class DeleteMemberBinder : DynamicMetaObjectBinder
{
	public string Name { get; }

	public bool IgnoreCase { get; }

	public DynamicMetaObject FallbackDeleteMember(DynamicMetaObject target)
	{
		return FallbackDeleteMember(target, null);
	}

	public abstract DynamicMetaObject FallbackDeleteMember(DynamicMetaObject target, DynamicMetaObject errorSuggestion);

	public sealed override DynamicMetaObject Bind(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		ContractUtils.RequiresNotNull(target, "target");
		ContractUtils.Requires(args == null || args.Length == 0, "args");
		return target.BindDeleteMember(this);
	}
}
