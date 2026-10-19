using Com.ForbiddenByte.OSA.Core;
using UnityEngine.UI;

namespace Com.ForbiddenByte.OSA.AdditionalComponents;

internal class NavEvents
{
	public NavEvent Prev { get; private set; }

	public NavEvent New { get; private set; }

	public NavEvents()
	{
		Prev = new NavEvent();
		New = new NavEvent();
	}

	public void OnNewEvent_OSANav(Selectable newSelectable, AbstractViewsHolder nextSelectableVH, NavMoveType type)
	{
		UpdateInternal(newSelectable, nextSelectableVH, isUnityBuiltinEvent: false, type);
	}

	public void OnNewEvent_UnityBuiltinNav(Selectable newSelectable, AbstractViewsHolder nextSelectableVH, NavMoveType type)
	{
		UpdateInternal(newSelectable, nextSelectableVH, isUnityBuiltinEvent: true, type);
	}

	private void UpdateInternal(Selectable newSelectable, AbstractViewsHolder curSelectableVH, bool isUnityBuiltinEvent, NavMoveType type)
	{
		NavEvent prev = Prev;
		Prev = New;
		New = prev;
		New.Update(newSelectable, curSelectableVH, isUnityBuiltinEvent, type);
	}
}
