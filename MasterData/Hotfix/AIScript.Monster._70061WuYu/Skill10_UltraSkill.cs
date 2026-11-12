using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill10_UltraSkill : SkillSimpleBase
{
	private enum BombTargetType
	{
		Aim,
		Predict,
		Random
	}

	private const string ComboKey = "Skill10_UltraSkill";

	private const string WaveRingAlias = "AreaEffect_70061WuYu_Skill10_BoomAct";

	private static readonly FP WaveInterval = 4;

	private const string BombBulletAlias = "Weapon_70061WuYu_Skill7_Bullet_Big";

	private const int WaveCount = 2;

	private const int BombsPerBatch = 6;

	private static readonly FP BombInBatchInterval = 0.2;

	private static readonly FP BombShootHeight = 7;

	private static readonly FP WaveToBombDelay = 1;

	private static readonly FP PredictLeadTime = 0.5;

	private static readonly FP PredictMaxOffset = 6;

	private static readonly FP BombRandomRadius = 15;

	private static readonly FP BombRandomInnerRadius = 6;

	private const string TeleportPlace = "SummonHorroGhostPosition";

	private static readonly FP LookAtDuration = 0.5;

	private static readonly FP LookAtRotateSpeed = 360;

	private static readonly FP DodgeInterruptDelay = 0.9;

	private const string SummonFxAlias = "fx_70061_loop_Attack04_MagicCircle_big";

	private static readonly FP SummonFxSpawnSize = 1.6;

	private static readonly FP SummonDelay = 1;

	private CoroutineNode _waveCoroutine;

	private CoroutineNode _bombCoroutine;

	private readonly BombTargetType[] _bombRoles = new BombTargetType[6];

	private int CanHorrorAmount;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_bombRoles[0] = BombTargetType.Aim;
		_bombRoles[1] = BombTargetType.Predict;
		for (int i = 2; i < 6; i++)
		{
			_bombRoles[i] = BombTargetType.Random;
		}
		SetLogicTagToggleValue(_actor, "CanGetPerfume", value: false);
		CanHorrorAmount = ((!GetLogicTagToggleValue(_actor, "DoubleHorrorTagId")) ? 1 : 2);
		SetLogicTagToggleValue(_actor, "CanUseBroomDodge", value: false);
	}

	protected override void OnSkillDisable()
	{
		DispatchBossBottleClearEvent();
		StopCor(_waveCoroutine);
		StopCor(_bombCoroutine);
		base.OnSkillDisable();
		SetLogicTagToggleValue(_actor, "CanGetPerfume", value: true);
		SetLogicTagToggleValue(_actor, "CanUseBroomDodge", value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 centerPos = GetPlaceHolderPosition("CenterPoint");
		yield return WaitTime(1);
		TSVector2 placeHolderPosition = GetPlaceHolderPosition("SummonHorroGhostPosition");
		SetHideModelEnable();
		Teleport(placeHolderPosition);
		Skill10_UltraSkill skill10_UltraSkill = this;
		TSVector2 position = placeHolderPosition;
		skill10_UltraSkill.PlayEffect("fx_70061WuYu_base_dodge_born", 1f, default, position);
		yield return WaitTime(Skill11_BroomDodge.Delay);
		SetHideModelDisable();
		BeginLookAtByDir_NotWait(TSVector2.down, LookAtDuration, LookAtRotateSpeed);
		BeginAttack(99, "Dodge", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(DodgeInterruptDelay);
		CancelAttack();
		BeginAttack(0, "Skill10_UltraSkill", flushInputedKeys: true, forceInterruptAttack: true);
		DispatchBossBottleClearEvent();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(1);
		StartCor(ref _waveCoroutine, WaveRingLoop());
		yield return WaitTime(WaveToBombDelay);
		StartCor(ref _bombCoroutine, BombSprayLoop());
		yield return _waveCoroutine;
		CancelAttack();
		TSVector2 center = GetPlaceHolderPosition("CenterPoint");
		Skill10_UltraSkill skill10_UltraSkill2 = this;
		position = center;
		float spawnSize = SummonFxSpawnSize.AsFloat();
		long summonFxId = skill10_UltraSkill2.PlayEffect("fx_70061_loop_Attack04_MagicCircle_big", 1f, default, position, default, spawnSize);
		yield return WaitTime(SummonDelay);
		SummonTeammate(7, center, TSVector2.down);
		StopEffect(summonFxId);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(3);
		if ((GetTargetByTeammateIndex(4)?.Count ?? 0) < CanHorrorAmount)
		{
			yield return WaitTime(1);
			long magicCircleFxId = PlayEffect("fx_70061_loop_Attack04_MagicCircle_big", 1f, default, centerPos);
			yield return WaitTime(2);
			StopEffect(magicCircleFxId);
			SummonTeammate(4, centerPos, TSVector2.down, CanHorrorAmount);
			StopCor(_bombCoroutine);
			yield return WaitTime(2);
		}
		else
		{
			yield return WaitTime(3);
			StopCor(_bombCoroutine);
			yield return WaitTime(1);
		}
	}

	private IEnumerator WaveRingLoop()
	{
		TSVector2 center = GetPlaceHolderPosition("CenterPoint");
		for (int wave = 0; wave < 2; wave++)
		{
			PlayAreaEffect("AreaEffect_70061WuYu_Skill10_BoomAct", center, FP.Zero);
			yield return WaitTime(WaveInterval);
		}
	}

	private IEnumerator BombSprayLoop()
	{
		while (true)
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			if (currentPlayer == null)
			{
				yield return WaitTime(BombInBatchInterval);
				continue;
			}
			TSVector2 playerPos = currentPlayer.tsTransform.Position;
			TSVector2 bottlePos = GetPlaceHolderPosition("BigPerfumePosition");
			TSVector2 center = GetPlaceHolderPosition("CenterPoint");
			for (int num = 5; num > 0; num--)
			{
				int num2 = TSRandom.Range(0, num + 1);
				ref BombTargetType reference = ref _bombRoles[num];
				ref BombTargetType reference2 = ref _bombRoles[num2];
				BombTargetType bombTargetType = _bombRoles[num2];
				BombTargetType bombTargetType2 = _bombRoles[num];
				reference = bombTargetType;
				reference2 = bombTargetType2;
			}
			for (int i = 0; i < 6; i++)
			{
				TSVector2 targetPosition;
				switch (_bombRoles[i])
				{
				case BombTargetType.Aim:
					targetPosition = playerPos;
					break;
				case BombTargetType.Predict:
				{
					PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
					TSVector2 tSVector = ((activedPlayerActor != null) ? (activedPlayerActor.velocity * PredictLeadTime) : TSVector2.zero);
					if (tSVector.magnitude > PredictMaxOffset)
					{
						tSVector = tSVector.normalized * PredictMaxOffset;
					}
					targetPosition = playerPos + tSVector;
					break;
				}
				default:
				{
					Skill10_UltraSkill skill10_UltraSkill = this;
					FP bombRandomRadius = BombRandomRadius;
					FP bombRandomInnerRadius = BombRandomInnerRadius;
					DeterministicShape shapeData = skill10_UltraSkill.GetShapeData(DeterministicShape.ShapeType.Circle, center, default, default, bombRandomRadius, bombRandomInnerRadius);
					targetPosition = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
					break;
				}
				}
				ShootGhostBomb(bottlePos, targetPosition);
				yield return WaitTime(BombInBatchInterval);
			}
		}
	}

	private void DispatchBossBottleClearEvent()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventName = "WuYu_BossBottleClear";
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private void ShootGhostBomb(TSVector2 startPosition, TSVector2 targetPosition)
	{
		ILRuntimeAPI.Shoot("Weapon_70061WuYu_Skill7_Bullet_Big", _actor, default, startPosition, BombShootHeight, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
	}
}
