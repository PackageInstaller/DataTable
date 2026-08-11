using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("Input (Legacy System)")]
public class CheckButtonInput : ConditionTask
{
	public PressTypes pressType;

	[RequiredField]
	public BBParameter<string> buttonName = "Fire1";

	protected override string info => pressType.ToString() + " " + buttonName.ToString();

	protected override bool OnCheck()
	{
		if (pressType == PressTypes.Down)
		{
			return Input.GetButtonDown(buttonName.value);
		}
		if (pressType == PressTypes.Up)
		{
			return Input.GetButtonUp(buttonName.value);
		}
		if (pressType == PressTypes.Pressed)
		{
			return Input.GetButton(buttonName.value);
		}
		return false;
	}
}
