using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationBedHandleSet : T0InterationBaseData
{
	public Vector3 dragStartOffset = Vector3.zero;

	public bool limitDragRange;

	public Vector2 dragLimitRange = new Vector2(0.5f, 0.5f);

	public bool limitY;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0BedInvokeHandleItem componentInChildren = behaviour.transform.GetComponentInChildren<T0BedInvokeHandleItem>();
		if (componentInChildren != null)
		{
			componentInChildren.dragStartOffset = dragStartOffset;
			componentInChildren.limitDragRange = limitDragRange;
			componentInChildren.dragLimitRange = dragLimitRange;
			componentInChildren.limitY = limitY;
		}
		base.IsFinish = true;
	}
}
