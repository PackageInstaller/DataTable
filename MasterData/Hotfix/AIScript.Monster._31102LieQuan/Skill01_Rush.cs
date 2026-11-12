using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31102LieQuan;

public class Skill01_Rush : SkillSimpleBase
{
	private readonly string combo_key1 = "Rush";

	private readonly string combo_key2 = "Rush_AttackStartLeft";

	private readonly string combo_key3 = "Rush_AttackStartRight";

	private readonly string combo_key4 = "Rush_AttackStartLeftEX";

	private readonly string combo_key5 = "Rush_AttackStartRightEX";

	private CoroutineNode DistanceAttackCor;

	private long ZhenChaFX;

	private long ShanShuoFX;

	private long GanTanHaoFX;

	private long SuoDingFX;

	private bool _isChecking = true;

	private long AreaEffectID;

	private long DamageAreaEffectID;

	private TSVector2 AreaEffectIDPosition;

	private int _checkTimer;

	private bool _hasPlayedA;

	private bool _wasInRange;

	private bool _hasPlayedEnterEffect;

	private List<long> fxList = new List<long>();

	private LogicEntity Targetenemy;

	protected override void OnSkillEnable()
	{
		_isChecking = true;
	}

	protected override void OnSkillDisable()
	{
		StopCor(DistanceAttackCor);
		_isChecking = false;
		if (fxList != null && fxList.Count > 0)
		{
			for (int i = 0; i < fxList.Count; i++)
			{
				StopEffect(fxList.get_Item(i));
			}
		}
	}

	protected override void DashFinishByObstacle(int index)
	{
		StartCor(Rushend());
	}

