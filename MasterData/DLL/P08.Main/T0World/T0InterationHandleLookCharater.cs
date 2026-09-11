using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationHandleLookCharater : T0InterationHandleData
{
	public float checkDistance = 3f;

	public float checkTimeValue;

	private float checkTimeCount;

	public float checkAngleValue;

	private Vector3 beginBonePos;

	private Transform boneRootNode;

	private T0CharacterBlackborad blackBorad;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		blackBorad = null;
		boneRootNode = null;
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
		bool flag = false;
		bool flag2 = false;
		if (CheckIsMeetDistance(behaviour))
		{
			flag = CheckIsMeetAngle(behaviour);
		}
		if (flag)
		{
			flag2 = CheckIsMeetBone(behaviour);
		}
		if (flag2)
		{
			checkTimeCount += Time.deltaTime;
			if (checkTimeCount >= checkTimeValue)
			{
				base.IsFinish = true;
				checkTimeCount = 0f;
			}
		}
		else
		{
			checkTimeCount = 0f;
			boneRootNode = null;
		}
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void DisposeEvent()
	{
	}

	public bool CheckIsMeetDistance(T0WorldInteractionBehavior behaviour)
	{
		bool result = false;
		if (Vector3.Distance(T0WorldScene.Scene.player.transform.position, behaviour.transform.position) < checkDistance)
		{
			result = true;
		}
		return result;
	}

	public bool CheckIsMeetAngle(T0WorldInteractionBehavior behaviour)
	{
		bool result = false;
		Transform transform = T0WorldScene.Scene.player.transform;
		Vector3 normalized = (behaviour.transform.position - transform.position).normalized;
		Vector3 forward = behaviour.transform.forward;
		float num = Vector3.Angle(transform.transform.forward, normalized);
		float num2 = Vector3.Dot(normalized, forward);
		if (num < checkAngleValue && num2 < 0f)
		{
			result = true;
		}
		return result;
	}

	public bool CheckIsMeetBone(T0WorldInteractionBehavior behaviour)
	{
		bool result = true;
		if (boneRootNode == null)
		{
			blackBorad = behaviour.mAgent.Blackboard as T0CharacterBlackborad;
			boneRootNode = blackBorad.ikBehavior.bipedIk.solvers.lookAt.head.transform;
			beginBonePos = boneRootNode.position;
		}
		if (Vector3.Distance(boneRootNode.position, beginBonePos) > 0.01f)
		{
			result = false;
		}
		return result;
	}
}
