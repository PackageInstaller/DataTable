using System;
using UnityEngine;

namespace ACT.Battle;

[AttributeUsage(AttributeTargets.Method, AllowMultiple = false)]
public class GameInputBindingVector2 : GameInputBindingAttributeBase
{
	public override Type ParameterType => typeof(Vector2);

	public GameInputBindingVector2(string bindingAction)
		: base(bindingAction)
	{
	}

	public GameInputBindingVector2(string bindingAction, bool receivePressState)
		: base(bindingAction, receivePressState)
	{
	}
}
