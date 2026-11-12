using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._14101;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private string _normalAttackStageTag;

	private int _nextNormalAttackStage;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateRootMotionState();
	}

	public void OnStart()
	{
		string comboTag = GetComboTag(out _normalAttackStageTag, out _nextNormalAttackStage);
		if (string.IsNullOrEmpty(comboTag))
		{
			_skill.Clear();
			return;
		}
		LogicEntity attackTarget = _actor.attackTarget;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
		if (_normalAttackStageTag == "NormalAttackStage")
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage_Special_P2", 0);
		}
		else
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		}
	}

	private string GetComboTag(out string normalAttackStageTag, out int nextNormalAttackStage)
	{
		List<string> list = Config.comboTagList_NormalAttack;
		normalAttackStageTag = "NormalAttackStage";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514102, out var _) && _actor.buffComponent.CheckBuffByBuffID(14102012))
		{
			list = Config_MainControl.comboTagList_NormalAttack_Special_P2;
			normalAttackStageTag = "NormalAttackStage_Special_P2";
		}
		int num = _actor.logicVariable.GetLogicTagValue(normalAttackStageTag).AsInt();
		num = TSMath.Clamp(num, 0, list.Count - 1).AsInt();
		nextNormalAttackStage = num + 1;
		nextNormalAttackStage = ((nextNormalAttackStage < list.Count) ? nextNormalAttackStage : 0);
		return list.get_Item(num);
	}

	private void OnAnticipationEnd()
	{
		if (string.IsNullOrEmpty(_normalAttackStageTag) || _nextNormalAttackStage < 0)
		{
			return;
		}
		_actor.logicVariable.SetLogicTagValue(_normalAttackStageTag, _nextNormalAttackStage);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514102, out var _) && _actor.buffComponent.CheckBuffByBuffID(14102012) && _actor.buffComponent.CheckBuffByBuffID(14102013))
		{
			_actor.buffComponent.RemoveBuffByBuffId(14102013, 10);
			if (!_actor.buffComponent.CheckBuffByBuffID(14102013))
			{
				_actor.buffComponent.RemoveBuffByBuffId(14102012);
			}
		}
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
		_normalAttackStageTag = null;
		_nextNormalAttackStage = 0;
	}
}
