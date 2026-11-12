using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31102LieQuan;

public class Skill02_Patrol_Small : SkillSimpleBase
{
	private readonly string combo_key1 = "Attack";

	private readonly string combo_key2 = "EXAttack";

	private readonly string combo_key3 = "Run";

	private CoroutineNode DistanceAttackCor;

	private long ZhenChaFX;

	private long ShanShuoFX;

	private long GanTanHaoFX;

	private long SuoDingFX;

	private long DieFX;

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

	protected readonly FP dash_spd = 6.397f;

	protected readonly FP dash_angle = -70;

	protected readonly FP dash_angleLimit = 80;

	protected FP dis;

	private TSVector2 SkillPos;

	protected override void OnInterrupt(int comboIndex)
	{
	}

	protected override void OnSkillEnable()
	{
		_isChecking = true;
		SkillPos = GetPlaceHolderPosition("CenterPoint");
	}

	protected override void OnSkillDisable()
	{
		StopCor(DistanceAttackCor);
		_isChecking = false;
		StopAreaEffect(AreaEffectID);
		StopAreaEffect(DamageAreaEffectID);
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
		yield return WaitTime(0.4);
		BeginAttack(3, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
		ZhenChaFX = PlayEffect("fx_m31102_loop_Attack_2_zhencha", 1f, 0, GetPosition(), 0);
		fxList.Add(ZhenChaFX);
		DistanceAttackCor = StartCor(StartCheckLoop());
		dis = 300000f;
		doDash(dis);
		BeginLookAtByPos(SkillPos, 9999, dash_angle);
		yield return WaitTime(10);
		if (!_isChecking)
		{
			yield return WaitTime(4);
		}
		StopCor(DistanceAttackCor);
		if (fxList != null && fxList.Count > 0)
		{
			for (int i = 0; i < fxList.Count; i++)
			{
				StopEffect(fxList.get_Item(i));
			}
		}
		DieFX = PlayEffect("fx_m31102_base_die", 1f, 0, GetPosition(), 0);
		fxList.Add(DieFX);
		yield return WaitTime(0.4);
		ClearActors(new List<LogicEntity> { _actor });
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
			if (Distance(position, entityPosition) <= 3.9)
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
				if (_checkTimer >= 12 && !_hasPlayedA)
				{
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
						BeginAttack(1, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
						GetEnemy1();
						BeginLookAt_NotWait(Targetenemy, 0.6, 3600);
						AreaEffectID = PlayAreaEffect("Area_31102_LieQuan_Warning_EX", GetEntityPosition(GetCurrentPlayer()));
						yield return WaitTime(0.6);
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
						BeginAttack(2, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
						GetEnemy1();
						BeginLookAt_NotWait(Targetenemy, 0.6, 3600);
						AreaEffectID = PlayAreaEffect("Area_31102_LieQuan_Warning", GetEntityPosition(GetCurrentPlayer()));
						yield return WaitTime(0.6);
						CancelAttack();
						yield return WaitTime(0.15);
						SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
						Dash2();
						yield return WaitTime(0.8);
						DispatchCustomEvent("OnCustomEvt", isSelfEvent: false);
						ClearActors(new List<LogicEntity> { _actor });
					}
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

	private void doDash(FP dis)
	{
		BeginDashActorForward(1, dash_spd, dis, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
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
		BeginDashActorForward(1, speed, fP - 4, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
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
		BeginDashActorForward(2, speed, fP - 4, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void GetEnemy1()
	{
		Targetenemy = GetCurrentPlayer();
	}
}
