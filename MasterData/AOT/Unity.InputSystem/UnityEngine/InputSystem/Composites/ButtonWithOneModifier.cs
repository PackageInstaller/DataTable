using System;
using System.ComponentModel;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Composites;

[DisplayStringFormat("{modifier}+{button}")]
[DesignTimeVisible(false)]
public class ButtonWithOneModifier : InputBindingComposite<float>
{
	public enum ModifiersOrder
	{
		Default,
		Ordered,
		Unordered
	}

	[InputControl(layout = "Button")]
	public int modifier;

	[InputControl(layout = "Button")]
	public int button;

	[Tooltip("Obsolete please use modifiers Order. If enabled, this will override the Input Consumption setting, allowing the modifier keys to be pressed after the button and the composite will still trigger.")]
	[Obsolete("Use ModifiersOrder.Unordered with 'modifiersOrder' instead")]
	public bool overrideModifiersNeedToBePressedFirst;

	[Tooltip("By default it follows the Input Consumption setting to determine if the modifers keys need to be pressed first.")]
	public ModifiersOrder modifiersOrder;

	public override float ReadValue(ref InputBindingCompositeContext context)
	{
		if (ModifierIsPressed(ref context))
		{
			return context.ReadValue<float>(button);
		}
		return 0f;
	}

	private bool ModifierIsPressed(ref InputBindingCompositeContext context)
	{
		bool flag = context.ReadValueAsButton(modifier);
		if (flag && modifiersOrder == ModifiersOrder.Ordered)
		{
			double pressTime = context.GetPressTime(button);
			return context.GetPressTime(modifier) <= pressTime;
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
