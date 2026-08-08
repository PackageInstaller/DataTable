using System.Collections.Generic;
using UnityEngine;

namespace P08.Gamepad;

public class InputActionRes : ScriptableObject
{
	public string actionName;

	public EInputConsumeType consumeType = EInputConsumeType.Block;

	public bool ShowInBottomBar;

	public InputBindingRes binding;

	public List<InputBindingRes> bindings => new List<InputBindingRes> { binding };
}
