using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Skill07_Shadow_Small : SkillSimpleBase
{
	private readonly string combo_key1 = "Maline_9_3_1";

	private readonly string combo_key2 = "FinishSkill";

	private readonly string combo_key3 = "FinishSkillEnd";

	private readonly string combo_key4 = "FinishRushWait";

	private LogicEntity Targetenemy;

	private long DamageAreaEffectID;

	private TSVector2 DamageAreaEffectIDPosition;

	private TSVector2 AreaEffectIDPosition;

	private long FinishRushFX;

	private List<long> fxList = new List<long>();

	private long AreaEffectID;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		SetHideModelDisable();
		SetUnparalleledDisable();
		if (fxList != null && fxList.Count > 0)
		{
			for (int i = 0; i < fxList.Count; i++)
			{
				StopEffect(fxList.get_Item(i));
			}
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 centerPos1 = new TSVector2(0, 11.5);
		TSVector2 centerPos2 = RotateTo(centerPos1, 120);
		TSVector2 centerPos3 = RotateTo(centerPos2, 120);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.1, 7200);
		yield return WaitTime(0.1);
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.5);
		SummonTeammate(3, centerPos1, new TSVector2(0, 0) - centerPos1);
		SummonTeammate(3, centerPos2, new TSVector2(0, 0) - centerPos2);
		SummonTeammate(3, centerPos3, new TSVector2(0, 0) - centerPos3);
		yield return WaitTime(0.8);
		GetEnemy();
		BeginAttack(2, combo_key4, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 3.2, 7200);
		yield return WaitTime(2.5);
		AreaEffectID = PlayAreaEffect("Area_31101_GeLeiHuoEn_Warning", GetEntityPosition(GetCurrentPlayer()));
		fxList.Add(AreaEffectID);
		yield return WaitTime(0.7);
		AreaEffectIDPosition = GetAreaEffectPosition(AreaEffectID);
		DamageAreaEffectID = PlayAreaEffect("Area_31101_GeLeiHuoEn_Warning_End", AreaEffectIDPosition);
		fxList.Add(DamageAreaEffectID);
		StopAreaEffect(AreaEffectID);
		yield return WaitTime(0.5);
		BeginAttack(3, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.1);
		DamageAreaEffectIDPosition = GetAreaEffectPosition(DamageAreaEffectID);
		SetHideModelEnable();
		SetUnparalleledEnable();
		Dash3();
		yield return WaitTime(1.65);
		FinishRushFX = PlayEffect("fx_m31101_base_Attack_3_End_actoractive", 1f, 0, GetPosition(), 0);
		fxList.Add(FinishRushFX);
		yield return WaitTime(0.1);
		BeginAttack(4, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
		Dash1();
		SetHideModelDisable();
		SetUnparalleledDisable();
		yield return WaitTime(0.4);
		StopAreaEffect(DamageAreaEffectID);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Dash3()
	{
		TSVector2 position = GetPosition();
		FP fP = Distance(position, DamageAreaEffectIDPosition);
		if (fP > 6)
		{
			BeginDashActorForward(3, 300, fP - 4, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 1.2);
		}
	}

	private void Dash1()
	{
		TSVector2 position = GetPosition();
		FP fP = Distance(position, DamageAreaEffectIDPosition);
		FP speed = (fP + 2) / 0.05;
		BeginDashActorForward(2, speed, fP + 3, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
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
