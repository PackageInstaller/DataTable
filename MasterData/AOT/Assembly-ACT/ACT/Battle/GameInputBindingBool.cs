using System;

namespace ACT.Battle;

[AttributeUsage(AttributeTargets.Method, AllowMultiple = false)]
public class GameInputBindingBool : GameInputBindingAttributeBase
{
	public override Type ParameterType => typeof(bool);

	public GameInputBindingBool(string bindingAction)
		: base(bindingAction)
	{
	}

	public GameInputBindingBool(string bindingAction, bool receivePressState)
		: base(bindingAction, receivePressState)
	{
	}
}
