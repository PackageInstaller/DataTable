using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._120;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private const string actionKey_max = "Ultra";

	private const string fireEvent = "Fire";

	private const string areaEffect = "AreaEffect";

	private const string areaEffect2 = "AreaEffect2";

	private const int Buff_id = 250101501;

	private readonly FP skillTime = 9;

	private readonly FP turnRotateSpeed = 100;

	private int PotentialLv = 1;

	private FP skillDuration;

	private LookAtTarget _lookAt;

	private LogicEntity _lookAtTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
		ILRuntimeAPI.StopLookAt(_lookAt);
		ILRuntimeAPI.ClearLookAt(_lookAt);
		_lookAt = null;
		_lookAtTarget = null;
		if (PotentialLv >= 3)
		{
			_actor.buffComponent?.RemoveBuffByBuffId(250101501);
		}
	}

	public void OnStart()
	{
		skillDuration = 0;
		string text = "Skill";
		if (PotentialLv >= 3)
		{
			text = "Ultra";
			_actor.buffComponent.AddBuff(250101501, _actor);
		}
		string actionTag = text;
		Action onAnticipationEnd = OnLoopBegin;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnLoopBegin()
	{
		if (PotentialLv >= 3)
		{
			BeginLookAtCurrentTarget();
		}
	}

	private void BeginLookAtCurrentTarget()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		if (!(attackTarget == null))
		{
			FP fP = skillTime - skillDuration;
			if (!(fP <= 0))
			{
				_lookAtTarget = attackTarget;
				ILRuntimeAPI.BeginLookAt(ref _lookAt, _actor, attackTarget, fP, turnRotateSpeed, null);
			}
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

	public void OnUpdate()
	{
		if (PotentialLv < 3)
		{
			return;
		}
		skillDuration += _actor.LogicDeltaTime;
		if (skillDuration >= skillTime)
		{
			_actor.CancelAttack();
			return;
		}
		_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		LogicEntity attackTarget = _actor.attackTarget;
		if (attackTarget != null && attackTarget != _lookAtTarget)
		{
			BeginLookAtCurrentTarget();
		}
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire") && _actor.attackTarget != null)
		{
			string fxAlias = ((PotentialLv >= 2) ? "AreaEffect2" : "AreaEffect");
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.attackTarget.tsTransform.Position);
		}
	}
}
