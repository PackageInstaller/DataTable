using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._14101;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string comboTag = "Skill_Small";

	private string comboTag_p2 = "Skill_Big";

	protected readonly FP loopTime_Skill = 3;

	private CoroutineNode corMain;

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private bool _inLoopStage;

	private FP _loopTime;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_inLoopStage = false;
		_loopTime = 0;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		aimTarget?.Cancel();
		if (GetPerk(1410101))
		{
			_actor.buffComponent?.AddBuff(801410010, _actor);
		}
		if (GetPerk(1410103))
		{
			_actor.buffComponent?.AddBuffNum(801410020, 3, _actor);
		}
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
		}
		string actionTag = (GetPerk(1410102) ? comboTag_p2 : comboTag);
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		_inLoopStage = true;
		_loopTime = loopTime_Skill;
		if (GetPerk(1410104))
		{
			_loopTime += Parallel.addLoopTime;
		}
	}

	private void OnRecoveryBegin()
	{
		aimTarget?.Cancel();
		_inLoopStage = false;
		_loopTime = 0;
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null && targetEntity != _actor.attackTarget)
		{
			targetEntity = _actor.attackTarget;
			aimTarget.Cancel();
			aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
		}
		if (_inLoopStage)
		{
			if (_loopTime > 0)
			{
				_loopTime -= _actor.LogicDeltaTime;
			}
			else
			{
				comboAttack.CancelAttack();
			}
		}
	}
}
