using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._15001;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private static readonly string[] ComboTagList_NormalAttack = new string[5] { "Attack_1", "Attack_2", "Attack_3", "Attack_4", "Attack_5" };

	private static readonly FP Delay_ResetNormalAttackStage = 1;

	private const string LogicTag_NormalAttackStage = "NormalAttackStage";

	private const string LogicTag_LastNormalAttackFinishTime = "TD_15001_LastNormalAttackFinishTime";

	private readonly AimTarget _aimTarget = new AimTarget();

	private LogicEntity _targetEntity;

	private int _stage;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		RefreshNormalAttackStage();
		_stage = _actor.logicVariable.GetLogicTagValue("NormalAttackStage").AsInt();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_targetEntity = null;
		_aimTarget.Cancel();
	}

	public void OnStart()
	{
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		_stage = ((_stage < ComboTagList_NormalAttack.Length) ? _stage : 0);
		string actionTag = ComboTagList_NormalAttack[_stage];
		LogicEntity attackTarget = _actor.attackTarget;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			if (_targetEntity != _actor.attackTarget)
			{
				_targetEntity = _actor.attackTarget;
				_aimTarget.Cancel();
				_aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
		}
		else
		{
			_actor.CancelAttack();
		}
	}

	private void OnAnticipationEnd()
	{
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < ComboTagList_NormalAttack.Length) ? num : 0);
	}

	private void OnFinish()
	{
		_actor.logicVariable.SetLogicTagValue("TD_15001_LastNormalAttackFinishTime", _actor.LogicTime);
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void RefreshNormalAttackStage()
	{
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("TD_15001_LastNormalAttackFinishTime");
		if (logicTagValue <= 0)
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		}
		else if (_actor.LogicTime - logicTagValue > Delay_ResetNormalAttackStage)
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		}
	}
}
