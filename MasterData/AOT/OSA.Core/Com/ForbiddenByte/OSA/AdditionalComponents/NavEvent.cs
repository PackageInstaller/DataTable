using Com.ForbiddenByte.OSA.Core;
using UnityEngine;
using UnityEngine.UI;

namespace Com.ForbiddenByte.OSA.AdditionalComponents;

internal class NavEvent
{
	public Selectable Selectable { get; private set; }

	public int SelectableVHItemIndex { get; private set; }

	public bool IsUnityBuiltinEvent { get; private set; }

	public bool SelectableIsVH => SelectableVHItemIndex != -1;

	public float UnscaledTime { get; private set; }

	public int Frame { get; private set; }

	public float ElapsedUnscaledTime => Time.unscaledTime - UnscaledTime;

	public NavMoveType Type { get; private set; }

	public NavEvent()
	{
		SelectableVHItemIndex = -1;
	}

	public void Update(Selectable newSelectable, AbstractViewsHolder curSelectableVH, bool isUnityBuiltinEvent, NavMoveType type)
	{
		Selectable = newSelectable;
		SelectableVHItemIndex = curSelectableVH?.ItemIndex ?? (-1);
		IsUnityBuiltinEvent = isUnityBuiltinEvent;
		Frame = Time.frameCount;
		UnscaledTime = Time.unscaledTime;
		Type = type;
	}

	public override string ToString()
	{
		return "Selectable " + Selectable?.ToString() + ", SelectableVHItemIndex " + SelectableVHItemIndex + ", IsUnityBuiltinEvent " + IsUnityBuiltinEvent + ", UnscaledTime " + UnscaledTime + ", Frame " + Frame + ", ElapsedUnscaledTime " + ElapsedUnscaledTime + ", Type " + Type;
	}
}
