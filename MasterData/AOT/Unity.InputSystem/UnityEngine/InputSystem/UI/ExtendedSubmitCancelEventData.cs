using UnityEngine.EventSystems;

namespace UnityEngine.InputSystem.UI;

internal class ExtendedSubmitCancelEventData : BaseEventData, INavigationEventData
{
	public InputDevice device { get; set; }

	public ExtendedSubmitCancelEventData(EventSystem eventSystem)
		: base(eventSystem)
	{
	}
}
