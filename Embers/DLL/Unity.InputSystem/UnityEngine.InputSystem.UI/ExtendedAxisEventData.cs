using UnityEngine.EventSystems;

namespace UnityEngine.InputSystem.UI;

internal class ExtendedAxisEventData : AxisEventData
{
	public ExtendedAxisEventData(EventSystem eventSystem)
		: base(eventSystem)
	{
	}

	public override string ToString()
	{
		return $"MoveDir: {base.moveDir}\nMoveVector: {base.moveVector}";
	}
}
