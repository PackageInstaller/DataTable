using System.Dynamic.Utils;

namespace System.Dynamic;

public abstract class SetMemberBinder : DynamicMetaObjectBinder
{
	public sealed override Type ReturnType => typeof(object);

	public string Name { get; }

	public bool IgnoreCase { get; }

	internal sealed override bool IsStandardBinder => true;

	protected SetMemberBinder(string name, bool ignoreCase)
	{
		ContractUtils.RequiresNotNull(name, "name");
		Name = name;
		IgnoreCase = ignoreCase;
	}

	public sealed override DynamicMetaObject Bind(DynamicMetaObject target, DynamicMetaObject[] args)
	{
		ContractUtils.RequiresNotNull(target, "target");
		ContractUtils.RequiresNotNull(args, "args");
		ContractUtils.Requires(args.Length == 1, "args");
		DynamicMetaObject value = args[0];
		ContractUtils.RequiresNotNull(value, "args");
		return target.BindSetMember(this, value);
	}

	public DynamicMetaObject FallbackSetMember(DynamicMetaObject target, DynamicMetaObject value)
	{
		return FallbackSetMember(target, value, null);
	}

	public abstract DynamicMetaObject FallbackSetMember(DynamicMetaObject target, DynamicMetaObject value, DynamicMetaObject errorSuggestion);
}
