using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_MobileHipFire : SkillAdvancedBase
{
	private List<string> actionKey_1 = new List<string> { "M_HipFire_SDodge", "M_HipFire_LDodge", "M_HipFire_SDodge" };

	private List<string> actionKey_2 = new List<string> { "M_HipFire_01", "M_HipFire_02", "M_HipFire_03" };

	private List<FP> delayTime_2 = new List<FP> { 0.4, 0.4, 0.4 };

	private string evt_dodge_1 = "Dodge1";

	private string evt_dodge_2 = "Dodge2";

	private string evt_turn = "Turn";

	private string evt_shoot_1 = "Shooting1";

	private string evt_shoot_2 = "Shooting2";

	private string evt_shoot_3 = "Shooting3";

	private FP innterRadius = 7;

	private FP outerRadius = 9;

	private FP offsetAngle = 60;

	private FP deltaAngle = 20;

	private FP dodge_time_1 = 0.5;

	private FP dodge_time_2 = 0.8;

	private FP lookat_time = 2;

	private FP lookat_speed = 240;

	private FP shootInterval = 0.2;

	private string bullut_1 = "Bullet_Fire_Strike_COM";

	private string bullut_2 = "Bullet_Fire_Strike_COM";

	private string bullut_3 = "Bullet_Fire_Strike_COM";

	private string bullut_other = "Bullet_Fire_Strike_COM";

	private CoroutineNode corMain;

	private CoroutineNode corTurn;

	private CoroutineNode corDelayShoot;

	private LookAtTarget lookAtTarget = new LookAtTarget();

	private Dodge dodge = new Dodge();

	private bool isLeft;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isLeft = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		StopCoroutine(ref corDelayShoot);
		StopCoroutine(ref corTurn);
		lookAtTarget.Clear();
		dodge.Interrupte();
	}

	private void onFinish()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		for (int index = 0; index < 3; index++)
		{
			Skill_MobileHipFire skill_MobileHipFire = this;
			string actionTag = actionKey_1.get_Item(index);
			Action<string> action = onCustomEvent;
			Action onInterrupt = onFinish;
			RequestComboAttack req = skill_MobileHipFire.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt, action, null, fadeOutAnim: true);
			while (!req.isRecoveryBegin)
			{
				yield return null;
			}
			Skill_MobileHipFire skill_MobileHipFire2 = this;
			string actionTag2 = actionKey_2.get_Item(index);
			action = onCustomEvent;
			onInterrupt = onFinish;
			req = skill_MobileHipFire2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt, action, null, fadeOutAnim: true);
			yield return delayTime_2.get_Item(index);
			_actor.CancelAttack();
			while (!req.isComboFinish)
			{
				yield return null;
			}
		}
		_skill?.Clear();
	}

	private void onCustomEvent(string eveName)
	{
		if (string.Equals(evt_dodge_1, eveName))
		{
			DoDodge(dodge_time_1);
		}
		else if (string.Equals(evt_dodge_2, eveName))
		{
			DoDodge(dodge_time_2);
		}
		else if (string.Equals(evt_turn, eveName))
		{
			StartCoroutine(ref corTurn, DoLookAt());
		}
		else if (string.Equals(evt_shoot_1, eveName))
		{
			ILRuntimeAPI.FanMultipleShoot(_actor, bullut_1, isLeft ? AdventureWeapon.MultipleShootStyle.FromCenterToSide : AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 15, 0.8, _actor.tsTransform.Position, 1.7, _actor.tsTransform.Forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 2, 0, 0.5, default, null, null, useRef: true);
			corDelayShoot = StartCoroutine(DelayShoot());
		}
		else if (string.Equals(evt_shoot_2, eveName))
		{
			ILRuntimeAPI.FanMultipleShoot(_actor, bullut_2, isLeft ? AdventureWeapon.MultipleShootStyle.FromLeftToRight : AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 10, 0.8, _actor.tsTransform.Position, 1.7, _actor.tsTransform.Forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 90, 0, 0.5, default, null, null, useRef: true);
		}
		else if (string.Equals(evt_shoot_3, eveName))
		{
			ILRuntimeAPI.FanMultipleShoot(_actor, bullut_3, isLeft ? AdventureWeapon.MultipleShootStyle.FromRightToLeft : AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 10, 0.8, _actor.tsTransform.Position, 1.7, _actor.tsTransform.Forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 90, 0, 0.5, default, null, null, useRef: true);
		}
	}

	private void DoDodge(FP dodgeTime)
	{
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		FP angle = (_actor.tsTransform.Position - activedPlayerActor.tsTransform.Position).normalized.GetAngle();
		TSVector2 position = _actor.tsTransform.Position;
		if (TSRandom.Range(0, 100) < 50)
		{
			isLeft = true;
			FP rotation = angle + offsetAngle;
			position = CommonUtils.RandomReachablePointInsideRingS(_actor, activedPlayerActor.tsTransform.Position, innterRadius, outerRadius, rotation, deltaAngle);
		}
		else
		{
			isLeft = false;
			FP rotation2 = angle - offsetAngle + deltaAngle / 2f;
			position = CommonUtils.RandomReachablePointInsideRingS(_actor, activedPlayerActor.tsTransform.Position, innterRadius, outerRadius, rotation2, deltaAngle);
		}
		TSVector2 normalized = (position - _actor.tsTransform.Position).normalized;
		FP magnitude = (position - _actor.tsTransform.Position).magnitude;
		dodge.Begin(_actor, normalized, dodgeTime, magnitude, null, comboWithAttack: true);
	}

	private IEnumerator DelayShoot()
	{
		yield return shootInterval;
		ILRuntimeAPI.FanMultipleShoot(_actor, bullut_other, isLeft ? AdventureWeapon.MultipleShootStyle.FromSideToCenter : AdventureWeapon.MultipleShootStyle.FromSideToCenter, alignShoot: false, 0, 6, 0.6, _actor.tsTransform.Position, 1.7, _actor.tsTransform.Forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 80, 0, 0, default, null, null, useRef: true);
	}

	private IEnumerator DoLookAt()
	{
		PlayerAdventureActor target = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		FP curTime = lookat_time;
		while (curTime > 0)
		{
			lookAtTarget.BeginLookAtByPos(_actor, target.tsTransform.Position, lookat_time, lookat_speed, null);
			curTime -= _actor.LogicDeltaTime;
			yield return null;
		}
		lookAtTarget.StopLookAt();
	}
}
