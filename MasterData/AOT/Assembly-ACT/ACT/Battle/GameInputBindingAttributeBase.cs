using System;

namespace ACT.Battle;

public abstract class GameInputBindingAttributeBase : Attribute
{
	public readonly string BindingAction;

	public readonly bool NeedCheckMouseAction;

	public abstract Type ParameterType { get; }

	public GameInputBindingAttributeBase(string bindingAction)
	{
		BindingAction = bindingAction;
		NeedCheckMouseAction = false;
	}

	public GameInputBindingAttributeBase(string bindingAction, bool needCheckMouseAction)
	{
		BindingAction = bindingAction;
		NeedCheckMouseAction = needCheckMouseAction;
	}
}
