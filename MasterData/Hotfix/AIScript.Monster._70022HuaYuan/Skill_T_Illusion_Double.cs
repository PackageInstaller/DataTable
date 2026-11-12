using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_Illusion_Double : SkillSimpleBase
{
	private bool IsNormalEnd;

	private static long ScreenIndex;

	private static string ScreenFx = "fx_70022_loop_Skill04_screen";

	private static readonly TSVector2 ZeroPOS = new TSVector2(0, 0);

	private static readonly string FlashFx = "fx_70022_base_Kagebunsin_Flash";

	private static int NinjutsuIndex = 0;

	private static string NinjutsuKey = "Ninjutsu_G";

	private static readonly int JumpIndex = 1;

	private static readonly string JumpKey = "Jump";

	private static TSVector2 SummonPOS;

	private static int MonsterID = 4;

	private static List<LogicEntity> SummonList = new List<LogicEntity>();

	private static TSVector2 TargetPOS;

	private static List<TSVector2> SummonPOS02 = new List<TSVector2>
	{
		new TSVector2(0, 10),
		new TSVector2(10, 0),
		new TSVector2(0, -10),
		new TSVector2(-10, 0)
	};

	private static List<TSVector2> SummonPOS01 = new List<TSVector2>
	{
		new TSVector2(-3, 0),
		new TSVector2(3, 0)
	};

	private static int numb;

	private static LogicEntity Target;

	private static TSVector2 SelfPOS;

	private static FP DIST;

	private static bool StateSwitch;

	private static FP CheckINTR = 0.2;

	private static CoroutineNode Check;

	private static FP HideDuration = 6;

	private static DeterministicShape DamageShape_Fan;

	private static DeterministicShape DamageShape_Rectangle;

	private static TSVector2 POS_Fan;

	private static TSVector2 POS_Rectangle;

	private static FP Width_Rectangle = 22;

	private static FP Length_Rectangle = 17;

	private static FP Radius_Fan = 6;

	private static FP InnerRadius_Fan = 0;

	private static FP Angle_Fan = 90;

	private static FP Rotation_Fan = default;

	private static FP Rotation_Rectangle = default;

	private static HitFeatureData HitData;

	private static HitFeatureData HitfeatureData;

	private static FP HitSrenth = 4;

	private static int hitDamegeID = 70022001;

	private static FP damageimmuneDuration = 0;

	private static string hittedEffect = "fx_70022_hit_Acition";

	private static readonly string AtkFx = "fx_70022_loop_Skill04";

	private static long AtkFxIndex;

	private static bool MoveSwitch;

	private static readonly string WarningFx_Actor = "fx_common_base_charge_fire_actor";

	private static long WarningFxIndex_Fan01;

	private static long WarningFxIndex_Fan02;

	private static readonly string WarningFX_Fan = "fx_70022_loop_warning_Skill03";

	private static readonly string BaseFX_Fan = "fx_70022_base_Skill03_Start";

	private static readonly string DamageFx_Fan = "fx_70022_atk_Skill03";

	private static readonly string Dot_Fan = "Fan_atk";

	protected override void OnSkillEnable()
	{
		AttackHintHide();
	}

	protected override void OnSkillDisable()
	{
		AttackHintShow();
		if (IsNormalEnd)
		{
			return;
		}
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		if (targetsByFaction.Count > 0)
		{
			ClearActors(targetsByFaction);
			for (int i = 0; i < targetsByFaction.Count; i++)
			{
				PlayEffect(FlashFx, 1f, default, GetEntityPosition(targetsByFaction.get_Item(i)), default, 2.2f);
			}
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_Illusion"))
		{
			yield return null;
			InterruptSkill();
			yield return null;
		}
		SetSearchedImmunityEnable();
		SetUnparalleledEnable();
		yield return StartCor(BackPOS());
		SetSearchedImmunityDisable();
		SetInvincibleDisable();
		yield return StartCor(Summon());
		yield return WaitTime(0.7);
		ScreenIndex = PlayEffect(ScreenFx);
		yield return WaitTime(0.3);
		SetSearchedImmunityEnable();
		SetUnparalleledEnable();
		yield return StartCor(GotoPOS());
		Check = StartCor(CheckTarget());
		yield return WaitTime(HideDuration);
		StopCor(Check);
		SetHideModelDisable();
		SetHideOutDisable();
		SummonPOS = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 20));
		PlayEffect(FlashFx, 1f, default, GetPosition(), default, 2.2f);
		PlayEffect(FlashFx, 1f, default, SummonPOS, default, 2.2f);
		for (int i = 0; i < SummonList.Count; i++)
		{
			SetLogicTagToggleValue(SummonList.get_Item(i), "Attack", value: true);
		}
		yield return StartCor(Attack());
		yield return WaitTime(1);
		StopEffect(ScreenIndex);
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		IsNormalEnd = true;
	}

	protected IEnumerator BackPOS()
	{
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		BeginAttack(JumpIndex, JumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Teleport(ZeroPOS);
		BeginLookAtByPos_NotWait(new TSVector2(0, -10), 0.2, 999);
		yield return WaitTime(0.5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Summon()
	{
		BeginAttack(NinjutsuIndex, NinjutsuKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect(FlashFx, 1f, default, SummonPOS01.get_Item(0), default, 2.2f);
		SummonTeammate(MonsterID, SummonPOS01.get_Item(0), GetForward());
		yield return WaitTime(0.1);
		SummonList.AddRange(GetTargetByTeammateIndex(MonsterID));
	}

	protected IEnumerator GotoPOS()
	{
		for (int i = 0; i < SummonList.Count; i++)
		{
			SetLogicTagToggleValue(SummonList.get_Item(i), "MoveSwitch", value: true);
		}
		PlayEffect(FlashFx, 1f, default, GetPosition(), default, 2.2f);
		yield return WaitTime(0.1);
		numb = (int)(long)GetRandomValue(0, 3.5, isInt: true);
		TargetPOS = SummonPOS02.get_Item(numb);
		switch (numb)
		{
		case 0:
		{
			for (int m = 0; m < SummonList.Count; m++)
			{
				SetLogicTagFpValue(SummonList.get_Item(m), "Dnumb", 0);
			}
			break;
		}
		case 1:
		{
			for (int k = 0; k < SummonList.Count; k++)
			{
				SetLogicTagFpValue(SummonList.get_Item(k), "Dnumb", 1);
			}
			break;
		}
		case 2:
		{
			for (int l = 0; l < SummonList.Count; l++)
			{
				SetLogicTagFpValue(SummonList.get_Item(l), "Dnumb", 2);
			}
			break;
		}
		case 3:
		{
			for (int j = 0; j < SummonList.Count; j++)
			{
				SetLogicTagFpValue(SummonList.get_Item(j), "Dnumb", 3);
			}
			break;
		}
		}
		Teleport(TargetPOS);
		SetHideModelEnable();
		SetHideOutEnable();
		BeginLookAtByPos_NotWait(ZeroPOS, 0.3, 999);
		yield return WaitTime(2);
	}

	protected IEnumerator CheckTarget()
	{
		Target = GetCurrentPlayer();
		SelfPOS = GetPosition();
		StateSwitch = true;
		for (int i = 0; i < HideDuration / CheckINTR; i++)
		{
			TargetPOS = GetEntityPosition(Target);
			DIST = Distance(SelfPOS, TargetPOS);
			if (DIST <= 3.5 && StateSwitch)
			{
				SetHideModelDisable();
				SetHideOutDisable();
				StateSwitch = false;
			}
			else if (DIST > 3.5 && !StateSwitch)
			{
				SetHideOutEnable();
				yield return WaitTime(0.3);
				SetHideModelEnable();
				StateSwitch = true;
			}
			yield return WaitTime(CheckINTR);
		}
		yield return null;
	}

	protected IEnumerator Attack()
	{
		yield return WaitTime(0.6);
		WarningFxIndex_Fan01 = PlayEffect(WarningFX_Fan, 1f, 0.3, GetPosition(), GetRotation());
		WarningFxIndex_Fan02 = PlayEffect(WarningFX_Fan, 1f, 0.3, SummonPOS, GetTSVectToAngle(GetForward(), 180));
		yield return WaitTime(1.48);
		PlayAreaEffect(Dot_Fan, GetPosition(), GetRotation());
		PlayAreaEffect(Dot_Fan, SummonPOS, GetTSVectToAngle(GetForward(), 180));
		PlayEffect(DamageFx_Fan, 1f, default, GetPosition(), GetRotation());
		PlayEffect(DamageFx_Fan, 1f, default, SummonPOS, GetTSVectToAngle(GetForward(), 180));
		StopEffect(WarningFxIndex_Fan01);
		StopEffect(WarningFxIndex_Fan02);
	}
}
