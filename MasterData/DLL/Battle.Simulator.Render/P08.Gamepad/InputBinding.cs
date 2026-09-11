using System.Collections.Generic;
using System.Linq;

namespace P08.Gamepad;

public class InputBinding
{
	public InputAction action { get; }

	public string actionName => action.actionName;

	public En_ButtonType buttonType { get; set; }

	public En_ButtonType defaultButtonType { get; set; }

	internal List<IInputActionTrigger> triggers { get; }

	internal InputBinding(InputAction action, InputBindingRes res, IEnumerable<IInputActionTrigger> triggers)
	{
		this.action = action;
		buttonType = res.buttonType;
		defaultButtonType = res.buttonType;
		this.triggers = triggers.ToList();
	}
}
