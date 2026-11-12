#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class JinDuanLiRongSkillBase : SkillSimpleBase
{
	protected readonly string In_CheckBossScro_Tag1 = "In_CheckBossScro_Tag1";

	protected readonly string In_CheckBossScro_Tag2 = "In_CheckBossScro_Tag2";

	private const string aiTypeEasy = "Easy";

	private const string aiTypeNormal = "Normal";

	private const string aiTypeHard = "Hard";

	private const string aiTypeBossRush = "BossRush";

	protected static readonly int NormalATKAIndex = 0;

	protected static readonly string NormalATKAKey = "NormalATK_A";

	protected static readonly int NormalATKA2BRIndex = 1;

	protected static readonly string NormalATKA2BRKey = "NormalATK_A2BR";

	protected static readonly int NormalATKBRIndex = 2;

	protected static readonly string NormalATKBRKey = "NormalATK_BR";

	protected static readonly int NormalATKBRWaitIndex = 3;

	protected static readonly string NormalATKBRWaitKey = "NormalATK_BRWait";

	protected static readonly int NormalATKA2BLIndex = 4;

	protected static readonly string NormalATKA2BLRKey = "NormalATK_A2BL";

	protected static readonly int NormalATKBLIndex = 5;

	protected static readonly string NormalATKBLKey = "NormalATK_BL";

	protected static readonly int NormalATKBLWaitIndex = 6;

	protected static readonly string NormalATKBLWaitKey = "NormalATK_BLWait";

	protected static readonly int dashiIndex;

	protected static readonly int chargeIndex = 7;

	protected static readonly string chargeKey = "Charge";

	protected static readonly int KickIndex = 8;

	protected static readonly string KickKey = "Kick";

	protected static readonly int JumpBackIndex = 9;

	protected static readonly string JumpBackKey = "JumpBack";

	protected static readonly int AppelLIndex = 10;

	protected static readonly string AppelLKey = "AppelL";

	protected static readonly int AppelRIndex = 11;

	protected static readonly string AppelRKey = "AppelR";

	protected static readonly int breakATKIndex = 12;

	protected static readonly string breakATKKey = "Break_Attack";

	protected static readonly int breakEndIndex = 13;

	protected static readonly string breakEndKey = "Break_End";

	protected static readonly int SwitchIndex = 13;

	protected static readonly string SwitchKey = "JC_Switch";

	protected static readonly int FAIndex = 14;

	protected static readonly string FAKey = "FA";

	protected static readonly int ReturnIndex = 15;

	protected static readonly string ReturnKey = "Return";

	protected static readonly int JCSwitchIndex = 16;

	protected static readonly string JCSwitchKey = "JC_Switch";

	protected static readonly int JCATKIndex = 17;

	protected static readonly string JCATKKey = "JC_Attack";

	protected static readonly int SwitchArmsnIndex = 18;

	protected static readonly string SwitchArmsKey = "SwitchArms";

	protected static readonly int GeneralIndex = 19;

	protected static readonly string GeneralKey = "General";

	protected static readonly int General02Index = 20;

	protected static readonly string General02Key = "General02";

	protected static readonly int idleIndex = 21;

	protected static readonly string idle2Key = "Idle";

	protected static readonly int warnderAction_Hand_Index = 22;

	protected static readonly string warnderAction_Hand_Key = "WanderAction_Hand";

	protected static readonly int warnderAction_Foot_Index = 23;

	protected static readonly string warnderAction_Foot_Key = "WanderAction_Foot";

	protected readonly string warningFx = "fx_common_base_charge_fire_actor";

	protected IEnumerator SummonMate()
	{
		SummonTeammate(6, new TSVector2(0, 12.5), new TSVector2(0, -12.5));
		SummonTeammate(6, new TSVector2(0, -12.5), new TSVector2(0, 12.5));
		SummonTeammate(6, new TSVector2(-12.5, 0), new TSVector2(12.5, 0));
		SummonTeammate(6, new TSVector2(12.5, 0), new TSVector2(-12.5, 0));
		yield break;
	}

	protected IEnumerator Move()
	{
		if (Distance(GetPosition(), TSVector2.zero) >= 12)
		{
			NovaLogger.Debug("禁断丽容.剪刀吹风填充.位于场边向场景中心移动");
			yield return StartCor(Appel2Zero());
		}
		else if (TSMath.Abs(AngleBetween2TSVector(GetForward(), GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), signed: true)) > 70 && Distance(GetPosition(), TSVector2.zero) >= 8)
		{
			NovaLogger.Debug("禁断丽容.剪刀吹风填充.进入后跳范围");
			yield return StartCor(BackJump());
		}
		else
		{
			NovaLogger.Debug("禁断丽容.剪刀吹风填充.进入垫步范围");
			yield return StartCor(Appel());
			SetLogicTagToggleValue(_actor, "appelIsDone", value: true);
		}
	}

	protected int GetAiType()
	{
		int num = 0;
		switch (GetMonsterTagValue(_actor, 1))
		{
		case "Easy":
			return 0;
		case "Normal":
			return 1;
		case "Hard":
			return 2;
		case "BossRush":
			return 3;
		default:
			NovaLogger.Debug("禁断丽容.通用API.获取AI类型异常,默认为简单");
			return 0;
		}
	}

	protected LogicEntity GetTarget()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			return GetAttackTarget();
		}
		return GetCurrentPlayer();
	}

	protected IEnumerator ScoreLogicTag1()
	{
		NovaLogger.Debug("禁断丽容.得分词条.开始");
		SetLogicTagToggleValue(_actor, In_CheckBossScro_Tag1, value: true);
		yield return WaitTime(2.1);
		SetLogicTagToggleValue(_actor, In_CheckBossScro_Tag1, value: false);
		NovaLogger.Debug("禁断丽容.得分词条.结束");
	}

	protected IEnumerator ScoreLogicTag2()
	{
		NovaLogger.Debug("禁断丽容.得分词条.开始");
		SetLogicTagToggleValue(_actor, In_CheckBossScro_Tag2, value: true);
		yield return WaitTime(2.1);
		SetLogicTagToggleValue(_actor, In_CheckBossScro_Tag2, value: false);
		NovaLogger.Debug("禁断丽容.得分词条.结束");
	}

	private IEnumerator Appel2Zero()
	{
		_ = TSVector2.zero;
		_ = (FP)0;
		_ = (FP)0;
		_ = TSVector2.zero;
		int i = 0;
		int j = ((TSRandom.Range(0, 2) != 0) ? 1 : (-1));
		while (i < 2)
		{
			TSVector2 zero = TSVector2.zero;
			TSVector2 tSVector = RotateTo(zero - GetPosition(), GetRandomValue(10, 30) * j);
			FP fP = TSMath.Clamp(Distance(tSVector, GetPosition()), 4, 8);
			FP speed = fP / 0.3;
			if (j < 0)
			{
				BeginAttack(AppelRIndex, AppelRKey, flushInputedKeys: true, forceInterruptAttack: true);
			}
			else
			{
				BeginAttack(AppelLIndex, AppelLKey, flushInputedKeys: true, forceInterruptAttack: true);
			}
			BeginDash(10, tSVector, speed, fP, 99999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.2);
			BeginLookAtByPos_NotWait(zero, 0.25, 720);
			yield return WaitDashFinish();
			StopLookAt();
			i++;
			j *= -1;
		}
		yield return null;
		InterruptAttack();
	}

	private IEnumerator BackJump()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		yield return BeginLookAtByPos(GetEntityPositionObsoleted(currentPlayer), 0.05, 3600);
		BeginAttack(JumpBackIndex, JumpBackKey, flushInputedKeys: true, forceInterruptAttack: true);
		SetCloseBlockEnable();
		SetSearchedImmunityEnable();
		TSVector2 forward = GetForward();
		TSVector2 Direction = RotateTo(forward, 180);
		FP speed = 20.0;
		FP DIST = 10;
		FP angleLimit = 360;
		BeginDash(dashiIndex, Direction, speed, DIST, angleLimit, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitTime(0.4);
		SetSearchedImmunityDisable();
		for (int i = 0; i < 15; i++)
		{
			StopDash();
			speed += (FP)(-2.0);
			if (speed <= 0)
			{
				break;
			}
			BeginDash(dashiIndex, Direction, speed, DIST, angleLimit, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.2);
			yield return WaitTime(0.02);
		}
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return null;
	}

	private IEnumerator Appel()
	{
		Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer()));
		_ = TSVector2.zero;
		_ = (FP)0;
		_ = (FP)0;
		_ = TSVector2.zero;
		int i = 0;
		int j = ((TSRandom.Range(0, 2) != 0) ? 1 : (-1));
		while (i < 2)
		{
			NovaLogger.Debug("禁断丽容.剪刀吹风填充.垫步开始");
			FP fP = Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer()));
			FP fP2 = AngleBetween2TSVector(GetForward(), GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), signed: true);
			if (fP <= 4)
			{
				FP fP3 = fP;
				NovaLogger.Debug("禁断丽容.距离结果.贴身" + fP3.ToString());
				TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetPosition() - GetEntityPositionObsoleted(GetCurrentPlayer()), new TSVector2(0, 6));
				TSVector2 direction = RotateTo(tSVector, GetRandomValue(50, 80) * j);
				FP fP4 = Distance(tSVector, GetPosition());
				FP speed = fP4 / 0.3;
				if (j > 0)
				{
					BeginAttack(AppelRIndex, AppelRKey, flushInputedKeys: true, forceInterruptAttack: true);
				}
				else
				{
					BeginAttack(AppelLIndex, AppelLKey, flushInputedKeys: true, forceInterruptAttack: true);
				}
				BeginDash(10, direction, speed, fP4, 99999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
				BeginLookAtByPos_NotWait(GetEntityPositionObsoleted(GetCurrentPlayer()), 0.25, 720);
				yield return WaitDashFinish();
				StopLookAt();
			}
			else
			{
				FP fP3;
				TSVector2 direction;
				FP fP4;
				FP speed;
				if (fP <= 7 && fP > 4)
				{
					fP3 = fP;
					NovaLogger.Debug("禁断丽容.距离结果.中距离" + fP3.ToString());
					GetEntityPositionObsoleted(GetCurrentPlayer());
					fP4 = 8;
					speed = fP4 / 0.3;
					if (fP2 > 0)
					{
						direction = RotateTo(GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), 40);
						BeginAttack(AppelLIndex, AppelLKey, flushInputedKeys: true, forceInterruptAttack: true);
					}
					else
					{
						direction = RotateTo(GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), -40);
						BeginAttack(AppelRIndex, AppelRKey, flushInputedKeys: true, forceInterruptAttack: true);
					}
					BeginDash(10, direction, speed, fP4, 99999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
					BeginLookAtByPos_NotWait(GetEntityPositionObsoleted(GetCurrentPlayer()), 0.25, 720);
					yield return WaitDashFinish();
					StopLookAt();
					break;
				}
				fP3 = fP;
				NovaLogger.Debug("禁断丽容.距离结果.远距离" + fP3.ToString());
				TSVector2 tSVector = GetEntityPositionObsoleted(GetCurrentPlayer());
				direction = RotateTo(tSVector - GetPosition(), 40 * j);
				fP4 = TSMath.Clamp(Distance(direction, GetPosition()), 4, 10);
				speed = fP4 / 0.3;
				if (j < 0)
				{
					BeginAttack(AppelRIndex, AppelRKey, flushInputedKeys: true, forceInterruptAttack: true);
				}
				else
				{
					BeginAttack(AppelLIndex, AppelLKey, flushInputedKeys: true, forceInterruptAttack: true);
				}
				BeginDash(10, direction, speed, fP4, 99999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
				BeginLookAtByPos_NotWait(tSVector, 0.25, 720);
				yield return WaitDashFinish();
				StopLookAt();
			}
			yield return null;
			i++;
			j *= -1;
		}
		yield return null;
	}
}
