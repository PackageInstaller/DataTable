using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_AsyncBunsin : SkillSimpleBase
{
	private bool IsNormalEnd;

	private static readonly TSVector2 ZeroPOS = new TSVector2(0, 0);

	private static readonly string FlashFx = "fx_70022_base_Kagebunsin_Flash";

	private static readonly string ControlFx = "fx_70022_bullet_Kagebunsin_Control";

	private static List<long> ControlFxList = new List<long>();

	private static readonly string ControllineFx = "fx_70022_loop_Kagebunsin_Control_line";

	private static List<long> ControllineFxList = new List<long>();

	private static readonly string ActiveFx = "fx_70022_loop_Kagebunsin_Active";

	private static List<long> ActiveFxList = new List<long>();

	private static TSVector2 SelfPOS;

	private static TSVector2 TargetPOS;

	private static readonly int JumpIndex = 0;

	private static readonly string JumpKey = "Jump";

	private static int NinjutsuIndex = 1;

	private static string NinjutsuKey = "Ninjutsu_G";

	private static int NinjutsuIndex_Loop = 2;

	private static string NinjutsuKey_Loop = "Nijutsu_Loop";

	private static List<TSVector2> SummonPOS = new List<TSVector2>();

	private static List<TSVector2> SummonPOS01 = new List<TSVector2>
	{
		new TSVector2(-8, 8),
		new TSVector2(8, 8),
		new TSVector2(8, -8),
		new TSVector2(-8, -8)
	};

	private static List<TSVector2> SummonPOS02 = new List<TSVector2>
	{
		new TSVector2(0, 10),
		new TSVector2(10, 0),
		new TSVector2(0, -10),
		new TSVector2(-10, 0)
	};

	private static int MonsterID = 1;

	private static List<LogicEntity> SummonList = new List<LogicEntity>();

	private static int numb;

	private static readonly string WarningFx_Actor = "fx_common_base_charge_fire_actor";

	private static long WarningFxIndex_Cir;

	private static readonly string WarningFX_Cir = "fx_70022_loop_warning_Skill01";

	private static readonly string BaseFX_Cir = "fx_70022_base_Skill01_Start";

	private static readonly string DamageFx_Cir = "fx_70022_atk_Skill01";

	private static readonly string Dot_Cir = "Master_Cir_atk";

	private static long WarningFxIndex_Ring;

	private static readonly string WarningFX_Ring = "fx_70022_loop_warning_Skill02";

	private static readonly string BaseFX_Ring = "fx_70022_base_Skill02_Start";

	private static readonly string DamageFx_Ring = "fx_70022_atk_Skill02";

	private static readonly string Dot_Ring = "Master_Ring_atk";

	private static long WarningFxIndex_Fan;

	private static readonly string WarningFX_Fan = "fx_70022_loop_warning_Skill03";

	private static readonly string BaseFX_Fan = "fx_70022_base_Skill03_Start";

	private static readonly string DamageFx_Fan = "fx_70022_atk_Skill03";

	private static readonly string Dot_Fan = "Fan_atk";

	protected override void OnSkillEnable()
	{
		SummonPOS.Clear();
		SummonList.Clear();
		ControlFxList.Clear();
		ControllineFxList.Clear();
		ActiveFxList.Clear();
		SetBlockPriorityToStatic();
	}

	protected override void OnSkillDisable()
	{
		SummonPOS.Clear();
		SummonList.Clear();
		ControlFxList.Clear();
		ControllineFxList.Clear();
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
		SetSearchedImmunityEnable();
		yield return StartCor(BackPOS());
		SetSearchedImmunityDisable();
		yield return StartCor(Summon());
		yield return StartCor(Control());
		yield return StartCor(Link());
		yield return StartCor(Attack_Master());
		yield return StartCor(Tag_Bunsin());
		IsNormalEnd = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Summon()
	{
		BeginAttack(NinjutsuIndex, NinjutsuKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		numb = (int)(long)GetRandomValue(0, 1.5, isInt: true);
		if (numb == 0)
		{
			SummonPOS.AddRange(SummonPOS01);
		}
		else
		{
			SummonPOS.AddRange(SummonPOS02);
		}
		for (int i = 0; i < 4; i++)
		{
			PlayEffect(FlashFx, 1f, default, SummonPOS.get_Item(i), default, 2.2f);
			SummonTeammate(MonsterID, SummonPOS.get_Item(i), new TSVector2(0, 0));
		}
		yield return WaitTime(0.2);
		SummonList.AddRange(GetTargetByTeammateIndex(MonsterID));
		for (int j = 0; j < SummonList.Count; j++)
		{
			SetLogicTagToggleValue(SummonList.get_Item(j), "AsyncRelease", value: false);
			SetLogicTagFpValue(SummonList.get_Item(j), "SkillWaitTime", j);
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

	protected IEnumerator Link()
	{
		for (int i = 0; i < SummonList.Count; i++)
		{
			TargetPOS = GetEntityPosition(SummonList.get_Item(i));
			ActiveFxList.Add(PlayEffect(ActiveFx, 1f, 3.7, TargetPOS, default, 1.2f, actorScale: true));
		}
		yield return null;
	}

	protected IEnumerator Attack_Master()
	{
		if ((int)(long)GetRandomValue(0, 1.5, isInt: true) == 0)
		{
			yield return StartCor(CircleAOE());
			for (int i = 0; i < SummonList.Count; i++)
			{
				SetLogicTagFpValue(SummonList.get_Item(i), "bunsinSkill", 0);
			}
		}
		else
		{
			yield return StartCor(RingAOE());
			for (int j = 0; j < SummonList.Count; j++)
			{
				SetLogicTagFpValue(SummonList.get_Item(j), "bunsinSkill", 1);
			}
		}
	}

	protected IEnumerator Tag_Bunsin()
	{
		for (int i = 0; i < SummonList.Count; i++)
		{
			StopEffect(ControlFxList.get_Item(i));
			StopEffect(ControllineFxList.get_Item(i));
			StopEffect(ActiveFxList.get_Item(i));
			TargetPOS = GetEntityPosition(SummonList.get_Item(i));
			SetLogicTagToggleValue(SummonList.get_Item(i), "AsyncRelease", value: true);
		}
		yield return null;
	}

	protected IEnumerator BackPOS()
	{
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		BeginAttack(JumpIndex, JumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Teleport(ZeroPOS);
		yield return WaitTime(0.5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator CircleAOE()
	{
		BeginAttack(NinjutsuIndex_Loop, NinjutsuKey_Loop, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.7);
		WarningFxIndex_Cir = PlayEffect(WarningFX_Cir, 1f, 0.3, GetPosition());
		yield return WaitTime(1.3);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		PlayEffect(BaseFX_Cir, 1f, default, GetPosition());
		yield return WaitTime(0.5);
		PlayAreaEffect(Dot_Cir, GetPosition(), GetRotation());
		PlayEffect(DamageFx_Cir, 1f, default, GetPosition());
		yield return WaitTime(0.2);
		StopEffect(WarningFxIndex_Cir);
		yield return WaitTime(0.4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator RingAOE()
	{
		BeginAttack(NinjutsuIndex_Loop, NinjutsuKey_Loop, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.7);
		WarningFxIndex_Ring = PlayEffect(WarningFX_Ring, 1f, 0.3, GetPosition());
		yield return WaitTime(1.3);
		PlayEffect(BaseFX_Ring, 1f, default, GetPosition());
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		yield return WaitTime(0.5);
		PlayAreaEffect(Dot_Ring, GetPosition(), GetRotation());
		PlayEffect(DamageFx_Ring, 1f, default, GetPosition());
		yield return WaitTime(0.2);
		StopEffect(WarningFxIndex_Ring);
		yield return WaitTime(0.4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
