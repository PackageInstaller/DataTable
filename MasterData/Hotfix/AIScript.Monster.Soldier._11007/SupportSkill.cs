using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._11007;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support01";

	private readonly string comboTag_Potential2 = "Support02";

	private readonly FP duration_Potential2 = 3;

	private readonly FP extraDuration_Potential3 = 2;

	private readonly string eventName_Shoot = "Shoot1";

	private readonly string eventName_Shoot2 = "Shoot2";

	private readonly string bulletAlias = "Bullet_Soldier_11007_Support";

	private readonly int shootTimes = 3;

	private readonly FP shootInterval = 0.18;

	private readonly TSVector2 shootOffset = new TSVector2(0.4, 1.5);

	private readonly FP shootPositionY = 1.42;

	private readonly FP fanAngle = 0;

	private int _potentialLv;

	private bool _beginLoop;

	private FP _duration;

	private TSVector2 shootPosition;

	private CoroutineNode _shootNode;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).soldierAI?.FindNearestConfrontTarget();
		}
		string actionTag = ((_potentialLv >= 2) ? comboTag_Potential2 : comboTag);
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_Shoot) || string.Equals(eventName, eventName_Shoot2))
		{
			StartCoroutine(ref _shootNode, ShootBurst());
		}
	}

	private IEnumerator ShootBurst()
	{
		for (int i = 0; i < shootTimes; i++)
		{
			if (_actor == null)
			{
				break;
			}
			if (_actor.IsDead())
			{
				break;
			}
			shootPosition = _actor.tsTransform.Position + _actor.tsTransform.Right * shootOffset.x + _actor.tsTransform.Forward * shootOffset.y;
			ILRuntimeAPI.FanMultipleShoot(_actor, bulletAlias, AdventureWeapon.MultipleShootStyle.RandomDirection, alignShoot: false, 0, 1, 0, shootPosition, shootPositionY, _actor.tsTransform.Forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, fanAngle, 0, 0);
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(shootInterval));
		}
	}

	private void OnAnticipationEnd()
	{
		if (_potentialLv >= 2)
		{
			_duration = GetDuration();
			_beginLoop = true;
		}
	}

	private FP GetDuration()
	{
		if (_potentialLv >= 3)
		{
			return duration_Potential2 + extraDuration_Potential3;
		}
		return duration_Potential2;
	}

	public void OnUpdate()
	{
		if (_beginLoop)
		{
			if (_duration > 0)
			{
				_duration -= _actor.LogicDeltaTime;
				return;
			}
			_beginLoop = false;
			comboAttack?.CancelAttack();
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref _shootNode);
		_beginLoop = false;
		_duration = 0;
	}
}
