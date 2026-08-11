using System.Dynamic.Utils;
using System.Runtime.CompilerServices;

namespace System.Dynamic;

public abstract class InvokeBinder : DynamicMetaObjectBinder
{
	[CompilerGenerated]
	private readonly CallInfo _003CCallInfo_003Ek__BackingField;

	public sealed override Type ReturnType => typeof(object);

	internal sealed override bool IsStandardBinder => true;

	protected InvokeBinder(CallInfo callInfo)
	{
		ContractUtils.RequiresNotNull(callInfo, "callInfo");
		_003CCallInfo_003Ek__BackingField = callInfo;
	}

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
