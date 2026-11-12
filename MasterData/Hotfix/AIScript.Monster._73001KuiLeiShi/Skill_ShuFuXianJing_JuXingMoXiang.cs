using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_ShuFuXianJing_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_ShuFuXianJing = "ShuFuXianJing";

	private static readonly int[] patrolMonsterIds;

	private FP patrolSpawnInnerRadius_A = 1;

	private FP patrolSpawnOuterRadius_A = 3;

	private FP patrolSpawnInnerRadius_B = 3;

	private FP patrolSpawnOuterRadius_B = 5;

	private FP patrolMinDist = 4;

	private const int patrolSpawnMaxRetry = 10;

	private readonly string[] trapPlaceHolderNames = new string[4] { "P2_Nv_Skill3_1", "P2_Nv_Skill3_2", "P2_Nv_Skill3_3", "P2_Nv_Skill3_4" };

	private readonly int trapSpawnCount = 3;

	private readonly FP trapSpawnInnerRadius = 1;

	private readonly FP trapSpawnOuterRadius = 3;

	private string fx_Left = "fx_m72012_loop_skill3_xuli2_L";

	private string fx_Right = "fx_m72012_loop_skill3_xuli2_R";

	private long Play_fx_Left;

	private long Play_fx_Right;

	private Queue<TSVector2> _pendingPatrolAnchors = new Queue<TSVector2>();

	private bool finished;

	private int _summonLevel;

	private int _trapId;

	private int _patrolId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_trapId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.trapMonsterIds);
		_patrolId = Common_73001.GetMonsterIdByLevel(_summonLevel, patrolMonsterIds);
		_pendingPatrolAnchors.Clear();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(Play_fx_Left);
		StopEffect(Play_fx_Right);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
		_pendingPatrolAnchors.Clear();
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_trapId));
			ClearActors(GetTargetByDataID(_patrolId));
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		StopEffect(Play_fx_Left);
		StopEffect(Play_fx_Right);
		ClearOwnerBullet();
		ClearActors(GetTargetByDataID(_trapId));
		ClearActors(GetTargetByDataID(_patrolId));
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtCameraDir(DirectionType.Down, default, 400);
		BeginAttack(1, "ShuFuXianJing", flushInputedKeys: true);
		yield return WaitCustomEvent("FxStart");
		Play_fx_Left = PlayEffect(fx_Left);
		Play_fx_Right = PlayEffect(fx_Right);
		TSVector2[] trapPositions = SpawnTraps(out var unusedPlaceholderPos);
		SpawnPatrols(trapPositions, unusedPlaceholderPos);
		yield return WaitTime(6);
		CancelAttack();
		StopEffect(Play_fx_Left);
		StopEffect(Play_fx_Right);
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private TSVector2[] SpawnTraps(out TSVector2 unusedPlaceholderPos)
	{
		unusedPlaceholderPos = TSVector2.zero;
		TSVector2 entityPosition = GetEntityPosition(GetAttackTarget());
		TSVector2[] array = SortPlaceholdersByDistance(entityPosition);
		int num = ((trapSpawnCount < array.Length) ? trapSpawnCount : array.Length);
		if (array.Length > num)
		{
			unusedPlaceholderPos = array[num];
		}
		TSVector2[] array2 = new TSVector2[num];
		for (int i = 0; i < num; i++)
		{
			TSVector2 position = array[i];
			FP radius = trapSpawnOuterRadius;
			FP innerRadius = trapSpawnInnerRadius;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
			SummonMonster(spawnPosition: array2[i] = GetShapeRandomPoint(shapeData, _actor, isReachable: true), summonActorID: _trapId, summonGroupID: 0, spawnDirection: TSVector2.up);
		}
		LogicEntity entity = GetAttackTarget() ?? GetCurrentPlayer();
		TSVector2 entityPosition2 = GetEntityPosition(entity);
		TSVector2 tSVector = entityPosition2 - GetPosition();
		TSVector2 tSVector2 = ((tSVector != TSVector2.zero) ? tSVector.normalized : TSVector2.up);
		FP randomValue = GetRandomValue(6, 8);
		TSVector2 spawnPosition = entityPosition2 + tSVector2 * randomValue;
		if (_summonLevel >= 4)
		{
			SummonMonster(_trapId, 0, spawnPosition, TSVector2.up);
		}
		return array2;
	}

	private TSVector2[] SortPlaceholdersByDistance(TSVector2 referencePos)
	{
		TSVector2[] array = new TSVector2[trapPlaceHolderNames.Length];
		for (int i = 0; i < trapPlaceHolderNames.Length; i++)
		{
			array[i] = GetPlaceHolderPosition(trapPlaceHolderNames[i]);
		}
		for (int j = 0; j < array.Length - 1; j++)
		{
			int num = j;
			for (int k = j + 1; k < array.Length; k++)
			{
				if (TSVector2.DistanceSquared(array[k], referencePos) < TSVector2.DistanceSquared(array[num], referencePos))
				{
					num = k;
				}
			}
			if (num != j)
			{
				ref TSVector2 reference = ref array[j];
				ref TSVector2 reference2 = ref array[num];
				TSVector2 tSVector = array[num];
				TSVector2 tSVector2 = array[j];
				reference = tSVector;
				reference2 = tSVector2;
			}
		}
		return array;
	}

	private void SpawnPatrols(TSVector2[] trapPositions, TSVector2 unusedPlaceholderPos)
	{
		if (_patrolId <= 0 || trapPositions == null || trapPositions.Length < 2)
		{
			return;
		}
		_pendingPatrolAnchors.Clear();
		TSVector2 entityPosition = GetEntityPosition(GetAttackTarget());
		FP radius = patrolSpawnOuterRadius_A;
		FP innerRadius = patrolSpawnInnerRadius_A;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, unusedPlaceholderPos, default, default, radius, innerRadius);
		innerRadius = patrolSpawnOuterRadius_B;
		radius = patrolSpawnInnerRadius_B;
		DeterministicShape shapeData2 = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, innerRadius, radius);
		FP fP = patrolMinDist * patrolMinDist;
		TSVector2 tSVector = TSVector2.zero;
		TSVector2 tSVector2 = TSVector2.zero;
		for (int i = 0; i < 10; i++)
		{
			tSVector = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			tSVector2 = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
			if (TSVector2.DistanceSquared(tSVector, tSVector2) >= fP)
			{
				break;
			}
		}
		_pendingPatrolAnchors.Enqueue(trapPositions[0]);
		SummonMonster(_patrolId, 0, tSVector, TSVector2.up);
		_pendingPatrolAnchors.Enqueue(trapPositions[1]);
		SummonMonster(_patrolId, 0, tSVector2, TSVector2.up);
	}

	private void OnSummonSpawned(IEvent evt)
	{
		if (!(evt is AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent) || adventureMonsterSummonerSpawnedEvent.summonerId != _actor.Id)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(adventureMonsterSummonerSpawnedEvent.id) as MonsterAdventureActor;
		if (!(monsterAdventureActor == null))
		{
			SetLogicTagFpValue(monsterAdventureActor, Common_73001.SummonLevel_Tag, _summonLevel);
			if (monsterAdventureActor.dataID == _patrolId && _pendingPatrolAnchors.Count > 0)
			{
				TSVector2 tSVector = _pendingPatrolAnchors.Dequeue();
				SetLogicTagFpValue(monsterAdventureActor, "ShuFuPatrolAnchorPosX", tSVector.x);
				SetLogicTagFpValue(monsterAdventureActor, "ShuFuPatrolAnchorPosY", tSVector.y);
				SetLogicTagFpValue(monsterAdventureActor, "ShuFuTrapMonsterId", _trapId);
			}
		}
	}

	static Skill_ShuFuXianJing_JuXingMoXiang()
	{
		//IL_000c: Field data (rva=0x598) could not be found in any section!
		//IL_000c: Field data (rva=0x598) could not be found in any section!
		int[] array = new int[6];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._10297DA2506B84EFCDA3E4C288835D73DA1C6611FB7D9A324AE3D0D7674F52C4));
		patrolMonsterIds = array;
	}
}
