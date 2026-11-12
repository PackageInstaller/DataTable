using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._111;

public class MainSkill : SkillAdvancedBase
{
	private string actionKey = "Skill";

	private string customEvent = "Fire";

	private string buttlePath = "Bullet";

	private FP skillTime = 4.5;

	private FP shootInterval = 0.3;

	private int shootCount = 10;

	private int buffId = 250100201;

	protected FP bulletYPos = 2;

	private int PotentialLv = 1;

	private CoroutineNode corMain;

	private CoroutineNode corShoot;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corShoot);
		StopCoroutine(ref corMain);
		if (PotentialLv >= 2)
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId);
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
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private IEnumerator DoMainLogic()
	{
		string actionTag = actionKey;
		MainSkill mainSkill = this;
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		mainSkill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		yield return _actor.WaitTime(skillTime);
		_actor.CancelAttack();
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(customEvent))
		{
			StartCoroutine(ref corShoot, shootButtle());
		}
	}

	private IEnumerator shootButtle()
	{
		int _shoot = 0;
		while (_shoot < shootCount)
		{
			if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
			{
				ILRuntimeAPI.Shoot(buttlePath, _actor, _actor.tsTransform.Position, _actor.tsTransform.Forward, target: _actor.attackTarget, positionY: bulletYPos);
			}
			else
			{
				ILRuntimeAPI.ShootByDirection(buttlePath, _actor, default, _actor.tsTransform.Forward, _actor.tsTransform.Position, bulletYPos);
			}
			if (PotentialLv >= 2)
			{
				_actor.buffComponent.AddBuff(buffId, _actor);
			}
			_shoot++;
			yield return _actor.WaitTime(shootInterval);
		}
	}
}
