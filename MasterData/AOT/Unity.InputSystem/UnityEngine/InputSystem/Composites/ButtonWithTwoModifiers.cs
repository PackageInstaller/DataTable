using System;
using System.ComponentModel;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Composites;

[DisplayStringFormat("{modifier1}+{modifier2}+{button}")]
[DesignTimeVisible(false)]
public class ButtonWithTwoModifiers : InputBindingComposite<float>
{
	public enum ModifiersOrder
	{
		Default,
		Ordered,
		Unordered
	}

	[InputControl(layout = "Button")]
	public int modifier1;

	[InputControl(layout = "Button")]
	public int modifier2;

	[InputControl(layout = "Button")]
	public int button;

	[Obsolete("Use ModifiersOrder.Unordered with 'modifiersOrder' instead")]
	[Tooltip("Obsolete please use modifiers Order. If enabled, this will override the Input Consumption setting, allowing the modifier keys to be pressed after the button and the composite will still trigger.")]
	public bool overrideModifiersNeedToBePressedFirst;

	[Tooltip("By default it follows the Input Consumption setting to determine if the modifers keys need to be pressed first.")]
	public ModifiersOrder modifiersOrder;

	public override float ReadValue(ref InputBindingCompositeContext context)
	{
		if (ModifiersArePressed(ref context))
		{
			return context.ReadValue<float>(button);
		}
		return 0f;
	}

	private bool ModifiersArePressed(ref InputBindingCompositeContext context)
	{
		bool flag = context.ReadValueAsButton(modifier1) && context.ReadValueAsButton(modifier2);
		if (flag && modifiersOrder == ModifiersOrder.Ordered)
		{
			double pressTime = context.GetPressTime(button);
			double pressTime2 = context.GetPressTime(modifier1);
			double pressTime3 = context.GetPressTime(modifier2);
			if (pressTime2 <= pressTime)
			{
				return pressTime3 <= pressTime;
			}
			return false;
		}
		return flag;
	}

	public override float EvaluateMagnitude(ref InputBindingCompositeContext context)
	{
		return ReadValue(ref context);
	}

	protected override void FinishSetup(ref InputBindingCompositeContext context)
	{
		if (modifiersOrder == ModifiersOrder.Default)
		{
			if (overrideModifiersNeedToBePressedFirst)
			{
				modifiersOrder = ModifiersOrder.Unordered;
			}
			else
			{
				modifiersOrder = (InputSystem.settings.shortcutKeysConsumeInput ? ModifiersOrder.Ordered : ModifiersOrder.Unordered);
			}
		}
	}
}
