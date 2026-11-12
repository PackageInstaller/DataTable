using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._30901;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "SupportSkill";

	private static readonly FP dashSpeed = 10;

	private static readonly FP dashDistanceExtra = 1;

	private const int buffId_Lv3 = 250105703;

	private CoroutineNode corMain;

	private Dash _dash;

	private LogicEntity _target;

	private bool _dashFinished;

	private int PotentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_target = null;
		_dashFinished = false;
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_target = null;
		ILRuntimeAPI.InterruptDash(_dash);
		ILRuntimeAPI.ClearDash(_dash);
		_dash = null;
		_actor.CancelAiming();
		if (PotentialLv >= 3)
		{
			_actor.buffComponent.RemoveBuffByBuffId(250105703);
		}
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private IEnumerator DoMainLogic()
	{
		_target = _actor.attackTarget;
		if (_target != null)
		{
			_actor.AimAtTarget(_target);
		}
		if (PotentialLv >= 3)
		{
			_actor.buffComponent?.AddBuff(250105703, _actor);
		}
		SupportSkill supportSkill = this;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		RequestComboAttack req = supportSkill.BeginAttack("SupportSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		TSVector2 lastPos = _target?.tsTransform.Position ?? (_actor.tsTransform.Position + _actor.tsTransform.Forward * 10);
		while (!req.isAnticipationEnd)
		{
			if (_target != null && !_target.IsDead())
			{
				lastPos = _target.tsTransform.Position;
			}
			yield return null;
		}
		_actor.LookAt(lastPos, 0);
		FP distance = TSVector2.Distance(_actor.tsTransform.Position, lastPos) + dashDistanceExtra;
		_dashFinished = false;
		ILRuntimeAPI.BeginDashActorForward(ref _dash, _actor, dashSpeed, distance, 0, OnDashFinish, OnDashFinish, OnDashFinish, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		while (!_dashFinished)
		{
			yield return null;
		}
		_actor.CancelAttack();
	}

	private void OnDashFinish()
	{
		_dashFinished = true;
	}
}
