using System.Collections;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_ShootTwice_BossRush : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] LeftHandShoot_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private readonly ComboInputBuffer.ActionKey[] RightHandShoot_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private readonly TSVector2 ShootPositionL = new TSVector2(-0.6, 2.15);

	private readonly TSVector2 ShootPositionR = new TSVector2(0.78, 2.26);

	private readonly FP ShootPositionY = 1.7;

	private readonly FP ShootAngle_D2 = 40;

	private readonly FP ShootAngle_D3 = 65;

	private readonly FP ShootIntervalTime_D2 = 0.1;

	private readonly FP ShootIntervalTime_D3 = 0.05;

	private readonly FP LockAngularVelocity_D12 = 25;

	private readonly FP LockAngularVelocity_D3 = 75;

	private readonly FP ShootDuration = 1.5;

	private readonly FP BackSpeed = 1.5;

	private ComboInputBuffer.ActionKey[] FirstCombo;

	private ComboInputBuffer.ActionKey[] SecondCombo;

	private TSVector2 FirstShootPosition;

	private TSVector2 SecondShootPosition;

	private CoroutineNode FirstShootNode;

	private CoroutineNode SecondShootNode;

	private FP Phase;

	private FP ShootAngle;

	private FP ShootIntervalTime;

	private FP LockAngularVelocity;

	private bool IsUpdate;

	protected override void OnSkillEnable()
	{
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		if (Phase == 1)
		{
			IsUpdate = false;
		}
		else
		{
			IsUpdate = true;
		}
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0)
		{
			FirstCombo = LeftHandShoot_Combo;
			SecondCombo = RightHandShoot_Combo;
			FirstShootPosition = ShootPositionL;
			SecondShootPosition = ShootPositionR;
		}
		else
		{
			FirstCombo = RightHandShoot_Combo;
			SecondCombo = LeftHandShoot_Combo;
			FirstShootPosition = ShootPositionR;
			SecondShootPosition = ShootPositionL;
		}
		if (!IsUpdate)
		{
			ShootAngle = ShootAngle_D2;
			ShootIntervalTime = ShootIntervalTime_D2;
			LockAngularVelocity = LockAngularVelocity_D12;
		}
		else
		{
			ShootAngle = ShootAngle_D3;
			ShootIntervalTime = ShootIntervalTime_D3;
			LockAngularVelocity = LockAngularVelocity_D3;
		}
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(GetAttackTarget(isUpToDate: true), 0, 400, 30);
		BeginAttack(1, FirstCombo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtMonsterTarget(999, 150);
		yield return WaitTime(0.6);
		PlayEffect("FlashWarning", 1f, 1.7, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -1)));
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StopWaitLookAt();
		BeginDash(1, GetForward() * -1, BackSpeed, BackSpeed * ShootDuration, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		BeginLookAtMonsterTarget(999, LockAngularVelocity);
		StartCor(ref FirstShootNode, Shooting(FirstShootPosition));
		yield return WaitTime(ShootDuration);
		StopCor(FirstShootNode);
		StopWaitLookAt();
		if (!IsUpdate)
		{
			BeginAttack(1, FirstCombo);
		}
		else
		{
			BeginAttack(2, SecondCombo);
			yield return WaitCustomEvent("StartTurn");
			BeginLookAtMonsterTarget(999, 150);
			yield return WaitTime(0.2);
			PlayEffect("FlashWarning", 1f, 1, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -1)));
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			StopWaitLookAt();
			BeginLookAtMonsterTarget(999, LockAngularVelocity);
			StartCor(ref SecondShootNode, Shooting(SecondShootPosition));
			BeginDash(1, GetForward() * -1, BackSpeed, BackSpeed * ShootDuration, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitTime(ShootDuration);
			StopWaitLookAt();
			StopCor(SecondShootNode);
			CancelAttack();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator Shooting(TSVector2 ShootPosition)
	{
		while (true)
		{
			FanMultipleShoot("Weapon_Shoot", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), ShootPosition), ShootPositionY, RotateTo(GetForward(), GetRandomValue(-ShootAngle / 2, ShootAngle / 2)), 0, AimType.Default, BulletDirectionType.ActorToBullet, 1, 0, 0);
			yield return WaitTime(ShootIntervalTime);
		}
	}
}
