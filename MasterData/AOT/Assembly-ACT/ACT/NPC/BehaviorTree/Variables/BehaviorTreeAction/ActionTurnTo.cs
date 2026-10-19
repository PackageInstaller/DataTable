using System;
using System.Collections.Generic;
using Bamboo.ECS;
using DG.Tweening;
using DG.Tweening.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace ACT.NPC.BehaviorTree.Variables.BehaviorTreeAction;

[Serializable]
[BehaviorActionTitle("朝向目标")]
public class ActionTurnTo : BehaviorActionBase
{
	public Vector3 target;

	public float lerpTime = 0.3f;

	[SerializeField]
	public List<BehaviorActionWrap> actionsWhenCompleted = new List<BehaviorActionWrap>();

	public override void Execute(Entity owner)
	{
		if (!owner.IsValid)
		{
			return;
		}
		Transform modelTrans = owner.GetModelTrans();
		if ((object)modelTrans == null)
		{
			return;
		}
		Vector3 forward = target - modelTrans.position;
		forward.y = 0f;
		if (forward.sqrMagnitude <= Mathf.Epsilon)
		{
			return;
		}
		Quaternion quaternion = Quaternion.LookRotation(forward, Vector3.up);
		if (lerpTime <= 0f)
		{
			modelTrans.rotation = quaternion;
			return;
		}
		TweenerCore<Quaternion, Quaternion, NoOptions> tweenerCore = modelTrans.DORotateQuaternion(quaternion, lerpTime).SetEase(Ease.Linear);
		tweenerCore.onComplete = (TweenCallback)Delegate.Combine(tweenerCore.onComplete, (TweenCallback)(() =>
		{
			foreach (BehaviorActionWrap item in actionsWhenCompleted)
			{
				item.GetAction().Execute(owner);
			}
		}));
	}
}
