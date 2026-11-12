#define LOG_ERROR
using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._12501;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private List<string> _curActionTagList;

	private int _stage;

	private string _actionTag;

	private ActorStatus _enterStatus;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateRootMotionState();
		_enterStatus = (_actor as PlayerAdventureActor).status;
		_curActionTagList = ((_enterStatus == ActorStatus.Special) ? Config.comboTagList_Berserk : Config.comboTagList_Normal);
		_stage = (int)(long)_actor.logicVariable.GetLogicTagValue("NormalAttackStage");
		_actionTag = ((_stage < _curActionTagList.Count) ? _curActionTagList.get_Item(_stage) : null);
	}

	public void OnStart()
	{
		if (string.IsNullOrEmpty(_actionTag))
		{
			NovaLogger.Error($"该普攻段数未配置ActionTag,狂怒状态:{_enterStatus == ActorStatus.Special},普攻段数:{_stage}");
			OnFinish();
			return;
		}
		string actionTag = _actionTag;
		LogicEntity attackTarget = _actor.attackTarget;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	protected void OnAnticipationEnd()
	{
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < _curActionTagList.Count) ? num : 0);
	}

	public void OnUpdate()
	{
		UpdateRootMotionState();
		LockDirection();
	}

	private void UpdateRootMotionState()
	{
		if (SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() != TSVector2.zero)
		{
			_actor.movementFSM.runtimeIgonreRootMotion = true;
		}
		else
		{
			_actor.movementFSM.runtimeIgonreRootMotion = false;
		}
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.movementFSM.runtimeIgonreRootMotion = false;
		_stage = 0;
		_actionTag = null;
		_enterStatus = ActorStatus.Default;
	}
}
