using System.ComponentModel;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Composites;

[DesignTimeVisible(false)]
[DisplayStringFormat("{modifier}+{button}")]
public class ButtonWithOneModifier : InputBindingComposite<float>
{
	[InputControl(layout = "Button")]
	public int modifier;

	[InputControl(layout = "Button")]
	public int button;

	public bool overrideModifiersNeedToBePressedFirst;

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
		if (flag && !overrideModifiersNeedToBePressedFirst)
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
		if (!overrideModifiersNeedToBePressedFirst)
		{
			overrideModifiersNeedToBePressedFirst = !InputSystem.settings.shortcutKeysConsumeInput;
		}
	}
}
