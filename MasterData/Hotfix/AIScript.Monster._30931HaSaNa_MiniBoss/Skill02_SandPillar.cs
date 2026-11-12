using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Skill02_SandPillar : SkillSimpleBase
{
	private static readonly string SandPillar = "SandPillar";

	private LogicEntity Targetenemy;

	private string Area_SandPillar;

	private DeterministicShape PillarShape;

	protected override void OnSkillEnable()
	{
		if (GetLogicTagStringValue(_actor, "SkillLv") == "SkillLv_1")
		{
			Area_SandPillar = "Area_SandPillar_2m";
		}
		else if (GetLogicTagStringValue(_actor, "SkillLv") == "SkillLv_2")
		{
			Area_SandPillar = "Area_SandPillar_2.5m";
		}
		else
		{
			Area_SandPillar = "Area_SandPillar_3m";
		}
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "Locked", value: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, SandPillar, flushInputedKeys: true, forceInterruptAttack: true);
		if (GetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "IsActive"))
		{
			SetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "Locked", value: true);
			PlayLinkFX("fx_30931JiGuanZhuangZhi_loop_charge_link", useCustomSource: true, GetTargetByTeammateIndex(1).get_Item(0).gameObject, TSVector.zero, 0, _actor.slotConfig.bodySlot.gameObject, TSVector.zero, 0);
		}
		yield return WaitCustomEvent("CallSandPillar");
		GetEnemy();
		if (GetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "IsActive"))
		{
			Skill02_SandPillar skill02_SandPillar = this;
			Skill02_SandPillar skill02_SandPillar2 = this;
			TSVector2 entityPosition = GetEntityPosition(Targetenemy);
			FP radius = 10;
			FP innerRadius = 9;
			skill02_SandPillar.PillarShape = skill02_SandPillar2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
			PlayAreaEffect(Area_SandPillar, GetEntityPosition(Targetenemy));
			PlayAreaEffect(Area_SandPillar, GetShapeRandomPoint(PillarShape, _actor, isReachable: true));
		}
		else
		{
			PlayAreaEffect(Area_SandPillar, GetEntityPosition(Targetenemy));
		}
		yield return WaitCustomEvent("End");
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
