#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_BunsinAttack : SkillSimpleBase
{
	private readonly string FlashFx = "fx_70022_base_Kagebunsin_Flash";

	private bool release;

	private bool AsyncRelease;

	private bool SyncRelease;

	private bool Sync_SWC_Release;

	private bool Sync_SWC_Action;

	private bool BunsinMove;

	private int skillType;

	private int SkillWaitTime;

	private FP ClearWaitTime;

	private CoroutineNode CheckDash;

	private CoroutineNode WaitINTRCor;

	private DeterministicShape DamageShape;

	private DeterministicShape.ShapeType Shape;

	private TSVector2 POS;

	private FP Width;

	private FP Length;

	private FP Radius;

	private FP InnerRadius;

	private FP Angle;

	private FP rotation;

	private HitFeatureData HitfeatureData;

	private FP HitSrenth = 4;

	private int hitDamegeID = 70022001;

	private FP damageimmuneDuration = 0;

	private string hittedEffect = "fx_70022_hit_Acition";

	private readonly string BaseFX = "fx_70022_base_Skill01_Start";

	private readonly string DamageFx = "fx_70022_atk_Skill01";

	private readonly string Dot = "fx_70022_atk_Skill01_loop";

	private readonly string HitFx = "fx_70022_hit_Skill01";

	private readonly string ClockFx = "fx_70022_ground_Kagebunsin_Clock";

	private List<long> ClockFxList = new List<long>();

	private readonly string ClockEndFx = "fx_70022_ground_Kagebunsin_Clock_end";

	private List<long> ClockFxEndList = new List<long>();

	private List<TSVector2> SummonPOS02 = new List<TSVector2>
	{
		new TSVector2(0, 9),
		new TSVector2(9, 0),
		new TSVector2(0, -9),
		new TSVector2(-9, 0)
	};

	private List<TSVector2> SummonPOS01 = new List<TSVector2>
	{
		new TSVector2(-3, 0),
		new TSVector2(3, 0)
	};

	private List<TSVector2> MovePOSList = new List<TSVector2>();

	private readonly TSVector2 ZeroPOS = new TSVector2(0, 0);

	private readonly string WarningFx_Actor = "fx_common_base_charge_fire_actor";

	private int NinjutsuIndex;

	private string NinjutsuKey = "Ninjutsu_G";

	private List<long> WarningIndexList_Cir = new List<long>();

	private readonly string WarningFX_Cir = "fx_70022_loop_warning_Skill01";

	private readonly string BaseFX_Cir = "fx_70022_base_Skill01_Start";

	private readonly string DamageFx_Cir = "fx_70022_atk_Skill01";

	private readonly string Dot_Cir = "Master_Cir_atk";

	private List<long> WarningIndexList_Ring = new List<long>();

	private readonly string WarningFX_Ring = "fx_70022_loop_warning_Skill02";

	private readonly string BaseFX_Ring = "fx_70022_base_Skill02_Start";

	private readonly string DamageFx_Ring = "fx_70022_atk_Skill02";

	private readonly string Dot_Ring = "Master_Ring_atk";

	private List<long> WarningIndexList_Fan = new List<long>();

	private readonly string WarningFX_Fan = "fx_70022_loop_warning_Skill03";

	private readonly string BaseFX_Fan = "fx_70022_base_Skill03_Start";

	private readonly string DamageFx_Fan = "fx_70022_atk_Skill03";

	private readonly string Dot_Fan = "Fan_atk";

	private readonly int ActionIndex;

	private readonly string ActionKey = "Dash";

	private readonly string DashBaseFx = "fx_70022_loop_Dodge_Shukuchi";

	private long DashBaseIndex;

	private int DashIndex = 10;

	private TSVector2 Direction;

	private FP Speed;

	private FP DIST;

	private FP AngleLimit = 999;

	private LogicEntity Target;

	private static List<LogicEntity> ClearActor = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		release = false;
		AsyncRelease = false;
		SyncRelease = false;
		Sync_SWC_Release = false;
		BunsinMove = false;
		Sync_SWC_Action = false;
	}

	protected override void OnSkillDisable()
	{
		MovePOSList.Clear();
		WarningIndexList_Cir.Clear();
		WarningIndexList_Ring.Clear();
		WarningIndexList_Fan.Clear();
		ClearActor.Clear();
		ClockFxList.Clear();
		ClockFxEndList.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.2, 9999);
		MovePOSList.AddRange(SummonPOS02);
		for (int i = 0; i < 200; i++)
		{
			release = GetLogicTagToggleValue(_actor, "release");
			AsyncRelease = GetLogicTagToggleValue(_actor, "AsyncRelease");
			SyncRelease = GetLogicTagToggleValue(_actor, "SyncRelease");
			Sync_SWC_Release = GetLogicTagToggleValue(_actor, "Sync_SWC_Release");
			Sync_SWC_Action = GetLogicTagToggleValue(_actor, "Sync_SWC_Action");
			if (release)
			{
				skillType = (int)(long)GetLogicTagFpValue(_actor, "bunsinSkill");
				ClearWaitTime = 1.7;
				yield return WaitTime(1);
				switch (skillType)
				{
				case 0:
					yield return StartCor(CircleAOE());
					yield return StartCor(ClearSelf());
					break;
				case 1:
					yield return StartCor(RingAOE());
					yield return StartCor(ClearSelf());
					break;
				case 2:
					yield return StartCor(FanAOE());
					yield return StartCor(ClearSelf());
					break;
				default:
					yield return StartCor(FanAOE());
					yield return StartCor(ClearSelf());
					break;
				}
			}
			else if (AsyncRelease)
			{
				SkillWaitTime = (int)(long)GetLogicTagFpValue(_actor, "SkillWaitTime");
				switch (SkillWaitTime)
				{
				case 0:
					ClockFxList.Add(PlayEffect(ClockFx, 0.36f, default, GetPosition(), default, 1.5f, actorScale: true));
					yield return WaitTime(0.5);
					break;
				case 1:
					ClockFxList.Add(PlayEffect(ClockFx, 0.18f, default, GetPosition(), default, 1.5f, actorScale: true));
					yield return WaitTime(3.5);
					break;
				case 2:
					ClockFxList.Add(PlayEffect(ClockFx, 0.115f, default, GetPosition(), default, 1.5f, actorScale: true));
					yield return WaitTime(6.5);
					break;
				case 3:
					ClockFxList.Add(PlayEffect(ClockFx, 0.085f, default, GetPosition(), default, 1.5f, actorScale: true));
					yield return WaitTime(9.5);
					break;
				}
				skillType = (int)(long)GetLogicTagFpValue(_actor, "bunsinSkill");
				ClearWaitTime = 1.7;
				switch (skillType)
				{
				case 0:
					NovaLogger.Debug("花原分身.分身攻击");
					yield return StartCor(CircleAOE());
					NovaLogger.Debug("花原分身.清除自身");
					yield return StartCor(ClearSelf());
					break;
				case 1:
					NovaLogger.Debug("花原分身.分身攻击");
					yield return StartCor(RingAOE());
					NovaLogger.Debug("花原分身.清除自身");
					yield return StartCor(ClearSelf());
					break;
				case 2:
					yield return StartCor(FanAOE());
					yield return StartCor(ClearSelf());
					break;
				default:
					yield return StartCor(FanAOE());
					yield return StartCor(ClearSelf());
					break;
				}
			}
			else if (SyncRelease)
			{
				skillType = (int)(long)GetLogicTagFpValue(_actor, "bunsinSkill");
				ClearWaitTime = 1.7;
				switch (skillType)
				{
				case 0:
					ClockFxList.Add(PlayEffect(ClockFx, 0.1125f, default, GetPosition(), default, 1.5f, actorScale: true));
					yield return WaitTime(6.8);
					yield return StartCor(CircleAOE());
					yield return StartCor(ClearSelf());
					break;
				case 1:
					ClockFxList.Add(PlayEffect(ClockFx, 0.38f, default, GetPosition(), default, 1.5f, actorScale: true));
					yield return WaitTime(0.5);
					yield return StartCor(RingAOE());
					yield return StartCor(ClearSelf());
					break;
				case 3:
					yield return StartCor(GeneralAttack());
					yield return StartCor(ClearSelf());
					break;
				default:
					yield return StartCor(FanAOE());
					yield return StartCor(ClearSelf());
					break;
				}
			}
			else if (Sync_SWC_Action)
			{
				NovaLogger.Debug("分身进入易位流程");
				FP fP = 0;
				FP selfIndex = GetLogicTagFpValue(_actor, "bunsinIndex");
				if (selfIndex == 2)
				{
					fP = 3;
				}
				else if (selfIndex == 3)
				{
					fP = 2;
				}
				else
				{
					NovaLogger.Debug("花原分身.同步分身易位.获取索引失败");
					InterruptAttack();
				}
				TSVector2 targetPos = TSVector2.zero;
				foreach (LogicEntity item in GetTargetsByFaction(isFriend: true))
				{
					if (GetLogicTagFpValue(item, "bunsinIndex") == fP)
					{
						targetPos = GetEntityPositionObsoleted(item);
						break;
					}
				}
				if (targetPos != TSVector2.zero)
				{
					BeginAttack(ActionIndex, ActionKey, flushInputedKeys: true, forceInterruptAttack: true);
					yield return BeginLookAtByPos(targetPos, 0.2, 900);
					CancelAttack();
					TSVector2 position = GetPosition();
					FP fP2 = Distance(position, targetPos);
					BeginDash(0, targetPos - GetPosition(), fP2 / 0.4, fP2, 900, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
					long dashFxID = PlayEffect(DashBaseFx);
					yield return WaitDashFinish();
					StopEffect(dashFxID);
					yield return BeginLookAtByPos(TSVector2.zero, 0.2, 900);
					List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(0);
					LogicEntity entity = _actor;
					if (targetByTeammateIndex.Count > 0)
					{
						entity = targetByTeammateIndex.get_Item(0);
					}
					else
					{
						NovaLogger.Debug("花原分身.同步分身易位.获取主人失败");
						InterruptAttack();
					}
					List<long> list = new List<long>();
					list.AddRange(GetLogicTagListLongValue(entity, "bunsinDashState"));
					if (selfIndex == 2)
					{
						SetLogicTagListLongValue(entity, "bunsinDashState", new List<long>
						{
							1L,
							list.get_Item(1)
						});
					}
					else if (selfIndex == 3)
					{
						SetLogicTagListLongValue(entity, "bunsinDashState", new List<long>
						{
							list.get_Item(0),
							1L
						});
					}
					else
					{
						NovaLogger.Debug("花原分身.同步分身易位.为主人添加逻辑标签失败");
						InterruptAttack();
					}
					SetLogicTagToggleValue(_actor, "Sync_SWC_Action", value: false);
					NovaLogger.Debug("花原分身.同步分身易位.分身移动完成");
				}
				else
				{
					NovaLogger.Debug("花原分身.同步分身易位.获取目标位置失败");
					InterruptAttack();
				}
			}
			else if (Sync_SWC_Release)
			{
				NovaLogger.Debug("分身进入易位攻击流程");
				skillType = (int)(long)GetLogicTagFpValue(_actor, "bunsinSkill");
				ClearWaitTime = 1.7;
				switch (skillType)
				{
				case 0:
					ClockFxList.Add(PlayEffect(ClockFx, 0.1125f, default, GetPosition(), default, 1.5f, actorScale: true));
					WaitINTRCor = StartCor(WaitINTR());
					yield return StartCor(CircleAOE());
					yield return StartCor(ClearSelf());
					break;
				case 1:
					ClockFxList.Add(PlayEffect(ClockFx, 0.38f, default, GetPosition(), default, 1.5f, actorScale: true));
					WaitINTRCor = StartCor(WaitINTR());
					yield return StartCor(RingAOE());
					yield return StartCor(ClearSelf());
					break;
				case 3:
					yield return StartCor(GeneralAttack());
					yield return StartCor(ClearSelf());
					break;
				default:
					yield return StartCor(FanAOE());
					yield return StartCor(ClearSelf());
					break;
				}
			}
			yield return WaitTime(0.1);
		}
	}

	protected IEnumerator ClearSelf()
	{
		yield return WaitTime(0.5);
		PlayEffect(FlashFx, 1f, default, GetPosition(), default, 2.2f);
		SetHideModelEnable();
		yield return WaitTime(1.6);
		List<LogicEntity> entities = new List<LogicEntity> { _actor };
		ClearActors(entities);
	}

	protected IEnumerator FanAOE()
	{
		BeginAttack(NinjutsuIndex, NinjutsuKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.2, 9999);
		yield return WaitTime(0.7);
		yield return WaitTime(0.7);
		PlayEffect(BaseFX_Fan, 1f, default, GetPosition());
		yield return WaitTime(0.6);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		ClockFxEndList.Add(PlayEffect(ClockEndFx, 1f, default, GetPosition(), default, 1.5f, actorScale: true));
		yield return WaitTime(0.6);
		PlayAreaEffect(Dot_Fan, GetPosition(), GetRotation());
		PlayEffect(DamageFx_Fan, 1f, default, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		yield return WaitTime(0.2);
		for (int i = 0; i < WarningIndexList_Fan.Count; i++)
		{
			StopEffect(WarningIndexList_Fan.get_Item(i));
		}
		yield return WaitTime(0.4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator CircleAOE()
	{
		BeginAttack(NinjutsuIndex, NinjutsuKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.2, 9999);
		yield return WaitTime(0.7);
		yield return WaitTime(1.3);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		ClockFxEndList.Add(PlayEffect(ClockEndFx, 1f, default, GetPosition(), default, 1.5f, actorScale: true));
		PlayEffect(BaseFX_Cir, 1f, default, GetPosition());
		yield return WaitTime(0.5);
		PlayEffect(DamageFx_Cir, 1f, default, GetPosition());
		yield return WaitTime(0.2);
		PlayAreaEffect(Dot_Cir, GetPosition(), GetRotation());
		yield return WaitTime(0.2);
		yield return WaitTime(0.4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator RingAOE()
	{
		BeginAttack(NinjutsuIndex, NinjutsuKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.2, 9999);
		yield return WaitTime(0.7);
		yield return WaitTime(1.1);
		PlayEffect(BaseFX_Ring, 1f, default, GetPosition());
		yield return WaitTime(0.2);
		ClockFxEndList.Add(PlayEffect(ClockEndFx, 1f, default, GetPosition(), default, 1.5f, actorScale: true));
		yield return WaitTime(0.6);
		PlayEffect(DamageFx_Ring, 1f, default, GetPosition());
		yield return WaitTime(0.2);
		PlayAreaEffect(Dot_Ring, GetPosition(), GetRotation());
		yield return WaitTime(0.2);
		yield return WaitTime(0.4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator GeneralAttack()
	{
		BeginAttack(NinjutsuIndex, NinjutsuKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator WaitINTR()
	{
		if (skillType == 0)
		{
			yield return WaitTime(5.2);
		}
		else
		{
			yield return WaitTime(0.5);
		}
		StopCor(CheckDash);
	}
}
