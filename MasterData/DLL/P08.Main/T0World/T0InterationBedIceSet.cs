using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationBedIceSet : T0InterationBaseData
{
	public Vector3 minMovePos;

	public Vector3 maxMovePos;

	public float posMoveSpeed = 0.0005f;

	public BedPosEnum applyBodyType;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0BedIceControl[] componentsInChildren = behaviour.transform.GetComponentsInChildren<T0BedIceControl>();
		foreach (T0BedIceControl t0BedIceControl in componentsInChildren)
		{
			if (t0BedIceControl.applyBodyType == applyBodyType)
			{
				t0BedIceControl.minMovePos = minMovePos;
				t0BedIceControl.maxMovePos = maxMovePos;
				t0BedIceControl.posMoveSpeed = posMoveSpeed;
			}
		}
		base.IsFinish = true;
	}
}
