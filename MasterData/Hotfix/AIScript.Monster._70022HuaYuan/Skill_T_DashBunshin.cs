using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_DashBunshin : SkillSimpleBase
{
	private bool IsNormalEnd;

	private static readonly string FlashFx = "fx_70022_base_Kagebunsin_Flash";

	private static readonly string ControlFx = "fx_70022_bullet_Kagebunsin_Control";

	private static List<long> ControlFxList = new List<long>();

	private static readonly string ControllineFx = "fx_70022_loop_Kagebunsin_Control_line";

	private static List<long> ControllineFxList = new List<long>();

	private static readonly string ClockFx = "fx_70022_ground_Kagebunsin_Clock";

	private static List<long> ClockFxList = new List<long>();

	private static readonly string ActiveFx = "fx_70022_loop_Kagebunsin_Active";

	private static List<long> ActiveFxList = new List<long>();

	private static TSVector2 SelfPOS;

	private static TSVector2 TargetPOS;

	private static int MonsterID = 1;

	private static List<LogicEntity> SummonList = new List<LogicEntity>();

	private static List<TSVector2> SummonPOS = new List<TSVector2>();

	private static List<TSVector2> SummonPOS01 = new List<TSVector2>
	{
		new TSVector2(-7.5, 7.5),
		new TSVector2(7.5, -7.5)
	};

	private static List<TSVector2> SummonPOS02 = new List<TSVector2>
	{
		new TSVector2(7.5, 7.5),
		new TSVector2(-7.5, -7.5)
	};

	private static int SkillBranch;

	private static readonly string WarningFx_Actor = "fx_common_base_charge_fire_actor";

	private static int NinjutsuIndex = 0;

	private static string NinjutsuKey = "Ninjutsu_G";

	private static int NinjutsuIndex_Loop = 1;

	private static string NinjutsuKey_Loop = "Nijutsu_Loop";

	private static long WarningFxIndex_Cir;

	private static readonly string WarningFX_Cir = "fx_70022_loop_warning_Skill01";

	private static readonly string BaseFX_Cir = "fx_70022_base_Skill01_Start";

	private static readonly string DamageFx_Cir = "fx_70022_atk_Skill01";

	private static readonly string Dot_Cir = "Bunsin_Cir_atk";

	private static long WarningFxIndex_Ring;

	private static readonly string WarningFX_Ring = "fx_70022_loop_warning_Skill02";

	private static readonly string BaseFX_Ring = "fx_70022_base_Skill02_Start";

	private static readonly string DamageFx_Ring = "fx_70022_atk_Skill02";

	private static readonly string Dot_Ring = "Bunsin_Ring_atk";

	private static long WarningFxIndex_Fan;

	private static readonly string WarningFX_Fan = "fx_70022_loop_warning_Skill03";

	private static readonly string BaseFX_Fan = "fx_70022_base_Skill03_Start";

	private static readonly string DamageFx_Fan = "fx_70022_atk_Skill03";

	private static readonly string Dot_Fan = "Fan_atk";

	private static string LineFx = "fx_70022_laser_STrow";

	private static List<long> LineFxList = new List<long>();

	private static long IndexFxDogde;

	private static readonly string Fx_Dogde = "fx_70022_loop_Dodge_Shukuchi";

	private static readonly TSVector2 ZeroPOS = new TSVector2(0, 0);

	private static readonly int ActionIndex = 0;

	private static readonly string ActionKey = "Dash";

	private static readonly int JumpIndex = 1;

	private static readonly string JumpKey = "Jump";

	private static readonly int DashLoopIndex = 2;

	private static readonly string DashLoopKey = "DashLoop";

	private static int DashIndex = 10;

	private static TSVector2 Direction;

	private static FP Speed;

	private static FP DIST;

	private static FP AngleLimit = 999;

	private static bool Select;

	private static List<TSVector2> DashPOS = new List<TSVector2>();

	protected override void OnSkillEnable()
	{
		SkillBranch = 0;
		SummonList.Clear();
		ControlFxList.Clear();
		ControllineFxList.Clear();
		ClockFxList.Clear();
		ActiveFxList.Clear();
		SummonPOS.Clear();
		Select = false;
		DashPOS.Clear();
		LineFxList.Clear();
	}

	protected override void OnSkillDisable()
	{
		SummonList.Clear();
		ControlFxList.Clear();
		ControllineFxList.Clear();
		ClockFxList.Clear();
		DashPOS.Clear();
		LineFxList.Clear();
		if (!IsNormalEnd)
		{
			List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
			if (targetsByFaction.Count > 0)
			{
				for (int i = 0; i < targetsByFaction.Count; i++)
				{
					PlayEffect(FlashFx, 1f, default, GetEntityPosition(targetsByFaction.get_Item(i)), default, 2.2f);
				}
				ClearActors(targetsByFaction);
			}
			if (ActiveFxList.Count > 0)
			{
				for (int j = 0; j < ActiveFxList.Count; j++)
				{
					StopEffect(ActiveFxList.get_Item(j));
				}
			}
		}
		ActiveFxList.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(Summon_One());
		yield return StartCor(Control());
		yield return StartCor(Link());
		yield return StartCor(Attack_Master());
		yield return StartCor(Tag_Bunsin());
		IsNormalEnd = true;
		yield return StartCor(MultipleDash());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Summon_One()
	{
		BeginAttack(NinjutsuIndex, NinjutsuKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if ((int)(long)GetRandomValue(0, 1.5, isInt: true) == 0)
		{
			SummonPOS.AddRange(SummonPOS01);
		}
		else
		{
			SummonPOS.AddRange(SummonPOS02);
		}
		for (int i = 0; i < SummonPOS.Count; i++)
		{
			SummonTeammate(MonsterID, SummonPOS.get_Item(i), new TSVector2(0, 0) - SummonPOS.get_Item(i));
			PlayEffect(FlashFx, 1f, default, SummonPOS.get_Item(i), default, 2.2f);
		}
		yield return WaitTime(0.1);
		SummonList.AddRange(GetTargetByTeammateIndex(MonsterID));
		for (int j = 0; j < SummonList.Count; j++)
		{
			SetLogicTagToggleValue(SummonList.get_Item(j), "release", value: false);
		}
	}

	protected IEnumerator Control()
	{
		SelfPOS = GetPosition();
		for (int i = 0; i < SummonList.Count; i++)
		{
			TargetPOS = GetEntityPosition(SummonList.get_Item(i));
			ControlFxList.Add(PlayLinkEffect(ControlFx, useCustomSource: true, null, SelfPOS, default, null, TargetPOS, default, breakWhenLostSourceOrTarget: true, 1f, actorScale: true));
		}
		yield return WaitTime(0.25);
		for (int j = 0; j < SummonList.Count; j++)
		{
			TargetPOS = GetEntityPosition(SummonList.get_Item(j));
			ControllineFxList.Add(PlayLinkEffect(ControllineFx, useCustomSource: true, null, SelfPOS, 0.3, null, TargetPOS, default, breakWhenLostSourceOrTarget: true, 1f, actorScale: true));
		}
		yield return WaitTime(0.4);
	}

	protected IEnumerator Attack_Master()
	{
		SkillBranch = 1;
		switch (SkillBranch)
		{
		case 0:
		{
			yield return StartCor(CircleAOE());
			for (int k = 0; k < SummonList.Count; k++)
			{
				SetLogicTagFpValue(SummonList.get_Item(k), "bunsinSkill", 0);
			}
			break;
		}
		case 1:
		{
			yield return StartCor(RingAOE());
			for (int j = 0; j < SummonList.Count; j++)
			{
				SetLogicTagFpValue(SummonList.get_Item(j), "bunsinSkill", 1);
			}
			break;
		}
		default:
		{
			yield return StartCor(CircleAOE());
			for (int i = 0; i < SummonList.Count; i++)
			{
				SetLogicTagFpValue(SummonList.get_Item(i), "bunsinSkill", 0);
			}
			break;
		}
		}
		yield return WaitTime(0.4);
	}

	protected IEnumerator Link()
	{
		for (int i = 0; i < SummonList.Count; i++)
		{
			TargetPOS = GetEntityPosition(SummonList.get_Item(i));
			ActiveFxList.Add(PlayEffect(ActiveFx, 1f, 3.7, TargetPOS, default, 1.2f, actorScale: true));
		}
		yield return null;
	}

	protected IEnumerator Tag_Bunsin()
	{
		for (int i = 0; i < SummonList.Count; i++)
		{
			StopEffect(ControlFxList.get_Item(i));
			StopEffect(ControllineFxList.get_Item(i));
			StopEffect(ActiveFxList.get_Item(i));
			TargetPOS = GetEntityPosition(SummonList.get_Item(i));
			ClockFxList.Add(PlayEffect(ClockFx, 0.45f, default, TargetPOS, default, 1.5f, actorScale: true));
			SetLogicTagToggleValue(SummonList.get_Item(i), "release", value: true);
		}
		yield return null;
	}

	protected IEnumerator CircleAOE()
	{
		BeginAttack(NinjutsuIndex_Loop, NinjutsuKey_Loop, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.7);
		WarningFxIndex_Cir = PlayEffect(WarningFX_Cir, 1f, 0.3, GetPosition());
		yield return WaitTime(0.7);
		PlayEffect(BaseFX_Cir, 1f, default, GetPosition());
		yield return WaitTime(0.6);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		yield return WaitTime(0.6);
		PlayAreaEffect(Dot_Cir, GetPosition(), GetRotation());
		PlayEffect(DamageFx_Cir, 1f, default, GetPosition());
		StopEffect(WarningFxIndex_Cir);
		yield return WaitTime(0.2);
		yield return WaitTime(0.4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator RingAOE()
	{
		BeginAttack(NinjutsuIndex_Loop, NinjutsuKey_Loop, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.7);
		WarningFxIndex_Ring = PlayEffect(WarningFX_Ring, 1f, 0.3, GetPosition());
		yield return WaitTime(0.7);
		PlayEffect(BaseFX_Ring, 1f, default, GetPosition());
		yield return WaitTime(0.6);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		yield return WaitTime(0.6);
		PlayAreaEffect(Dot_Ring, GetPosition(), GetRotation());
		PlayEffect(DamageFx_Ring, 1f, default, GetPosition());
		StopEffect(WarningFxIndex_Ring);
		yield return WaitTime(0.2);
		yield return WaitTime(0.4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator DashOnce()
	{
		BeginLookAtByPos_NotWait(TargetPOS, 0.05, 9999);
		SelfPOS = GetPosition();
		Direction = TargetPOS - SelfPOS;
		DIST = Distance(TargetPOS, SelfPOS);
		Speed = DIST / 0.25;
		yield return WaitTime(0.08);
		BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		yield return WaitDashFinish();
		yield return WaitTime(0.15);
	}

	protected IEnumerator BackPOS()
	{
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		SetSearchedImmunityEnable();
		SetUnparalleledEnable();
		BeginAttack(JumpIndex, JumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Teleport(ZeroPOS);
		yield return WaitTime(0.8);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSearchedImmunityDisable();
		SetInvincibleDisable();
	}

	protected IEnumerator MultipleDash()
	{
		int i = 0;
		int num = 1;
		for (; i < 8; i++)
		{
			if (!Select)
			{
				if (num == 0)
				{
					DashPOS.Add(new TSVector2(GetRandomValue(-7, 7), 10));
					num++;
				}
				else
				{
					DashPOS.Add(new TSVector2(GetRandomValue(-7, 7), -10));
					num = 0;
					Select = true;
				}
			}
			else if (num == 0)
			{
				DashPOS.Add(new TSVector2(10, GetRandomValue(-7, 7)));
				num++;
			}
			else
			{
				DashPOS.Add(new TSVector2(-10, GetRandomValue(-7, 7)));
				num = 0;
				Select = false;
			}
		}
		BeginAttack(ActionIndex, ActionKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByPos_NotWait(new TSVector2(0, -5), 0.1, 9999);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (int j = 0; j < DashPOS.Count; j++)
		{
			if (j == 0)
			{
				LineFxList.Add(PlayLinkEffect(LineFx, useCustomSource: true, null, GetPosition(), 0.5, null, DashPOS.get_Item(0), 0.5, breakWhenLostSourceOrTarget: false, 1f, actorScale: true));
			}
			else
			{
				LineFxList.Add(PlayLinkEffect(LineFx, useCustomSource: true, null, DashPOS.get_Item(j - 1), 0.5, null, DashPOS.get_Item(j), 0.5, breakWhenLostSourceOrTarget: false, 1f, actorScale: true));
			}
		}
		yield return WaitTime(0.5);
		PlayEffect(WarningFx_Actor, 1f, 1.5, GetPosition(), default, 1.4f);
		yield return WaitTime(0.4);
		SetSearchedImmunityEnable();
		IndexFxDogde = PlayEffect(Fx_Dogde);
		for (int k = 0; k < DashPOS.Count; k++)
		{
			TargetPOS = DashPOS.get_Item(k);
			if (k == 0)
			{
				CancelAttack();
			}
			else
			{
				BeginAttack(DashLoopIndex, DashLoopKey, flushInputedKeys: true, forceInterruptAttack: true);
			}
			yield return StartCor(DashOnce());
		}
		StopEffect(IndexFxDogde);
		for (int l = 0; l < LineFxList.Count; l++)
		{
			StopEffect(LineFxList.get_Item(l));
		}
		SetSearchedImmunityDisable();
	}
}