	protected IEnumerator Rushend()
	{
		CancelAttack();
		StopEffect(ShanShuoFX);
		StopEffect(GanTanHaoFX);
		StopEffect(ZhenChaFX);
		StopCor(DistanceAttackCor);
		yield return WaitTime(1.2);
		ClearActors(new List<LogicEntity> { _actor });
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.8, 72000);
		yield return WaitTime(0.9);
		ZhenChaFX = PlayEffect("fx_m31102_loop_Attack_2_zhencha", 1f, 0, GetPosition(), 0);
		fxList.Add(ZhenChaFX);
		DistanceAttackCor = StartCor(StartCheckLoop());
		Dash();
		yield return WaitTime(9);
		ClearActors(new List<LogicEntity> { _actor });
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator StartCheckLoop()
	{
		_checkTimer = 0;
		_hasPlayedA = false;
		_wasInRange = false;
		_hasPlayedEnterEffect = false;
		while (_isChecking)
		{
			yield return null;
			TSVector2 position = GetPosition();
			TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
			if (Distance(position, entityPosition) <= 4.1)
			{
				if (!_wasInRange)
				{
					if (!_hasPlayedEnterEffect)
					{
						ShanShuoFX = PlayEffect("fx_m31102_loop_Attack_2_shanshuo", 1f, 0, GetPosition(), 0);
						GanTanHaoFX = PlayEffect("fx_m31102_loop_Attack_2_gantanhao", 1f, 1.6, GetPosition(), 0);
						fxList.Add(ShanShuoFX);
						fxList.Add(GanTanHaoFX);
						_hasPlayedEnterEffect = true;
					}
					_checkTimer = 0;
					_hasPlayedA = false;
					_wasInRange = true;
				}
				_checkTimer++;
				if (_checkTimer < 12 || _hasPlayedA)
				{
					continue;
				}
				_hasPlayedA = true;
				_isChecking = false;
				StopDash();
				StopEffect(ShanShuoFX);
				StopEffect(GanTanHaoFX);
				StopEffect(ZhenChaFX);
				SuoDingFX = PlayEffect("fx_m31102_base_Attack_2_end", 1f, 0, GetPosition(), 0);
				fxList.Add(SuoDingFX);
				List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(0);
				LogicEntity logicEntity = ((targetByTeammateIndex != null && targetByTeammateIndex.Count > 0) ? targetByTeammateIndex.get_Item(0) : null);
				if (logicEntity != null && GetBuffNum(logicEntity, 311010000) >= 1)
				{
					if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 180)
					{
						BeginAttack(3, combo_key5, flushInputedKeys: true, forceInterruptAttack: true);
						Dash1();
						GetEnemy1();
						BeginLookAt_NotWait(Targetenemy, 0.6, 720);
						AreaEffectID = PlayAreaEffect("Area_31102_LieQuan_Warning_EX", GetEntityPosition(GetCurrentPlayer()));
						yield return WaitDashFinish();
						CancelAttack();
						yield return WaitTime(0.15);
						SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
						Dash3();
						yield return WaitTime(0.8);
						DispatchCustomEvent("OnCustomEvt", isSelfEvent: false);
						ClearActors(new List<LogicEntity> { _actor });
					}
					else
					{
						BeginAttack(2, combo_key4, flushInputedKeys: true, forceInterruptAttack: true);
						Dash1();
						GetEnemy1();
						BeginLookAt_NotWait(Targetenemy, 0.6, 720);
						AreaEffectID = PlayAreaEffect("Area_31102_LieQuan_Warning_EX", GetEntityPosition(GetCurrentPlayer()));
						yield return WaitDashFinish();
						CancelAttack();
						yield return WaitTime(0.15);
						SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
						Dash3();
						yield return WaitTime(0.8);
						DispatchCustomEvent("OnCustomEvt", isSelfEvent: false);
						ClearActors(new List<LogicEntity> { _actor });
					}
				}
				else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 180)
				{
					BeginAttack(3, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
					Dash1();
					GetEnemy1();
					BeginLookAt_NotWait(Targetenemy, 0.6, 720);
					AreaEffectID = PlayAreaEffect("Area_31102_LieQuan_Warning", GetEntityPosition(GetCurrentPlayer()));
					yield return WaitDashFinish();
					CancelAttack();
					yield return WaitTime(0.15);
					SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
					Dash2();
					yield return WaitTime(0.8);
					DispatchCustomEvent("OnCustomEvt", isSelfEvent: false);
					ClearActors(new List<LogicEntity> { _actor });
				}
				else
				{
					BeginAttack(2, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
					Dash1();
					GetEnemy1();
					BeginLookAt_NotWait(Targetenemy, 0.6, 720);
					AreaEffectID = PlayAreaEffect("Area_31102_LieQuan_Warning", GetEntityPosition(GetCurrentPlayer()));
					yield return WaitDashFinish();
					CancelAttack();
					yield return WaitTime(0.15);
					SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
					Dash2();
					yield return WaitTime(0.8);
					DispatchCustomEvent("OnCustomEvt", isSelfEvent: false);
					ClearActors(new List<LogicEntity> { _actor });
				}
			}
			else if (_wasInRange)
			{
				if (_checkTimer < 12 && !_hasPlayedA)
				{
					StopEffect(ShanShuoFX);
					StopEffect(GanTanHaoFX);
				}
				_wasInRange = false;
				_hasPlayedEnterEffect = false;
			}
		}
		_checkTimer = 0;
		_hasPlayedA = false;
		_wasInRange = false;
		_hasPlayedEnterEffect = false;
	}

	private void Dash()
	{
		BeginDashActorForward(1, 12, 30, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Dash1()
	{
		BeginDash(2, GetForward(), 8, 4, 30, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.6);
	}

	private void Dash2()
	{
		TSVector2 position = GetPosition();
		AreaEffectIDPosition = GetAreaEffectPosition(AreaEffectID);
		DamageAreaEffectID = PlayAreaEffect("Area_31102_LieQuan_Warning_End", AreaEffectIDPosition);
		FP fP = Distance(position, AreaEffectIDPosition);
		FP speed = (fP - 4) / 0.4;
		AimAtPosition(AreaEffectIDPosition, 7200);
		StopAreaEffect(AreaEffectID);
		BeginDashActorForward(3, speed, fP - 4, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void Dash3()
	{
		TSVector2 position = GetPosition();
		AreaEffectIDPosition = GetAreaEffectPosition(AreaEffectID);
		DamageAreaEffectID = PlayAreaEffect("Area_31102_LieQuan_Warning_End_EX", AreaEffectIDPosition);
		FP fP = Distance(position, AreaEffectIDPosition);
		FP speed = (fP - 4) / 0.4;
		AimAtPosition(AreaEffectIDPosition, 7200);
		StopAreaEffect(AreaEffectID);
		BeginDashActorForward(4, speed, fP - 4, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void GetEnemy1()
	{
		Targetenemy = GetCurrentPlayer();
	}
}
