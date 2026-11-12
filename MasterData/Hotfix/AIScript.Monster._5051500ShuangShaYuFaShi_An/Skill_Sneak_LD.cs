#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._5051500ShuangShaYuFaShi_An;

public class Skill_Sneak_LD : SkillSimpleBase
{
	private LogicEntity target;

	private CoroutineNode CheckMateCor;

	private readonly int SneakIndex;

	private readonly string SneakKey = "Sneak";

	private readonly int ShootIndex = 1;

	private readonly string ShootKey = "NormalATK";

	private readonly string laserFx = "fx_70022_loop_Kagebunsin_Control_line";

	private List<long> _Fx = new List<long>();

	private TSVector2 targetPOS;

	private TSVector2 ZeroPOS = new TSVector2(0, 0);

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("鲨鱼法师.暗潜水开始");
	}

	protected override void OnSkillDisable()
	{
		if (_Fx.Count > 0)
		{
			for (int i = 0; i < _Fx.Count; i++)
			{
				StopEffect(_Fx.get_Item(i));
			}
		}
		_Fx.Clear();
		StopCor(CheckMateCor);
		NovaLogger.Debug("鲨鱼法师.暗技能结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(SneakIndex, SneakKey, flushInputedKeys: true, forceInterruptAttack: true);
		targetPOS = TransLocalPosToWorldPos(ZeroPOS, GetPosition() - ZeroPOS, new TSVector2(0, 13));
		BeginLookAtByPos_NotWait(targetPOS, 0.3, 600);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CheckMateCor = StartCor(CheckMateState());
		MoveToPosition(targetPOS, 0.05, AdventureActor.MovementMode.None);
		yield return WaitMoveStatus();
		yield return StartCor(MoveTo());
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return StartCor(ShootTarget());
	}

	protected IEnumerator MoveTo()
	{
		TSVector2 tSVector = RotateTo(GetPosition() - ZeroPOS, 30);
		TSVector2 tSVector2 = tSVector;
		NovaLogger.Debug("朝向目标" + tSVector2.ToString());
		yield return BeginLookAtByPos(tSVector, default, 999);
		BeginDashActorForward(10, 8, 99, 999, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		FP dashTime = 1.5;
		FP lookAtWaitTime = 0.2;
		for (int i = 0; i < dashTime / lookAtWaitTime; i++)
		{
			tSVector = RotateTo(GetPosition() - ZeroPOS, 10);
			BeginLookAtByPos_NotWait(tSVector, default, 999);
			yield return WaitTime(lookAtWaitTime);
		}
		StopDash();
		yield return WaitDashFinish();
	}

	protected IEnumerator ShootTarget()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginAttack(ShootIndex, ShootKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 1, 360);
		yield return WaitTime(1);
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		shooting();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator CheckMateState()
	{
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		while (targetsByFaction != null && targetsByFaction.Count > 0)
		{
			yield return WaitTime(0.2);
			targetsByFaction = GetTargetsByFaction(isFriend: true);
		}
		KillActors(new List<LogicEntity> { _actor });
	}

	private void shooting()
	{
		int num = 0;
		if (GetMonsterTagValue(_actor, 1) == "SplitBullet")
		{
			num = 1;
		}
		if (num == 1)
		{
			FanMultipleShoot("Weapon_50200AnFaShi_MiniDark_SplitBullet_A", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0.75, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 75, 0, 2);
			NovaLogger.Debug("鲨鱼法师.发射子弹.分裂弹");
		}
		else
		{
			FanMultipleShoot("Weapon_50200AnFaShi_MiniDark_Bullet", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 5, 0, GetPosition(), 0.75, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 75, 0, 2);
			NovaLogger.Debug("鲨鱼法师.发射子弹.通用分裂弹");
		}
	}
}
