using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_JiGuangFangShe_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_JiGuangFangShe = "JiGuangFangShe";

	private const int orbCount = 2;

	private const string orbBulletAlias = "Bullet_72012_SKill2_Throw";

	private static readonly int[] shooterMonsterIds = new int[6] { 1718906696, 1415346281, 1550868850, 825570865, 1852130864, 1868645223 };

	private int shooterCount = 1;

	private FP shooterRingInner = 6;

	private FP shooterRingOuter = 8;

	private FP shooterMinDist = 3;

	private const int shooterSpawnMaxRetry = 10;

	private FP orbSpawnHeight = 7;

	private FP laserOrbDuration = 10;

	private FP landJitterInnerRadius = 1;

	private FP landJitterOuterRadius = 3;

	private FP orbFlightTime = 1;

	private readonly string[] fixedLandPlaceHolders = new string[5] { "P2_Nv_Skill2_1", "P2_Nv_Skill2_2", "P2_Nv_Skill2_3", "P2_Nv_Skill2_4", "P2_Nv_Skill2_5" };

	private int _pendingSpawnCount;

	private int _nextPlaceholderIndex;

	private bool finished;

	private int _summonLevel;

	private int _laserOrbId;

	private int _shooterId;

	private TSVector2 GetNextPlaceholderPosition()
	{
		TSVector2 placeHolderPosition = GetPlaceHolderPosition(fixedLandPlaceHolders[_nextPlaceholderIndex]);
		_nextPlaceholderIndex = (_nextPlaceholderIndex + 1) % fixedLandPlaceHolders.Length;
		FP radius = landJitterOuterRadius;
		FP innerRadius = landJitterInnerRadius;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, placeHolderPosition, default, default, radius, innerRadius);
		return GetShapeRandomPoint(shapeData, _actor, isReachable: true);
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_laserOrbId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.laserOrbMonsterIds);
		_shooterId = Common_73001.GetMonsterIdByLevel(_summonLevel, shooterMonsterIds);
		if (_summonLevel > 5)
		{
			shooterCount = 2;
		}
		_pendingSpawnCount = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnLaserOrbSpawned);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnLaserOrbSpawned);
		_pendingSpawnCount = 0;
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_laserOrbId));
			ClearActors(GetTargetByDataID(_shooterId));
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		ClearOwnerBullet();
		ClearActors(GetTargetByDataID(_laserOrbId));
		ClearActors(GetTargetByDataID(_shooterId));
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "JiGuangFangShe", flushInputedKeys: true);
		_pendingSpawnCount = 2;
		yield return WaitCustomEvent("ShootLeft");
		SpawnShooters();
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-4, 3));
		TSVector2 nextPlaceholderPosition = GetNextPlaceholderPosition();
		TSVector2 nextPlaceholderPosition2 = GetNextPlaceholderPosition();
		Skill_JiGuangFangShe_JuXingMoXiang skill_JiGuangFangShe_JuXingMoXiang = this;
		FP positionY = orbSpawnHeight;
		FP range = 0;
		TSVector2 targetPosition = nextPlaceholderPosition;
		skill_JiGuangFangShe_JuXingMoXiang.Shoot("Bullet_72012_SKill2_Throw", position, positionY, range, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
		Skill_JiGuangFangShe_JuXingMoXiang skill_JiGuangFangShe_JuXingMoXiang2 = this;
		FP positionY2 = orbSpawnHeight;
		FP range2 = 0;
		targetPosition = nextPlaceholderPosition2;
		skill_JiGuangFangShe_JuXingMoXiang2.Shoot("Bullet_72012_SKill2_Throw", position, positionY2, range2, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
		yield return WaitCustomEvent("ShootRight");
		TSVector2 position2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(4, 3));
		Skill_JiGuangFangShe_JuXingMoXiang skill_JiGuangFangShe_JuXingMoXiang3 = this;
		TSVector2 entityPosition = GetEntityPosition(GetAttackTarget());
		FP radius = 3;
		FP innerRadius = 1;
		skill_JiGuangFangShe_JuXingMoXiang3.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		TSVector2 nextPlaceholderPosition3 = GetNextPlaceholderPosition();
		LogicEntity entity = GetAttackTarget() ?? GetCurrentPlayer();
		TSVector2 entityPosition2 = GetEntityPosition(entity);
		TSVector2 tSVector = entityPosition2 - GetPosition();
		TSVector2 tSVector2 = ((tSVector != TSVector2.zero) ? tSVector.normalized : TSVector2.up);
		FP randomValue = GetRandomValue(6, 7);
		TSVector2 tSVector3 = entityPosition2 + tSVector2 * randomValue;
		Skill_JiGuangFangShe_JuXingMoXiang skill_JiGuangFangShe_JuXingMoXiang4 = this;
		FP positionY3 = orbSpawnHeight;
		FP range3 = 0;
		targetPosition = nextPlaceholderPosition3;
		skill_JiGuangFangShe_JuXingMoXiang4.Shoot("Bullet_72012_SKill2_Throw", position2, positionY3, range3, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
		if (_summonLevel >= 4)
		{
			Skill_JiGuangFangShe_JuXingMoXiang skill_JiGuangFangShe_JuXingMoXiang5 = this;
			FP positionY4 = orbSpawnHeight;
			FP range4 = 0;
			targetPosition = tSVector3;
			skill_JiGuangFangShe_JuXingMoXiang5.Shoot("Bullet_72012_SKill2_Throw", position2, positionY4, range4, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
		}
		yield return WaitTime(orbFlightTime + 0.2);
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void SpawnShooters()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 tSVector = ((currentPlayer != null) ? GetEntityPosition(currentPlayer) : GetPosition());
		FP fP = shooterMinDist * shooterMinDist;
		TSVector2[] array = new TSVector2[shooterCount];
		for (int i = 0; i < shooterCount; i++)
		{
			FP radius = shooterRingOuter;
			FP innerRadius = shooterRingInner;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, tSVector, default, default, radius, innerRadius);
			TSVector2 tSVector2 = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			for (int j = 1; j < 10; j++)
			{
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
				bool flag = false;
				for (int k = 0; k < i; k++)
				{
					if (TSVector2.DistanceSquared(shapeRandomPoint, array[k]) < fP)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					tSVector2 = shapeRandomPoint;
					break;
				}
			}
			array[i] = tSVector2;
			TSVector2 spawnDirection = (((tSVector - tSVector2).magnitude > FP.Zero) ? (tSVector - tSVector2).normalized : TSVector2.up);
			SummonMonster(_shooterId, 0, tSVector2, spawnDirection);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && !(adventureBulletFinishEvent.owner != _actor))
		{
			SummonMonster(_laserOrbId, 0, adventureBulletFinishEvent.bulletPosition, TSVector2.up);
		}
	}

	private void OnLaserOrbSpawned(IEvent evt)
	{
		if (evt is AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent && adventureMonsterSummonerSpawnedEvent.summonerId == _actor.Id)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(adventureMonsterSummonerSpawnedEvent.id);
			if (!(logicEntity == null))
			{
				SetLogicTagFpValue(logicEntity, Config_JuXingMoXiang.PhaseTag, 2);
				SetLogicTagFpValue(logicEntity, Common_73001.PillarStrengthTag, 2);
				SetLogicTagFpValue(logicEntity, Config_JuXingMoXiang.LaserOrbDurationTag, laserOrbDuration);
				_pendingSpawnCount--;
			}
		}
	}
}
