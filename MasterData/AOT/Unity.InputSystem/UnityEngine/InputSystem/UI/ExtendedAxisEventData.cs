using UnityEngine.EventSystems;

namespace UnityEngine.InputSystem.UI;

internal class ExtendedAxisEventData : AxisEventData, INavigationEventData
{
	public InputDevice device { get; set; }

	public ExtendedAxisEventData(EventSystem eventSystem)
		: base(eventSystem)
	{
	}

	public override string ToString()
	{
		return $"MoveDir: {moveDir}\nMoveVector: {moveVector}";
	}
}
