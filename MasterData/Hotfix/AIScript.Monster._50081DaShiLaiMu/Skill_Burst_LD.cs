#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_Burst_LD : SkillSimpleBase
{
	private readonly int mSlime = 5;

	private readonly string mSlimeCountTag = "mSlimeCount";

	private readonly int sSlime = 10;

	private readonly string sSlimeCountTag = "sSlimeCount";

	private const string aiTypeEasy = "Easy";

	private const string aiTypeNormal = "Normal";

	private const string aiTypeHard = "Hard";

	private readonly TSVector2 Origin = new TSVector2(0, 0);

	private readonly TSVector2 OriginLookAt = new TSVector2(0, -1);

	private readonly string SlidingAction = "Slide";

	private readonly int AttackIndex = 2;

	private readonly int AttackPlayTime = 1;

	private FP LoopTime;

	private readonly FP LoopFinishTime = 3.2;

	private readonly string DisappearedAction = "Disappeared_BurstStage";

	private readonly int DisappearedIndex = 3;

	private readonly FP SplitWaitTime = 16;

	private readonly string WeaknessAction = "Weakness";

	private readonly int WeaknessIndex = 6;

	private readonly string FxAlias = "fx_m50081_base_skill6_appear";

	private readonly string BulletAlias = "Slime_BurstThrow_Bullet";

	private readonly bool AlignShoot;

	private readonly FP AlignShootDelay = 0;

	private readonly int BulletCount = 1;

	private readonly FP Duration = 0;

	private TSVector2 ShootPosition;

	private readonly FP ShootPositionY = 1;

	private TSVector2 MultiShootDirection;

	private readonly FP BulletDirectionOffset = 0;

	private readonly FP Angle = 0;

	private readonly FP Radius = 0;

	private readonly FP InnerRadius = 2;

	private readonly string SummonBullet = "Slime_L_Born_BOSS";

	private readonly int SummonCount = 5;

	private readonly FP SummonRadius = 11;

	private readonly FP SummonInnerRadius = 0;

	private List<LogicEntity> SummonList = new List<LogicEntity>();

	private readonly string BurstAction = "Burst";

	private readonly int BurstIndex = 4;

	private int BurstTime;

	private readonly FP BurstFinishTime = 5;

	private readonly string BurstBulletAlias = "Burst_DiffusionBubble";

	private readonly bool BurstAlignShoot = true;

	private readonly FP BurstAlignShootDelay = 0;

	private readonly int BurstBulletCount = 36;

	private readonly FP BurstDuration = 0;

	private TSVector2 BurstShootPosition;

	private readonly FP BurstShootPositionY = 0;

	private TSVector2 BurstMultiShootDirection;

	private readonly FP BurstBulletDirectionOffset = 0;

	private readonly FP BurstRadius = 0;

	private readonly FP BurstInnerRadius = 0;

	private int AttackTime;

	private int AttackTime_Weakness;

	private FP Time;

	private int MateNUB;

	protected override void OnSkillEnable()
	{
		SetCloseBlockEnable();
		SetImmuneControlEnable();
		SetLockToughnessEnable();
		SetLogicTagToggleValue(_actor, "isMaster", value: true);
		SetLogicTagToggleValue(_actor, "slideFinish", value: false);
		SetLogicTagToggleValue(_actor, "IsBurst", value: false);
		SetLogicTagFpValue(_actor, mSlimeCountTag, 0);
		SetLogicTagFpValue(_actor, sSlimeCountTag, 0);
		SetBlockPriorityToStatic();
		SummonList.Clear();
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "slideFinish", value: false);
		AttackTime = 0;
		AttackTime_Weakness = 0;
		Time = 0;
		MateNUB = 0;
		LoopTime = 0;
		BurstTime = 0;
		RemoveBuffFromTarget(_actor, 50071051);
		InterruptLockToughness();
		ResetBlockPriority();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtByPos(Origin, 1, 420);
		yield return WaitTime(1);
		MoveToPosition(TSVector2.zero, 0.1, AdventureActor.MovementMode.Run, 5, _stopDisIgnoreRadius: false);
		yield return WaitMoveStatus();
		BeginLookAtByPos(OriginLookAt, 0.6, 420);
		yield return WaitTime(0.6);
		yield return StartCor(Shooting());
		SetLogicTagToggleValue(_actor, "slideFinish", value: true);
		yield return StartCor(Split());
		yield return StartCor(Result());
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == AttackIndex)
		{
			AttackTime++;
			if (AttackTime >= AttackPlayTime)
			{
				CancelAttack();
			}
		}
		else if (comboIndex == WeaknessIndex)
		{
			AttackTime_Weakness++;
			if (AttackTime_Weakness >= 2)
			{
				CancelAttack();
			}
		}
	}

	private IEnumerator Shooting()
	{
		BeginAttack(AttackIndex, SlidingAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 2f, GetPosition(), default, 3f);
		LoopTime = 0;
		MultiShootDirection = Origin - GetPosition();
		while (LoopTime < LoopFinishTime * AttackPlayTime)
		{
			ShootPosition = GetPosition();
			FanMultipleShoot(BulletAlias, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot, AlignShootDelay, BulletCount, Duration, ShootPosition, ShootPositionY, MultiShootDirection, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Angle, Radius, InnerRadius);
			MultiShootDirection = RotateTo(MultiShootDirection, 11.5);
			yield return WaitTime(0.1);
			LoopTime += (FP)0.1;
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (Distance(GetPosition(), TSVector2.zero) >= 1.5)
		{
			MoveToPosition(TSVector2.zero, 0.05);
			yield return WaitMoveStatus();
			yield return BeginLookAtByPos(new TSVector2(0, -10), 0, 720);
		}
	}

	private IEnumerator Split()
	{
		BeginAttack(DisappearedIndex, DisappearedAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.3);
		ShootPosition = GetPosition();
		CircleMultipleShoot(SummonBullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot, AlignShootDelay, SummonCount, Duration, ShootPosition, ShootPositionY, MultiShootDirection, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, SummonRadius, SummonInnerRadius);
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		SetSearchedImmunityEnable();
		SetBattleOutEnable();
		yield return WaitTime(2);
		int aiType = GetAiType();
		bool loopSwitch = true;
		while ((Time <= SplitWaitTime) & loopSwitch)
		{
			int num = (int)(long)GetLogicTagFpValue(_actor, mSlimeCountTag);
			int num2 = (int)(long)GetLogicTagFpValue(_actor, sSlimeCountTag);
			NovaLogger.Debug("大史莱姆.分裂.中史莱姆:小史莱姆为 " + num + ":" + num2);
			switch (aiType)
			{
			case 0:
			case 1:
				if (num >= mSlime)
				{
					loopSwitch = false;
					NovaLogger.Debug("大史莱姆.分裂.击杀足量的中史莱姆,进入判定阶段");
				}
				else if (GetLogicTagToggleValue(_actor, "IsBurst"))
				{
					NovaLogger.Debug("大史莱姆.分裂.爆发标签为T,进入判定阶段");
					yield return WaitTime(1.3);
					loopSwitch = false;
				}
				break;
			case 2:
				if (num >= mSlime && num2 >= sSlime)
				{
					loopSwitch = false;
				}
				else if (GetLogicTagToggleValue(_actor, "IsBurst"))
				{
					yield return WaitTime(1.3);
					loopSwitch = false;
				}
				break;
			default:
				if (num >= mSlime)
				{
					loopSwitch = false;
				}
				else if (GetLogicTagToggleValue(_actor, "IsBurst"))
				{
					yield return WaitTime(1.3);
					loopSwitch = false;
				}
				break;
			}
			yield return WaitTime(0.2);
			Time += (FP)0.2;
			if (Time > SplitWaitTime)
			{
				ClearMates();
				SetLogicTagToggleValue(_actor, "IsBurst", value: true);
				NovaLogger.Debug("大史莱姆.分裂.时间结束,进入判定阶段");
			}
		}
		yield return WaitTime(0.5);
	}

	private IEnumerator Result()
	{
		SetBattleOutDisable();
		SetCloseBlockDisable();
		if (GetLogicTagToggleValue(_actor, "IsBurst"))
		{
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			BeginAttack(BurstIndex, BurstAction, flushInputedKeys: true, forceInterruptAttack: true);
			SetSearchedImmunityDisable();
			SetImmuneControlDisable();
			InterruptLockToughness();
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			PlayEffect("fx_common_base_charge_fire_actor", 1f, 2f, GetPosition(), default, 3f);
			BurstShootPosition = GetPosition();
			BurstMultiShootDirection = GetForward();
			while (BurstTime <= BurstFinishTime)
			{
				CircleMultipleShoot(BurstBulletAlias, AdventureWeapon.MultipleShootStyle.FromCenterToSide, BurstAlignShoot, BurstAlignShootDelay, BurstBulletCount, BurstDuration, BurstShootPosition, BurstShootPositionY, BurstMultiShootDirection, BurstBulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, BurstRadius, BurstInnerRadius);
				BurstTime++;
				yield return WaitTime(1);
			}
			CancelAttack();
		}
		else
		{
			PlayEffect(FxAlias, 1f, default, GetPosition(), GetRotation());
			yield return WaitTime(0.35);
			BeginAttack(WeaknessIndex, WeaknessAction, flushInputedKeys: true, forceInterruptAttack: true);
			SetSearchedImmunityDisable();
			SetImmuneControlDisable();
			InterruptLockToughness();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void ClearMates()
	{
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		if (targetsByFaction.Count != 0)
		{
			for (int i = 0; i < targetsByFaction.Count; i++)
			{
				PlayEffect("fx_50071_base_die", 1f, default, GetEntityPosition(targetsByFaction.get_Item(i)), GetEntityAngle(targetsByFaction.get_Item(i)));
			}
			ClearActors(targetsByFaction);
			SetLogicTagToggleValue(_actor, "IsBurst", value: true);
		}
	}

	private int GetAiType()
	{
		int num = 0;
		switch (GetMonsterTagValue(_actor, 1))
		{
		case "Easy":
			num = 0;
			NovaLogger.Debug("大史莱姆.分裂.简单AI");
			break;
		case "Normal":
			num = 1;
			NovaLogger.Debug("大史莱姆.分裂.中等AI");
			break;
		case "Hard":
			num = 2;
			NovaLogger.Debug("大史莱姆.分裂.困难AI");
			break;
		default:
			NovaLogger.Debug("大史莱姆.获取AI类型异常,默认为简单");
			num = 0;
			break;
		}
		return num;
	}
}
