#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_Illusion : SkillSimpleBase
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

	private static List<TSVector2> SummonPOS = new List<TSVector2>();

	private static int MonsterID01 = 2;

	private static int MonsterID02 = 3;

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

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("A技能开始");
		AttackHintHide();
	}

	protected override void OnSkillDisable()
	{
		AttackHintShow();
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
		}
		NovaLogger.Debug("A技能结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		SetLogicTagToggleValue(_actor, "SkillTag_Illusion", value: true);
		SetSearchedImmunityEnable();
		SetUnparalleledEnable();
		yield return StartCor(BackPOS());
		SetSearchedImmunityDisable();
		SetInvincibleDisable();
		yield return StartCor(Summon());
		yield return WaitTime(0.7);
		ScreenIndex = PlayEffect(ScreenFx);
		yield return WaitTime(0.3);
		SetUnparalleledEnable();
		yield return StartCor(GotoPOS());
		Check = StartCor(CheckTarget());
		yield return WaitTime(HideDuration);
		StopCor(Check);
		SetHideModelDisable();
		SetHideOutDisable();
		for (int i = 0; i < SummonList.Count; i++)
		{
			SetLogicTagToggleValue(SummonList.get_Item(i), "Attack", value: true);
		}
		yield return WaitTime(1.5);
		yield return StartCor(Attack());
		yield return WaitTime(1);
		StopEffect(ScreenIndex);
		yield return WaitTime(0.7);
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
		SummonTeammate(MonsterID01, SummonPOS01.get_Item(0), GetForward());
		PlayEffect(FlashFx, 1f, default, SummonPOS01.get_Item(1), default, 2.2f);
		SummonTeammate(MonsterID02, SummonPOS01.get_Item(1), GetForward());
		yield return WaitTime(0.1);
		SummonList.AddRange(GetTargetByTeammateIndex(MonsterID01));
		SummonList.AddRange(GetTargetByTeammateIndex(MonsterID02));
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
		switch (numb)
		{
		case 0:
		{
			TargetPOS = SummonPOS02.get_Item(numb);
			for (int m = 0; m < SummonList.Count; m++)
			{
				SetLogicTagFpValue(SummonList.get_Item(m), "Dnumb", 0);
			}
			break;
		}
		case 1:
		{
			TargetPOS = SummonPOS02.get_Item(numb);
			for (int k = 0; k < SummonList.Count; k++)
			{
				SetLogicTagFpValue(SummonList.get_Item(k), "Dnumb", 1);
			}
			break;
		}
		case 2:
		{
			TargetPOS = SummonPOS02.get_Item(numb);
			for (int l = 0; l < SummonList.Count; l++)
			{
				SetLogicTagFpValue(SummonList.get_Item(l), "Dnumb", 2);
			}
			break;
		}
		case 3:
		{
			TargetPOS = SummonPOS02.get_Item(numb);
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
		AtkFxIndex = PlayEffect(AtkFx, 1f, default, new TSVector2(0, 0), GetTSVectToAngle(new TSVector2(0, 0) - GetPosition(), 0));
		SelfPOS = GetPosition();
		POS_Fan = SelfPOS;
		POS_Rectangle = TransLocalPosToWorldPos(SelfPOS, GetForward(), new TSVector2(0, 12.5));
		HitData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 4);
		Rotation_Rectangle = GetRotation();
		DamageShape_Rectangle = GetShapeData(DeterministicShape.ShapeType.Rectangle, POS_Rectangle, Width_Rectangle, Length_Rectangle, default, default, default, Rotation_Rectangle);
		Rotation_Fan = GetRotation();
		DamageShape_Fan = GetShapeData(DeterministicShape.ShapeType.Fan, POS_Fan, default, default, Radius_Fan, InnerRadius_Fan, Angle_Fan, Rotation_Fan);
		for (int i = 0; i < 3; i++)
		{
			AreaHit_Simple(_actor, DamageShape_Fan, HitData, 70022007, 0.5, HitBox.HurtAnimType.Small, "fx_70022_hit_Acition");
			AreaHit_Simple(_actor, DamageShape_Rectangle, HitData, 70022007, 0.5, HitBox.HurtAnimType.Small, "fx_70022_hit_Acition");
			yield return WaitTime(0.5);
		}
		StopEffect(AtkFxIndex);
	}
}
