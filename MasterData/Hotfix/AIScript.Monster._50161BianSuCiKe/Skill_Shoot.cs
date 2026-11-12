using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Shoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Q };

	private static readonly string customEvent_ExitBattle = "ExitBattle";

	private static readonly string customEvent_StopTurn = "StopTurn";

	private static readonly FP searchDistanc = 11;

	private static readonly List<FP> searchAngles = new List<FP> { 50, -50, 70, -70, 30, -30 };

	private static readonly FP WaitShootTime = 0.8;

	private static readonly FP ShootTime = 1.16;

	private static readonly string bulletAlias = "Bullet_MiniBoss";

	private static readonly int bulletAmountP1 = 7;

	private static readonly int bulletAmountP2 = 12;

	private static readonly int ShootAngle = 15;

	private List<FP> searchAnglesList;

	private TSVector2 ShootPosition;

	private static readonly TSVector2 ShootPositionReal = new TSVector2(0.3, 2.8);

	private FP realLoopTime;

	private int bulletAmount;

	private int bulletCount;

	private FP Difficulty;

	private bool isAction;

	private ComboInputBuffer.ActionKey[] actionKeys_2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isAction = true;
		bulletCount = 0;
		realLoopTime = ShootTime + _actor.logicVariable.GetLogicTagValue("shootLoopTimeAdditional");
		_actor.logicVariable.SetLogicTagValue("shootLoopTimeAdditional", 0);
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		if (Difficulty == 1)
		{
			bulletAmount = bulletAmountP1;
		}
		else
		{
			bulletAmount = bulletAmountP2;
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		FP logicTagFpValue = GetLogicTagFpValue(_actor, "SpawnPositionX");
		FP logicTagFpValue2 = GetLogicTagFpValue(_actor, "LeaderSpawnPositionX");
		if (GetLogicTagToggleValue(_actor, "isVolley"))
		{
			SetImmuneControlEnable();
			if (logicTagFpValue < logicTagFpValue2)
			{
				searchAnglesList = new List<FP> { -70 };
			}
			else if (logicTagFpValue == logicTagFpValue2)
			{
				searchAnglesList = new List<FP> { 0 };
			}
			else
			{
				searchAnglesList = new List<FP> { 70 };
			}
			SetLogicTagToggleValue(_actor, "isVolley", value: false);
		}
		else
		{
			searchAnglesList = searchAngles;
		}
		GetAttackTarget(isUpToDate: true);
		TSVector2 pointsByActorAndScreenTopDirWithRotationAnglesAndDistance = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, searchAnglesList, searchDistanc, searchDistanc, excludeLastPoint: true);
		Teleport(pointsByActorAndScreenTopDirWithRotationAnglesAndDistance);
		BeginLookAt_NotWait(GetAttackTarget(), 0.1, 999);
		InterruptHideModel();
		InterruptUnparalleled();
		BeginAttack(1, actionKeys_1, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 999, 999);
		yield return WaitCustomEvent(customEvent_StopTurn);
		StopLookAt();
		yield return WaitTime(WaitShootTime);
		if (Difficulty == 1)
		{
			ShootPosition = TransLocalPosToWorldPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, ShootPositionReal);
			FanMultipleShoot(bulletAlias, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, bulletAmount, ShootTime, ShootPosition, 1.7, _actor.tsTransform.Forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, ShootAngle, 0, 0);
			yield return WaitTime(realLoopTime);
		}
		else
		{
			BeginLookAt_NotWait(GetAttackTarget(isUpToDate: true), ShootTime, 50);
			while (bulletCount < bulletAmount)
			{
				ShootPosition = TransLocalPosToWorldPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, ShootPositionReal);
				FanMultipleShoot(bulletAlias, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, ShootPosition, 1.7, _actor.tsTransform.Forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, ShootAngle, 0, 0);
				yield return WaitTime(ShootTime / bulletAmount);
				bulletCount++;
			}
		}
		yield return WaitTime(0.5);
		BeginAttack(1, actionKeys_1);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, "Idle", flushInputedKeys: true);
		yield return BeginLookAtMonsterTarget(1, 100);
		CancelAttack();
		InterruptAttack();
		if (GetLogicTagFpValue(_actor, "Phase") == 1)
		{
			actionKeys_2 = actionKeys_2_1;
		}
		else
		{
			actionKeys_2 = actionKeys_2_2;
		}
		BeginAttack(2, actionKeys_2, flushInputedKeys: true);
		yield return WaitCustomEvent(customEvent_ExitBattle);
		ShowBlood(isShow: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
