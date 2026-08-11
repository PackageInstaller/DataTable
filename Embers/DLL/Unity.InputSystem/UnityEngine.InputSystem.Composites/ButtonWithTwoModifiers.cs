using System.ComponentModel;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Composites;

[DesignTimeVisible(false)]
[DisplayStringFormat("{modifier1}+{modifier2}+{button}")]
public class ButtonWithTwoModifiers : InputBindingComposite<float>
{
	[InputControl(layout = "Button")]
	public int modifier1;

	[InputControl(layout = "Button")]
	public int modifier2;

	[InputControl(layout = "Button")]
	public int button;

	public bool overrideModifiersNeedToBePressedFirst;

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
		if (flag && !overrideModifiersNeedToBePressedFirst)
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
		if (!overrideModifiersNeedToBePressedFirst)
		{
			overrideModifiersNeedToBePressedFirst = !InputSystem.settings.shortcutKeysConsumeInput;
		}
	}
}
