using UI.ViewComponent.BattlemainView.ActComponent;

namespace ACT.UI;

public abstract class StateButton : ActComponent
{
	public enum StateButtonState
	{
		Normal,
		Pressed,
		Disable
	}

	public StateButtonState state;

	public abstract void ChangeButtonState(StateButtonState targetState);
}
