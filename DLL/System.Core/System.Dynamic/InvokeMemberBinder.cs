using System.Dynamic.Utils;

namespace System.Dynamic;

public abstract class InvokeMemberBinder : DynamicMetaObjectBinder
{
	public sealed override Type ReturnType => typeof(object);

	public string Name { get; }

	public bool IgnoreCase { get; }

	public sealed override DynamicMetaObject Bind(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		ContractUtils.RequiresNotNull(target, "target");
		ContractUtils.RequiresNotNullItems(args, "args");
		return target.BindInvokeMember(this, args);
	}

	public DynamicMetaObject FallbackInvokeMember(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		return FallbackInvokeMember(target, args, null);
	}

	public abstract DynamicMetaObject FallbackInvokeMember(DynamicMetaObject target, DynamicMetaObject[] args, DynamicMetaObject errorSuggestion);

	public abstract DynamicMetaObject FallbackInvoke(DynamicMetaObject target, DynamicMetaObject[] args, DynamicMetaObject errorSuggestion);
}
