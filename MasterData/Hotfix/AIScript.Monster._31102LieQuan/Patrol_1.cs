using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31102LieQuan;

public class Patrol_1 : SkillSimpleBase
{
	private readonly string combo_key1 = "Attack";

	private readonly string combo_key2 = "EXAttack";

	private CoroutineNode DistanceAttackCor;

	private CoroutineNode DogMove;

	private long ZhenChaFX;

	private long ShanShuoFX;

	private long GanTanHaoFX;

	private long SuoDingFX;

	private long SmokeFX;

	private long SmokeEndFX;

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

	private int time = 10000;

	private TSVector2 targetPosition1;

	private TSVector2 targetPosition2;

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
		StopCor(DogMove);
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
		ZhenChaFX = PlayEffect("fx_m31102_loop_Attack_2_zhencha", 1f, 0, GetPosition(), 0);
		SmokeFX = PlayEffect("fx_m31102_loop_Smoke", 1f, 0, GetPosition(), 0);
		fxList.Add(ZhenChaFX);
		fxList.Add(SmokeFX);
		DistanceAttackCor = StartCor(StartCheckLoop());
		DogMove = StartCor(DogMoveTo());
		yield return WaitTime(99999);
	}

	protected IEnumerator DogMoveTo()
	{
		while (time > 0)
		{
			yield return WaitTime(1);
			targetPosition1 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 11));
			MoveToPosition(targetPosition1, 0.1, AdventureActor.MovementMode.Walk, 11);
			yield return WaitMoveStatus();
			yield return BeginRotateAngle(-180, 180);
			yield return WaitTime(1);
			targetPosition2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 11));
			MoveToPosition(targetPosition2, 0.1, AdventureActor.MovementMode.Walk, 11);
			yield return WaitMoveStatus();
			yield return BeginRotateAngle(-180, 180);
			time--;
		}
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
			if (Distance(position, entityPosition) <= 4)
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
					time = 0;
					StopMove();
					StopCor(DogMove);
					_hasPlayedA = true;
					_isChecking = false;
					StopEffect(ShanShuoFX);
					StopEffect(SmokeFX);
					StopEffect(GanTanHaoFX);
					StopEffect(ZhenChaFX);
					SuoDingFX = PlayEffect("fx_m31102_base_Attack_2_end", 1f, 0, GetPosition(), 0);
					SmokeEndFX = PlayEffect("fx_m31102_base_End", 1f, 0, GetPosition(), 0);
					fxList.Add(SuoDingFX);
					fxList.Add(SmokeEndFX);
					BeginAttack(2, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
					GetEnemy();
					BeginLookAt_NotWait(Targetenemy, 0.6, 3600);
					AreaEffectID = PlayAreaEffect("Area_31102_LieQuan_Warning", GetEntityPosition(GetCurrentPlayer()));
					yield return WaitTime(0.6);
					CancelAttack();
					yield return WaitTime(0.15);
					SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
					Dash2();
					yield return WaitTime(0.8);
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

	private void Dash2()
	{
		TSVector2 position = GetPosition();
		AreaEffectIDPosition = GetAreaEffectPosition(AreaEffectID);
		DamageAreaEffectID = PlayAreaEffect("Area_31102_LieQuan_Warning_End", AreaEffectIDPosition);
		FP fP = Distance(position, AreaEffectIDPosition);
		FP speed = (fP - 4) / 0.4;
		AimAtPosition(AreaEffectIDPosition, 7200);
		StopAreaEffect(AreaEffectID);
		BeginDashActorForward(1, speed, fP - 3.2, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void GetEnemy()
	{
		Targetenemy = GetCurrentPlayer();
	}
}
