using ACT.UI;
using UnityEngine.UI;

namespace Runtime.Utility;

public static class InputControllerUtilities
{
	public static void ControllerClick(this ActButton button)
	{
		if (button.gameObject.activeInHierarchy && button.interactable)
		{
			button.OnClick?.Invoke();
		}
	}

	public static void ControllerClick(this Button button)
	{
		if (button.gameObject.activeInHierarchy && button.interactable)
		{
			button.onClick?.Invoke();
		}
	}
}
