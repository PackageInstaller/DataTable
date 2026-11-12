using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_EnhancedADS : SkillAdvancedBase
{
	private string bullut = "Bulley_LockOn_Laser_Burst";

	private int level = 1;

	private string actionKey = "E_ADS";

	private FP loopTime_1 = 1.5;

	private FP loopTime_2 = 1.8;

	private string evt_Shoot = "AreaLaserBullut";

	private string evt_Scout = "Scout";

	private bool isRandomDir = true;

	private FP offsetAngle = 15;

	private FP speed_turn = 50;

	private FP extraAngle = 0;

	private CoroutineNode corMain;

	private LookAtTarget _lookAtTarget = new LookAtTarget();

	private AimTarget _aimTarget = new AimTarget();

	private TSVector2 startDir;

	private TSVector2 endDir;

	private AdventureAreaLaser adventureLaser;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		_aimTarget.Clear();
		_lookAtTarget.Clear();
		adventureLaser?.Finish();
	}

	private void onFinish()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		Skill_EnhancedADS skill_EnhancedADS = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		Action onInterrupt = onFinish;
		Action onComboFinish = onFinish;
		RequestComboAttack req = skill_EnhancedADS.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		while (!req.isAnticipationEnd)
		{
			yield return null;
		}
		yield return loopTime_1;
		TSVector2 normalized = (SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.tsTransform.Position - _actor.tsTransform.Position).normalized;
		FP fP = TSVector2.Angle(startDir, normalized);
		if (fP < 90)
		{
			endDir = -TSVector2.Reflect(startDir, normalized);
		}
		else
		{
			if (TSMath.Abs(fP) + extraAngle > 180)
			{
				extraAngle = 180 - TSMath.Abs(fP);
			}
			endDir = TSVector2.Rotate(normalized, extraAngle * FP.Sign(fP));
		}
		_lookAtTarget.BeginLookAtByPos(_actor, _actor.tsTransform.Position + endDir, loopTime_2, speed_turn, null);
		yield return loopTime_2;
		adventureLaser?.Finish();
		_actor.CancelAttack();
	}

	private void onCustomEvent(string eveName)
	{
		if (string.Equals(eveName, evt_Scout))
		{
			TSVector2 normalized = (SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.tsTransform.Position - _actor.tsTransform.Position).normalized;
			if (isRandomDir)
			{
				if (TSRandom.Range(0, 100) < 50)
				{
					startDir = TSVector2.Rotate(normalized, TSMath.Abs(offsetAngle));
				}
				else
				{
					startDir = TSVector2.Rotate(normalized, 0 - TSMath.Abs(offsetAngle));
				}
			}
			else
			{
				startDir = TSVector2.Rotate(normalized, offsetAngle);
			}
			_actor.LookAtDir(startDir, 0);
		}
		else if (string.Equals(eveName, evt_Shoot))
		{
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bullut, _actor, 100, default, default, default, null, AimType.Default, BulletDirectionType.BulletToTarget);
			if ((bool)adventureBulletBase)
			{
				adventureLaser = adventureBulletBase as AdventureAreaLaser;
				adventureLaser.SetLaserLevel(level);
			}
		}
	}
}
