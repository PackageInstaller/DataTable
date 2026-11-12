#define LOG_ERROR
using System;
using TrueSync;

namespace AIScript.Character._15001;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private int _stage;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateRootMotionState();
		_stage = _actor.logicVariable.GetLogicTagValue("NormalAttackStage").AsInt();
	}

	public void OnStart()
	{
		string text = ((_stage < Config.comboTagList_NormalAttack.Count) ? Config.comboTagList_NormalAttack.get_Item(_stage) : null);
		if (string.IsNullOrEmpty(text))
		{
			NovaLogger.Error($"该普攻段数未配置ComboTag, 普攻段数:{_stage}");
			OnFinish();
			return;
		}
		LogicEntity attackTarget = _actor.attackTarget;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(text, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < Config.comboTagList_NormalAttack.Count) ? num : 0);
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

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.movementFSM.runtimeIgonreRootMotion = false;
		_stage = 0;
	}
}
