using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Skill05_SwordDance : SkillSimpleBase
{
	private readonly string combo_key1 = "CastSpell";

	private readonly string combo_key2 = "FinishRush";

	private readonly string combo_key3 = "RushAttack";

	private readonly string combo_key4 = "FinishRushWait";

	private readonly string combo_key5 = "FinishRushAgain";

	private readonly string combo_key6 = "FinishSkill";

	private readonly string combo_key7 = "FinishSkillEnd";

	private long RushWarningFX;

	private long FinishFX;

	private long FinishRushFX;

	private long AreaEffectID;

	private long DamageAreaEffectID;

	private List<long> fxList = new List<long>();

	private TSVector2 AreaEffectIDPosition;

	private TSVector2 DamageAreaEffectIDPosition;

	private bool _isChecking = true;

	private CoroutineNode DistanceCor;

	private FP RushDistance;

	private long HolyLightMark;

	private TSVector2 SkillPos;

	private LogicEntity Targetenemy;

	protected override void OnSkillEnable()
	{
		SkillPos = GetPlaceHolderPosition("CenterPoint");
	}

	protected override void OnSkillDisable()
	{
		StopCor(DistanceCor);
		_isChecking = false;
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
		GetEnemy();
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 0.1, 7200);
		yield return WaitTime(1.4);
		AddBuffToTarget(_actor, 311010000);
		yield return WaitTime(0.1);
		HolyLightMark = PlayEffect("fx_m31101_loop_Skill01_ground", 1f, 0, SkillPos, 0, 1.85f);
		fxList.Add(HolyLightMark);
		yield return WaitTime(0.5);
		if (GetBuffNum(_actor, 311010010) >= 1)
		{
			StartCor(DogHunt());
		}
		yield return WaitTime(0.5);
		BeginAttack(2, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		_isChecking = true;
		BeginLookAt_NotWait(Targetenemy, 0.4, 720);
		yield return WaitTime(0.43);
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		TSVector2 position = GetPosition();
		RushDistance = Distance(position, entityPosition);
		yield return WaitTime(0.4);
		Dash();
		DistanceCor = StartCor(StartCheckLoop());
		yield return WaitDashFinish();
		StopCor(DistanceCor);
		if (GetBuffNum(_actor, 311010010) < 1)
		{
			StartCor(DogHunt());
		}
		_isChecking = false;
		BeginAttack(8, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.33);
		GetEnemy();
		BeginAttack(3, combo_key4, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 0.8, 7200);
		yield return WaitTime(0.2);
		if (GetBuffNum(_actor, 311010010) >= 1)
		{
			StartCor(DogHunt());
		}
		yield return WaitTime(0.7);
		_isChecking = true;
		TSVector2 entityPosition2 = GetEntityPosition(GetCurrentPlayer());
		TSVector2 position2 = GetPosition();
		RushDistance = Distance(position2, entityPosition2);
		if (GetBuffNum(_actor, 311010010) >= 1)
		{
			Skill05_SwordDance skill05_SwordDance = this;
			Skill05_SwordDance skill05_SwordDance2 = this;
			TSVector2 position3 = GetPosition();
			FP rotation = GetRotation();
			skill05_SwordDance.RushWarningFX = skill05_SwordDance2.PlayEarlyWarningEffect("fx_warning_dash_3x23", 0.5f, default, position3, rotation, 1.2f);
			fxList.Add(RushWarningFX);
			yield return WaitTime(0.4);
		}
		else
		{
			Skill05_SwordDance skill05_SwordDance3 = this;
			Skill05_SwordDance skill05_SwordDance4 = this;
			TSVector2 position3 = GetPosition();
			FP rotation = GetRotation();
			skill05_SwordDance3.RushWarningFX = skill05_SwordDance4.PlayEarlyWarningEffect("fx_warning_dash_3x23", 1.05f, default, position3, rotation, 1.2f);
			fxList.Add(RushWarningFX);
			yield return WaitTime(1.1);
		}
		BeginAttack(4, combo_key5, flushInputedKeys: true, forceInterruptAttack: true);
		Dash();
		DistanceCor = StartCor(StartCheckLoop());
		yield return WaitDashFinish();
		StopCor(DistanceCor);
		if (GetBuffNum(_actor, 311010010) < 1)
		{
			StartCor(DogHunt());
		}
		_isChecking = false;
		BeginAttack(8, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.23);
		GetEnemy();
		BeginAttack(6, combo_key4, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 0.8, 7200);
		yield return WaitTime(0.2);
		if (GetBuffNum(_actor, 311010010) >= 1)
		{
			StartCor(DogHunt());
		}
		yield return WaitTime(0.7);
		_isChecking = true;
		TSVector2 entityPosition3 = GetEntityPosition(GetCurrentPlayer());
		TSVector2 position4 = GetPosition();
		RushDistance = Distance(position4, entityPosition3);
		if (GetBuffNum(_actor, 311010010) >= 1)
		{
			Skill05_SwordDance skill05_SwordDance5 = this;
			Skill05_SwordDance skill05_SwordDance6 = this;
			TSVector2 position3 = GetPosition();
			FP rotation = GetRotation();
			skill05_SwordDance5.RushWarningFX = skill05_SwordDance6.PlayEarlyWarningEffect("fx_warning_dash_3x23", 0.5f, default, position3, rotation, 1.2f);
			fxList.Add(RushWarningFX);
			yield return WaitTime(0.4);
		}
		else
		{
			Skill05_SwordDance skill05_SwordDance7 = this;
			Skill05_SwordDance skill05_SwordDance8 = this;
			TSVector2 position3 = GetPosition();
			FP rotation = GetRotation();
			skill05_SwordDance7.RushWarningFX = skill05_SwordDance8.PlayEarlyWarningEffect("fx_warning_dash_3x23", 1.05f, default, position3, rotation, 1.2f);
			fxList.Add(RushWarningFX);
			yield return WaitTime(1.1);
		}
		BeginAttack(7, combo_key5, flushInputedKeys: true, forceInterruptAttack: true);
		Dash();
		DistanceCor = StartCor(StartCheckLoop());
		yield return WaitDashFinish();
		StopCor(DistanceCor);
		if (GetBuffNum(_actor, 311010010) < 1)
		{
			StartCor(DogHunt());
		}
		_isChecking = false;
		BeginAttack(8, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.23);
		GetEnemy();
		BeginAttack(9, combo_key4, flushInputedKeys: true, forceInterruptAttack: true);
		if (GetBuffNum(_actor, 311010010) >= 1)
		{
			BeginLookAt_NotWait(Targetenemy, 1.9, 7200);
			yield return WaitTime(1.2);
		}
		else
		{
			BeginLookAt_NotWait(Targetenemy, 2.3, 7200);
			yield return WaitTime(1.6);
		}
		AreaEffectID = PlayAreaEffect("Area_31101_GeLeiHuoEn_Warning", GetEntityPosition(GetCurrentPlayer()));
		fxList.Add(AreaEffectID);
		yield return WaitTime(0.7);
		AreaEffectIDPosition = GetAreaEffectPosition(AreaEffectID);
		DamageAreaEffectID = PlayAreaEffect("Area_31101_GeLeiHuoEn_Warning_End", AreaEffectIDPosition);
		fxList.Add(DamageAreaEffectID);
		StopAreaEffect(AreaEffectID);
		yield return WaitTime(0.5);
		BeginAttack(10, combo_key6, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.1);
		DamageAreaEffectIDPosition = GetAreaEffectPosition(DamageAreaEffectID);
		SetHideModelEnable();
		SetUnparalleledEnable();
		Dash3();
		yield return WaitTime(1.65);
		FinishRushFX = PlayEffect("fx_m31101_base_Attack_3_End_actoractive", 1f, 0, SkillPos, 0);
		fxList.Add(FinishRushFX);
		yield return WaitTime(0.1);
		BeginAttack(11, combo_key7, flushInputedKeys: true, forceInterruptAttack: true);
		Dash1();
		SetHideModelDisable();
		SetUnparalleledDisable();
		yield return WaitTime(0.4);
		StopAreaEffect(DamageAreaEffectID);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator StartCheckLoop()
	{
		while (_isChecking)
		{
			yield return null;
			TSVector2 position = GetPosition();
			TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
			if (Distance(position, entityPosition) <= 1.6)
			{
				StopDash();
				_isChecking = false;
			}
		}
	}

	protected IEnumerator DogHunt()
	{
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		TSVector2 normalized = (SkillPos - entityPosition).normalized;
		TSVector2 tSVector = new TSVector2(-normalized.y, normalized.x);
		TSVector2 spawnPosition = SkillPos + tSVector * 0 + normalized * 3;
		SummonTeammate(1, spawnPosition, -normalized);
		yield return WaitTime(0.1);
	}

	private void Dash()
	{
		BeginDashActorForward(1, 50, RushDistance, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Dash1()
	{
		TSVector2 position = GetPosition();
		FP fP = Distance(position, DamageAreaEffectIDPosition);
		FP speed = (fP + 2) / 0.05;
		BeginDashActorForward(2, speed, fP + 3, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
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

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
