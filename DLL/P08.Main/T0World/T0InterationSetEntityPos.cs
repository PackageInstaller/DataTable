using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationSetEntityPos : T0InterationFunctionDataBase
{
	public bool SetPos;

	public Vector3 targetPosition;

	public bool isLocalPos;

	public bool SetRot;

	public Vector3 targetRotation;

	public bool isLocalRot;

	public bool is2DRot;

	public int judgeEntityID;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		Transform trsByEntityID = T0WorldHelper.GetTrsByEntityID(judgeEntityID);
		if (judgeEntityID == -1)
		{
			T0WorldScene.Scene.player.SetPosAndRot(targetPosition, targetRotation);
		}
		else
		{
			if (SetPos)
			{
				if (isLocalPos)
				{
					trsByEntityID.localPosition = targetPosition;
				}
				else
				{
					trsByEntityID.position = targetPosition;
				}
			}
			if (SetRot)
			{
				Quaternion quaternion = Quaternion.Euler(targetRotation);
				if (isLocalRot)
				{
					trsByEntityID.localRotation = quaternion;
				}
				else
				{
					trsByEntityID.rotation = quaternion;
				}
				if (is2DRot)
				{
					Vector3 eulerAngles = trsByEntityID.rotation.eulerAngles;
					eulerAngles.x = (quaternion.z = 0f);
					trsByEntityID.rotation = Quaternion.Euler(eulerAngles);
				}
			}
		}
		base.IsFinish = true;
	}
}
