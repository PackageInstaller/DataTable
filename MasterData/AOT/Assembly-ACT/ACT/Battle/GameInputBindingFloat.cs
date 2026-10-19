using System;

namespace ACT.Battle;

[AttributeUsage(AttributeTargets.Method, AllowMultiple = false)]
public class GameInputBindingFloat : GameInputBindingAttributeBase
{
	public override Type ParameterType => typeof(float);

	public GameInputBindingFloat(string bindingAction)
		: base(bindingAction)
	{
	}

	public GameInputBindingFloat(string bindingAction, bool receivePressState)
		: base(bindingAction, receivePressState)
	{
	}
}
