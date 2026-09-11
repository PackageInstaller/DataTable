using System;
using UnityEngine;
using UnityEngine.Playables;

namespace T0World;

[Serializable]
public class T0InterationAnimationData : T0InterationBaseData
{
	public bool customAnimAssetPath;

	public string animName;

	public T0WorldAnimationType animatorType = T0WorldAnimationType.Animator;

	public bool isLoop;

	public bool isHold;

	[HideInInspector]
	public DirectorWrapMode extrapolationMode = DirectorWrapMode.None;

	public T0WorldTeleportType teleport_type;

	public Vector3 teleportPos;

	public Vector3 teleportAngle;

	public string voiceName;

	public int voiceRoleID = -1;

	public int talkLabelDelay;

	public bool needRecord;

	public override bool isNeedSDK => true;

	public override void SendSDK(T0WorldInteractionBehavior behaviour)
	{
		T0SDKData baseSDKData = GetBaseSDKData();
		baseSDKData.select_param = animName;
		T0SDKSystem.SendSDKData(behaviour, baseSDKData);
	}

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Animation;
	}

	private void StopAllManualAnimator(Animator animator)
	{
		if (animator.gameObject.TryGetComponent<ManualAnimator>(out var component))
		{
			UnityEngine.Object.Destroy(component);
		}
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (T0WorldTools.IsNeedStopManualAnimator())
		{
			StopAllManualAnimator(behaviour.animator);
		}
		if (isLoop)
		{
			extrapolationMode = DirectorWrapMode.Loop;
		}
		else
		{
			extrapolationMode = ((!isHold) ? DirectorWrapMode.None : DirectorWrapMode.Hold);
		}
		if (animatorType == T0WorldAnimationType.Animator)
		{
			behaviour.PlayAnimation(animName);
		}
		else
		{
			behaviour.PlayTimeline(this);
		}
		if (voiceName == null || !(voiceName != ""))
		{
			return;
		}
		int num = -1;
		if (voiceRoleID > 0)
		{
			num = voiceRoleID;
		}
		else if (behaviour.mAgent is T0CharacterAgent t0CharacterAgent && t0CharacterAgent.CharacterBoard != null)
		{
			num = t0CharacterAgent.CharacterBoard.characterID;
		}
		Action callback = delegate
		{
			if (conditionType == T0InterationConditionTypeEnum.None)
			{
				base.IsFinish = true;
			}
			callback = null;
		};
		LuaHelper.CallFunction("T0WorldStartTalk", behaviour.animator.transform, num, voiceName, talkLabelDelay, callback);
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
		if (conditionType == T0InterationConditionTypeEnum.None)
		{
			if (voiceName == null || !(voiceName != ""))
			{
				base.IsFinish = true;
			}
		}
		else if (conditionType == T0InterationConditionTypeEnum.Next && animatorType == T0WorldAnimationType.Animator)
		{
			AnimatorStateInfo currentAnimatorStateInfo = behaviour.animator.GetCurrentAnimatorStateInfo(0);
			if (currentAnimatorStateInfo.IsName(animName) && currentAnimatorStateInfo.normalizedTime >= 1f)
			{
				base.IsFinish = true;
			}
		}
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
		if (needRecord)
		{
			T0WorldScene.Scene.dataContext.RecordCount(animName);
		}
		if (child == null || (child.Count == 0 && animatorType == T0WorldAnimationType.Timeline))
		{
			if (T0WorldScene.Scene.characterID == 108502)
			{
				behaviour.PlayTimeline("108502ui_normal_stay_101", out var _, out var _, DirectorWrapMode.Loop);
			}
			else
			{
				behaviour.CloseExcutePlayable();
			}
		}
	}

	public override void DisposeEvent()
	{
	}
}
