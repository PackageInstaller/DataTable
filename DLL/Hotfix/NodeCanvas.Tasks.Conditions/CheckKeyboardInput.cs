using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("Input (Legacy System)")]
public class CheckKeyboardInput : ConditionTask
{
	public PressTypes pressType;

	public KeyCode key = KeyCode.Space;

	protected override string info => pressType.ToString() + " " + key;

	protected override bool OnCheck()
	{
		if (pressType == PressTypes.Down)
		{
			return Input.GetKeyDown(key);
		}
		if (pressType == PressTypes.Up)
		{
			return Input.GetKeyUp(key);
		}
		if (pressType == PressTypes.Pressed)
		{
			return Input.GetKey(key);
		}
		return false;
	}
}
