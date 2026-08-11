#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Resource;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Pool;
using UnityEngine.SceneManagement;

namespace Ase;

public class ClimbTowerSystem : BaseSystem
{
	private readonly string nMonsterLabel = "N";

	private readonly string fMonsterLabel = "F";

	private readonly string nfMonsterLabel = "NF";

	private readonly string bMonsterLabel = "B";

	private TowerConfig towerConfigData;

	private Scene mapDataScene;

	private bool _systemIsInitSuccess;

	private string sceneLoadPath;

	private int towerIndex;

	private int endlessLayer;

	private TowerFloorData curTowerFloorData;

	private List<Vector4> randomBornPoint;

	private List<PeripheryHeroData> teamConfig;

	private List<int> talentTowerBuffs = new List<int>(6);

	private List<int> rogueTowerBuffs = new List<int>(6);

	private LevelFailWindow levelFailWindow;

	private BaseEntity actorEntity;

	private RandomBuffDisplayWindow randomBuffDisplayWindow;

	private RandomBuffDisplayViewModel randomBuffDisplayVM;

	private TowerRandomBuffViewModel towerRandomBuffViewModel;

	private TowerRandomBuffWindow randomBuffWindow;

	private bool monsterAllRelease;

	private bool settlementFinish;

	private bool unloadSceneSuccess;

	private bool unloadSceneFinish;

	private bool loadingSceneFinish;

	private bool loadingSceneSuccess;

	private BaseEntity bossEntity;

	private ClimbTowerWorld climbTowerWorld;

	private TowerBlackScreenViewModel towerBlackScreenVM;

	private BattleConfigLoadInfo battleBeforeLoadInfo = new BattleConfigLoadInfo("TOWERBATTLEBEFORE");

	private BattleConfigLoadInfo battleStageLoadInfo = new BattleConfigLoadInfo("TOWERBATTLE");

	private Dictionary<EntityData, float> monsterAttrDifficultyFactors = new Dictionary<EntityData, float>(10);

	private int curTowerLayerCapacity;

	protected override bool IsLogicSystem => false;

	public override UniTask<bool> OnEnter(object data = null)
	{
		return base.OnEnter(data);
	}

	public async UniTask<bool> LoadBattleSceneMapData(ClimbTowerWorldData data, GameObject worldRoot, List<int> rogueBff)
	{
		climbTowerWorld = world as ClimbTowerWorld;
		mapDataScene = SceneManager.CreateScene("MapDataScene");
		SceneManager.MoveGameObjectToScene(worldRoot, mapDataScene);
		_systemIsInitSuccess = true;
		towerConfigData = data.TowerConfig;
		teamConfig = data.TeamListConfig;
		talentTowerBuffs.AddRange(data.TalentBuff);
		rogueTowerBuffs.AddRange(rogueBff);
		towerIndex = data.TowerIndex;
		endlessLayer = data.EndlessLayer;
		sceneLoadPath = data.SceneLoadPath;
		int navMeshId = data.NavMeshId;
		GetFloorData();
		if (GetIsEndlessBossFloor())
		{
			ChangeSceneAndNavMesh(navMeshId);
		}
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetSceneLoadPath(sceneLoadPath);
		randomBuffDisplayVM = new RandomBuffDisplayViewModel(null, GamePauseOrResume);
		randomBuffDisplayWindow = await GameEntry.UI.LoadWindow<RandomBuffDisplayWindow>("OperatingActivity/TownChallenge/RandomBuffDisplayWindow", randomBuffDisplayVM);
		if (!(await LoadHeroEntity(curTowerFloorData.HeroPoints)))
		{
			return false;
		}
		await OuterEnterShowBlackScrren();
		return true;
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		if (randomBuffDisplayWindow != null)
		{
			randomBuffDisplayWindow.Show();
		}
		StartBattle(showTitle: true, outerEnter: true);
	}

	private void GamePauseOrResume(bool isPause)
	{
		if (isPause)
		{
			world.GamePause();
		}
		else
		{
			world.GameResume();
		}
	}

	public async UniTask<bool> PlayNewTower(List<int> buffs, bool showTitle, List<int> rogueBuffs)
	{
		talentTowerBuffs.Clear();
		rogueTowerBuffs.Clear();
		if (buffs != null)
		{
			talentTowerBuffs.AddRange(buffs);
		}
		if (rogueBuffs != null)
		{
			rogueTowerBuffs.AddRange(rogueBuffs);
		}
		int lastNavMeshId = curTowerFloorData.NavMesh;
		if (endlessLayer > 0)
		{
			endlessLayer++;
		}
		else
		{
			towerIndex++;
		}
		actorEntity = null;
		GetSystem<EntitySystem>()?.ClearAllEntity();
		await UniTask.WaitForSeconds(0.2f);
		if (curTowerFloorData.IsBossFloor)
		{
			GetSystem<EntityViewCacheSystem>().ClearAllEntityPools();
		}
		GetFloorData();
		CloseAllDirUI();
		ChangeSceneAndNavMesh(lastNavMeshId);
		if (!(await LoadHeroEntity(curTowerFloorData.HeroPoints)))
		{
			return false;
		}
		await StartBattle(showTitle, outerEnter: false);
		return true;
	}

	private async UniTask ChangeSceneAndNavMesh(int lastNavMeshId)
	{
		await LoadTowerScene("Activity/" + curTowerFloorData.SceneName);
		PathfindingSystem system = GetSystem<PathfindingSystem>();
		if (system != null && lastNavMeshId != curTowerFloorData.NavMesh)
		{
			system.ClearNavMesh(lastNavMeshId);
			system.GenerateNavMesh(curTowerFloorData.NavMesh);
		}
	}

	private void GetFloorData()
	{
		if (towerConfigData == null)
		{
			return;
		}
		if (endlessLayer > 0)
		{
			if (endlessLayer % towerConfigData.BossLayerInterval != 0)
			{
				curTowerFloorData = towerConfigData.EndlessNormalFloorData;
			}
			else
			{
				curTowerFloorData = towerConfigData.EndlessBossFloorData;
				ResetBattleConfigLoadInfo(battleBeforeLoadInfo, curTowerFloorData.NewBattleBeforeConfig);
				ResetBattleConfigLoadInfo(battleStageLoadInfo, curTowerFloorData.NewBattleConfig);
				GetBattleConfigWaveMonster(battleBeforeLoadInfo);
				GetBattleConfigWaveMonster(battleStageLoadInfo);
			}
		}
		else if (towerConfigData.FloorConfigs.Count > towerIndex)
		{
			curTowerFloorData = towerConfigData.FloorConfigs[towerIndex];
		}
		randomBornPoint = curTowerFloorData.GetRandomPoint();
	}

	private async UniTask StartBattle(bool showTitle, bool outerEnter)
	{
		if (!(towerConfigData == null))
		{
			curTowerLayerCapacity = 0;
			await FirstLoadCurFloorConfig(battleBeforeLoadInfo, curTowerFloorData.NewBattleBeforeConfig);
			settlementFinish = false;
			monsterAllRelease = false;
			if (outerEnter)
			{
				await UniTask.WaitForSeconds(1);
			}
			CloseTowerBlackScreen();
			await PlayTimeLine();
			if (showTitle)
			{
				await ShowClimbTowerTile();
			}
			await FirstLoadCurFloorConfig(battleStageLoadInfo, curTowerFloorData.NewBattleConfig);
			if (!curTowerFloorData.IsBossFloor)
			{
				BattleSystem system = GetSystem<BattleSystem>();
				system?.SetBattleTimeConfig(curTowerFloorData.BattleDuration);
				system?.SetBattleTimeDelay(0f);
			}
		}
	}

	private async UniTask FirstLoadCurFloorConfig(BattleConfigLoadInfo battleConfigLoadInfo, TowerFloorStageData stageData)
	{
		if (!GetIsEndlessBossFloor())
		{
			ResetBattleConfigLoadInfo(battleConfigLoadInfo, stageData);
		}
		await FloorBattleLoad(stageData.InteractNodes, battleConfigLoadInfo);
		await LoadBattleConfigWaveMonster(battleConfigLoadInfo);
	}

	private void ResetBattleConfigLoadInfo(BattleConfigLoadInfo battleConfigLoadInfo, TowerFloorStageData stageData)
	{
		battleConfigLoadInfo.Clear();
		battleConfigLoadInfo.MonsterWaves = stageData.MonsterWaves;
		battleConfigLoadInfo.ScenePoint = curTowerFloorData.GetWaveScenePoint(battleConfigLoadInfo.curWaveIndex);
		battleConfigLoadInfo.WaveMonsterLoadDatas.Clear();
	}

	private async UniTask PlayTimeLine()
	{
		if (!curTowerFloorData.IsBossFloor || bossEntity == null || curTowerFloorData.BattleTimeLineId <= 0 || !(bossEntity is MonsterEntity { MonsterAttrConfig: not null } monsterEntity))
		{
			return;
		}
		DRBattleTimeline dataRow = GameEntry.DataTable.GetDataRow<DRBattleTimeline>(monsterEntity.MonsterAttrConfig.MonsterType);
		if (dataRow != null)
		{
			EntityViewComponent component = bossEntity.GetComponent<EntityViewComponent>();
			if (component != null && !(component.Transform == null))
			{
				await GetSystem<BattleWorldTimeLineSystem>().PlayTimeline(dataRow.Id, component.Transform.gameObject);
			}
		}
	}

	private async UniTask OuterEnterShowBlackScrren()
	{
		towerBlackScreenVM = new TowerBlackScreenViewModel();
		TowerBlackScreenWindow window = await GameEntry.UI.LoadWindow<TowerBlackScreenWindow>(AssetUtility.GetUIFormAsset("OperatingActivity/TownChallenge/TowerBlackScreenWindow1"), "LEVELlLOADBLACKSCREENGROUP", towerBlackScreenVM);
		window.Show();
		await UniTask.WaitUntil(() => window.Visibility);
		towerBlackScreenVM.SetHideTime(window.HideTime);
		towerBlackScreenVM.ShowEndTime();
	}

	private async UniTask CloseTowerBlackScreen()
	{
		if (towerBlackScreenVM != null)
		{
			towerBlackScreenVM.PlayBlackScreenHide();
			await UniTask.WaitForSeconds(towerBlackScreenVM.HideTime);
			towerBlackScreenVM.Close();
			towerBlackScreenVM = null;
		}
	}

	private async UniTask BattleEnd()
	{
		if (!(towerConfigData == null))
		{
			await FloorBattleLoad(curTowerFloorData.BattleEndNodes, null);
		}
	}

	private async UniTask LoadBattleConfigWaveMonster(BattleConfigLoadInfo battleConfigLoadInfo)
	{
		if (GetIsEndlessBossFloor() || GetBattleConfigWaveMonster(battleConfigLoadInfo))
		{
			GetMonsterBornPoint(battleConfigLoadInfo);
			battleConfigLoadInfo.CurWaveLoadFinish = false;
			await LoadWaveMonsterEntity(battleConfigLoadInfo);
			battleConfigLoadInfo.CurWaveLoadFinish = true;
			if (battleConfigLoadInfo.curWaveIndex >= battleConfigLoadInfo.MonsterWaves.Count)
			{
				battleConfigLoadInfo.LoadAllWaves = true;
			}
		}
	}

	private bool GetBattleConfigWaveMonster(BattleConfigLoadInfo battleConfigLoadInfo)
	{
		if (battleConfigLoadInfo.MonsterWaves == null || battleConfigLoadInfo.MonsterWaves.Count <= 0)
		{
			battleConfigLoadInfo.LoadAllWaves = true;
			battleConfigLoadInfo.CurWaveLoadFinish = true;
		}
		if (battleConfigLoadInfo.LoadAllWaves)
		{
			return false;
		}
		battleConfigLoadInfo.curWaveIndex++;
		TowerFloorMonsterWaveData towerFloorMonsterWaveData = battleConfigLoadInfo.MonsterWaves[battleConfigLoadInfo.curWaveIndex - 1];
		if (endlessLayer > 0)
		{
			battleConfigLoadInfo.CurWaveDifficultyFactor = towerIndex + 1 + endlessLayer - towerConfigData.EndlessDifficultyFactor;
		}
		else
		{
			battleConfigLoadInfo.CurWaveDifficultyFactor = towerFloorMonsterWaveData.DifficultyFactor;
		}
		if (towerFloorMonsterWaveData.OpenRandomMonster)
		{
			GetBattleConfigRandomMonsterId(towerFloorMonsterWaveData, battleConfigLoadInfo);
		}
		if (battleConfigLoadInfo.WaveMonsterLoadDatas.Count > 0)
		{
			SetEndlessBossTowerConfig(battleConfigLoadInfo.WaveMonsterLoadDatas[0].MonsterId);
		}
		for (int i = 0; i < towerFloorMonsterWaveData.MonsterNodes.Count; i++)
		{
			battleConfigLoadInfo.WaveMonsterLoadDatas.Add(new WaveMonsterLoadData
			{
				MonsterId = towerFloorMonsterWaveData.MonsterNodes[i].nodeId,
				AttackControllId = towerFloorMonsterWaveData.MonsterNodes[i].monsterAttackCtrlId
			});
		}
		SetWaveMonstersLabel(battleConfigLoadInfo.WaveMonsterLoadDatas);
		return true;
	}

	private void SetEndlessBossTowerConfig(int monsterType)
	{
		if (GetIsEndlessBossFloor())
		{
			DRRandomMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRRandomMonsterAttr>(monsterType);
			if (dataRow != null)
			{
				curTowerFloorData.NavMesh = dataRow.NavmeshID;
				curTowerFloorData.SceneName = dataRow.SceneName;
			}
		}
	}

	private bool GetIsEndlessBossFloor()
	{
		if (curTowerFloorData == null)
		{
			return false;
		}
		if (endlessLayer > 0)
		{
			return curTowerFloorData.IsBossFloor;
		}
		return false;
	}

	private void SetWaveMonstersLabel(List<WaveMonsterLoadData> waveMonsterLoadDatas)
	{
		for (int i = 0; i < waveMonsterLoadDatas.Count; i++)
		{
			WaveMonsterLoadData value = waveMonsterLoadDatas[i];
			DRRandomMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRRandomMonsterAttr>(value.MonsterId);
			bool? flag = null;
			if (dataRow.MonsterLabel == nMonsterLabel)
			{
				flag = true;
			}
			else if (dataRow.MonsterLabel == fMonsterLabel)
			{
				flag = false;
			}
			else if (dataRow.MonsterLabel == nfMonsterLabel)
			{
				flag = ((!(UnityEngine.Random.value < 0.5f)) ? new bool?(false) : new bool?(true));
			}
			if (flag.HasValue)
			{
				value.MonsterLabel = (flag.Value ? nMonsterLabel : fMonsterLabel);
			}
			else
			{
				value.MonsterLabel = bMonsterLabel;
			}
			waveMonsterLoadDatas[i] = value;
		}
	}

	private void GetBattleConfigRandomMonsterId(TowerFloorMonsterWaveData monsterWaveData, BattleConfigLoadInfo battleConfigLoadInfo)
	{
		DRRandomMonster dataRow = GameEntry.DataTable.GetDataRow<DRRandomMonster>(monsterWaveData.RandomMonsterPoolId);
		if (dataRow == null)
		{
			return;
		}
		List<(int, int)> list = CollectionPool<List<(int, int)>, (int, int)>.Get();
		int num = monsterWaveData.MonsterCapacity;
		if (endlessLayer > 0)
		{
			num = (int)(battleConfigLoadInfo.CurWaveDifficultyFactor * 10f);
		}
		List<int> list2 = CollectionPool<List<int>, int>.Get();
		List<List<int>> list3 = CollectionPool<List<List<int>>, List<int>>.Get();
		GetRandomConfigData(list2, list3, dataRow);
		bool flag = false;
		int num2 = 0;
		while (!flag)
		{
			if (list2.Count <= 0)
			{
				return;
			}
			int num3 = WeightRandom(list2);
			if (num3 < 0)
			{
				break;
			}
			WeightReduce(list2, num3, dataRow.GroupReduceWeight);
			List<int> list4 = list3[num3];
			List<int> reduceWeight = dataRow.MonsterReduceWeight[num3];
			List<int> list5 = dataRow.MonsterGroup[num3];
			int num4 = WeightRandom(list4);
			if (num4 < 0)
			{
				break;
			}
			WeightReduce(list4, num4, reduceWeight);
			int num5 = list5[num4];
			if (num5 < 0)
			{
				break;
			}
			DRRandomMonsterAttr dataRow2 = GameEntry.DataTable.GetDataRow<DRRandomMonsterAttr>(num5);
			num -= dataRow2.MonsterWeight;
			num2++;
			flag = num == 0 || num2 >= 200;
			if (num >= 0)
			{
				list.Add((num5, dataRow2.MonsterWeight));
				curTowerLayerCapacity += dataRow2.MonsterWeight;
				if (curTowerFloorData.IsBossFloor)
				{
					flag = true;
				}
			}
			else
			{
				num += dataRow2.MonsterWeight;
			}
		}
		int count = list.Count;
		if (monsterWaveData.AttackCtrlCount >= count)
		{
			for (int i = 0; i < list.Count; i++)
			{
				battleConfigLoadInfo.WaveMonsterLoadDatas.Add(new WaveMonsterLoadData
				{
					MonsterId = list[i].Item1,
					AttackControllId = (i + 1) * 100
				});
			}
		}
		else
		{
			list.Sort(((int, int) a, (int, int) b) => a.Item2.CompareTo(b.Item2));
			int num6 = count / monsterWaveData.AttackCtrlCount;
			int num7 = count % monsterWaveData.AttackCtrlCount;
			int attackControllId = 0;
			int num8 = 0;
			for (int num9 = 0; num9 < num6; num9++)
			{
				attackControllId = (num9 + 1) * 100;
				for (int num10 = 0; num10 < monsterWaveData.AttackCtrlCount; num10++)
				{
					AddWaveMonsterLoadData(battleConfigLoadInfo.WaveMonsterLoadDatas, list[num8].Item1, attackControllId);
					num8++;
				}
			}
			for (int num11 = 0; num11 < num7; num11++)
			{
				AddWaveMonsterLoadData(battleConfigLoadInfo.WaveMonsterLoadDatas, list[num8].Item1, attackControllId);
				num8++;
			}
		}
		CollectionPool<List<int>, int>.Release(list2);
		CollectionPool<List<List<int>>, List<int>>.Release(list3);
		CollectionPool<List<(int, int)>, (int, int)>.Release(list);
	}

	private void AddWaveMonsterLoadData(List<WaveMonsterLoadData> waveMonsterLoadDatas, int monsterId, int attackControllId)
	{
		waveMonsterLoadDatas.Add(new WaveMonsterLoadData
		{
			MonsterId = monsterId,
			AttackControllId = attackControllId
		});
	}

	private void GetRandomConfigData(List<int> groupRamdomWeight, List<List<int>> monsterRamdomWeight, DRRandomMonster drRandomMonster)
	{
		groupRamdomWeight.AddRange(drRandomMonster.GroupRamdomWeight);
		for (int i = 0; i < drRandomMonster.MonsterRandomWeight.Count; i++)
		{
			List<int> list = drRandomMonster.MonsterRandomWeight[i];
			List<int> list2 = new List<int>(list.Count);
			monsterRamdomWeight.Add(list2);
			list2.AddRange(list);
		}
	}

	private void WeightReduce(List<int> weight, int index, List<int> reduceWeight)
	{
		weight[index] = Mathf.Max(0, weight[index] - reduceWeight[index]);
	}

	private int WeightRandom(List<int> groupWeight)
	{
		int num = 0;
		for (int i = 0; i < groupWeight.Count; i++)
		{
			num += groupWeight[i];
		}
		int num2 = UnityEngine.Random.Range(0, num);
		int num3 = 0;
		for (int j = 0; j < groupWeight.Count; j++)
		{
			if (num2 < num3 + groupWeight[j])
			{
				return j;
			}
			num3 += groupWeight[j];
		}
		return -1;
	}

	public float GetMonsterDifficultyFactor(EntityData entityData)
	{
		float value = 1f;
		if (monsterAttrDifficultyFactors.TryGetValue(entityData, out value))
		{
			monsterAttrDifficultyFactors.Remove(entityData);
		}
		return value;
	}

	private async UniTask LoadWaveMonsterEntity(BattleConfigLoadInfo battleConfigLoadInfo)
	{
		int monsterCount = battleConfigLoadInfo.WaveMonsterLoadDatas.Count;
		if (monsterCount <= 0)
		{
			return;
		}
		ProgressResult<int> progress = new ProgressResult<int>();
		progress.UpdateProgress(monsterCount);
		for (int i = 0; i < monsterCount; i++)
		{
			WaveMonsterLoadData waveMonsterLoadData = battleConfigLoadInfo.WaveMonsterLoadDatas[i];
			if (waveMonsterLoadData.MonsterBornPoint.HasValue)
			{
				await LoadMonsterEntity(waveMonsterLoadData.MonsterId, waveMonsterLoadData.MonsterBornPoint.Value, waveMonsterLoadData.AttackControllId, battleConfigLoadInfo);
			}
			progress.UpdateProgress(progress.Progress - 1);
		}
		if (progress.Progress <= 0)
		{
			progress.SetResult();
		}
		await progress;
	}

	private async UniTask FloorBattleLoad(FloorNodeData[] datas, BattleConfigLoadInfo battleConfigLoadInfo)
	{
		if (datas.Length == 0)
		{
			return;
		}
		ProgressResult<int> progressResult = new ProgressResult<int>();
		progressResult.UpdateProgress(datas.Length);
		foreach (FloorNodeData floorNodeData in datas)
		{
			if (floorNodeData != null)
			{
				LoadNodeEntity(floorNodeData, progressResult, 1, battleConfigLoadInfo).Forget();
			}
		}
		await progressResult;
	}

	private async UniTask FloorBattleLoad(List<FloorNodeData> datas, BattleConfigLoadInfo battleConfigLoadInfo)
	{
		if (datas.Count <= 0)
		{
			return;
		}
		ProgressResult<int> progressResult = new ProgressResult<int>();
		progressResult.UpdateProgress(datas.Count);
		for (int i = 0; i < datas.Count; i++)
		{
			FloorNodeData floorNodeData = datas[i];
			if (floorNodeData != null)
			{
				LoadNodeEntity(floorNodeData, progressResult, 1, battleConfigLoadInfo).Forget();
			}
		}
		await progressResult;
	}

	private async UniTask LoadNodeEntity(FloorNodeData nodeData, ProgressResult<int> progress, int deltaProgress, BattleConfigLoadInfo battleConfigLoadInfo)
	{
		if (nodeData.nodeType == 0)
		{
			await LoadMonsterEntity(nodeData.nodeId, GetEntityPoint(nodeData, battleConfigLoadInfo), nodeData.monsterAttackCtrlId, battleConfigLoadInfo);
		}
		else if (nodeData.nodeType == 1)
		{
			await LoadInteractiveEntity(nodeData.nodeId, GetEntityPoint(nodeData, battleConfigLoadInfo));
		}
		progress.UpdateProgress(progress.Progress - deltaProgress);
		if (progress.Progress <= 0)
		{
			progress.SetResult();
		}
	}

	private void GetMonsterBornPoint(BattleConfigLoadInfo battleConfigLoadInfo)
	{
		int num = 0;
		int num2 = 0;
		for (int i = 0; i < battleConfigLoadInfo.WaveMonsterLoadDatas.Count; i++)
		{
			if (battleConfigLoadInfo.WaveMonsterLoadDatas[i].MonsterLabel == nMonsterLabel)
			{
				num++;
			}
			else if (battleConfigLoadInfo.WaveMonsterLoadDatas[i].MonsterLabel == fMonsterLabel)
			{
				num2++;
			}
		}
		List<float> list = CollectionPool<List<float>, float>.Get();
		Dictionary<int, int> dictionary = CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Get();
		Dictionary<int, int> dictionary2 = CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Get();
		float num3 = 0f;
		for (int j = 0; j < battleConfigLoadInfo.ScenePoint.Count; j++)
		{
			Vector4 vector = battleConfigLoadInfo.ScenePoint[j];
			float num4 = Vector2.Distance(b: new Vector2(vector.x, vector.z), a: actorEntity.transform.position.ToVector2());
			num4 = (float)(int)(num4 * 100f) / 100f;
			list.Add(num4);
			if (num4 > num3)
			{
				num3 = num4;
			}
		}
		num3 /= 2f;
		for (int k = 0; k < list.Count; k++)
		{
			float num5 = list[k];
			if (num5 < num3)
			{
				int value = (int)(Mathf.Abs(num5 - num3 / 2f) / (num3 / 2f) * 100f);
				dictionary.Add(k, value);
			}
			else
			{
				int value2 = (int)((2f * num3 - num5) / num3 * 100f);
				dictionary2.Add(k, value2);
			}
		}
		Queue<int> labelRandomBornPoint = GetLabelRandomBornPoint(dictionary, num);
		Queue<int> labelRandomBornPoint2 = GetLabelRandomBornPoint(dictionary2, num2);
		int result = 0;
		for (int l = 0; l < battleConfigLoadInfo.WaveMonsterLoadDatas.Count; l++)
		{
			WaveMonsterLoadData value3 = battleConfigLoadInfo.WaveMonsterLoadDatas[l];
			if (value3.MonsterLabel == nMonsterLabel)
			{
				if (!labelRandomBornPoint.TryDequeue(out result))
				{
					continue;
				}
				value3.MonsterBornPoint = battleConfigLoadInfo.ScenePoint[result];
			}
			else if (value3.MonsterLabel == fMonsterLabel)
			{
				if (!labelRandomBornPoint2.TryDequeue(out result))
				{
					continue;
				}
				value3.MonsterBornPoint = battleConfigLoadInfo.ScenePoint[result];
			}
			else if (value3.MonsterLabel == bMonsterLabel)
			{
				value3.MonsterBornPoint = towerConfigData.OriginPos;
			}
			battleConfigLoadInfo.WaveMonsterLoadDatas[l] = value3;
		}
		ReleasePool(list, dictionary, dictionary2);
	}

	private void SetBornPointToLoadInfo(Stack<Vector4> bornPoint, List<int> labelPointIndex, List<Vector4> scenePoint)
	{
		bornPoint.Clear();
		for (int i = 0; i < labelPointIndex.Count; i++)
		{
			int num = labelPointIndex[i];
			bornPoint.Push(scenePoint[num]);
		}
	}

	private void ReleasePool(List<float> pointDistanceEntity, Dictionary<int, int> nLabelPointWeight, Dictionary<int, int> FLabelPointWeight)
	{
		CollectionPool<List<float>, float>.Release(pointDistanceEntity);
		CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Release(nLabelPointWeight);
		CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Release(FLabelPointWeight);
	}

	private Queue<int> GetLabelRandomBornPoint(Dictionary<int, int> pointWeight, int randomCount)
	{
		int num = 0;
		foreach (int value in pointWeight.Values)
		{
			num += value;
		}
		if (randomCount < pointWeight.Count)
		{
			randomCount = pointWeight.Count;
		}
		Queue<int> queue = new Queue<int>(randomCount);
		for (int i = 0; i < randomCount; i++)
		{
			int num2 = UnityEngine.Random.Range(0, num);
			int num3 = 0;
			foreach (KeyValuePair<int, int> item in pointWeight)
			{
				if (num2 < num3 + item.Value)
				{
					queue.Enqueue(item.Key);
					pointWeight.Remove(item.Key);
					num -= item.Value;
					break;
				}
				num3 += item.Value;
			}
		}
		return queue;
	}

	private Vector4 GetEntityPoint(FloorNodeData nodeData, BattleConfigLoadInfo battleConfigLoadInfo)
	{
		Vector4 result = Vector4.zero;
		if (nodeData.IsRandom)
		{
			if (battleConfigLoadInfo != null)
			{
				result = battleConfigLoadInfo.ScenePoint[0];
				battleConfigLoadInfo.ScenePoint.RemoveAt(0);
			}
			else
			{
				if (randomBornPoint == null || randomBornPoint.Count <= 0)
				{
					return result;
				}
				result = randomBornPoint[0];
				randomBornPoint.RemoveAt(0);
			}
		}
		else if (curTowerFloorData.ScenePoints.Length > nodeData.PointIndex)
		{
			result = curTowerFloorData.ScenePoints[nodeData.PointIndex];
		}
		return result;
	}

	private void OnMonsterEntityRelease(BaseEntity entity, bool isNormal)
	{
		int data = entity.GetData<int>(battleStageLoadInfo.TowerMarkStr);
		int data2 = entity.GetData<int>(battleBeforeLoadInfo.TowerMarkStr);
		if (!LoadBattleConfigNextWave(battleStageLoadInfo, data) && !LoadBattleConfigNextWave(battleBeforeLoadInfo, data2) && CheckBattleEnd() && curTowerFloorData != null)
		{
			world.GameSettlement(GameSettlementType.MonsterDead);
			GetSystem<BattleSystem>().StopBattleTime();
			monsterAllRelease = true;
			BossFloorLoadBattleEnd();
		}
	}

	private bool LoadBattleConfigNextWave(BattleConfigLoadInfo battleConfigLoadInfo, int mark)
	{
		if (mark == 0)
		{
			return false;
		}
		battleConfigLoadInfo.SurviveMonsterCount--;
		if (!battleConfigLoadInfo.CurWaveLoadFinish)
		{
			return false;
		}
		battleConfigLoadInfo.WaveMonsterLoadDatas.Clear();
		if (!battleConfigLoadInfo.LoadAllWaves && battleConfigLoadInfo.SurviveMonsterCount <= 0)
		{
			battleConfigLoadInfo.SurviveMonsterCount = 0;
			battleConfigLoadInfo.ScenePoint = curTowerFloorData.GetWaveScenePoint(battleConfigLoadInfo.curWaveIndex);
			LoadBattleConfigWaveMonster(battleConfigLoadInfo);
			return true;
		}
		return false;
	}

	private bool CheckBattleEnd()
	{
		if (battleBeforeLoadInfo.BattleStageEnd() && battleStageLoadInfo.BattleStageEnd())
		{
			return true;
		}
		return false;
	}

	public void ClimbTowerSettlementFinish()
	{
		settlementFinish = true;
		BossFloorLoadBattleEnd();
	}

	private void BossFloorLoadBattleEnd()
	{
		if (monsterAllRelease && settlementFinish)
		{
			BattleEnd();
		}
	}

	private async UniTask<bool> LoadHeroEntity(Vector4[] points)
	{
		for (int i = 0; i < teamConfig.Count; i++)
		{
			PeripheryHeroData heroModel = teamConfig[i];
			foreach (BattleProps value in heroModel.PropsData.Values)
			{
				value?.SetCurBpDataMax();
			}
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(heroModel.Id);
			if (dataRow == null)
			{
				Log.Error($"没有找到Id = {teamConfig[i].Id} 的英雄配置..");
				return false;
			}
			GameObject entityObject = await GetSystem<EntityViewCacheSystem>().AsyncLoadEntityView(teamConfig[i].Id, world.GetSkinAssetPath(heroModel, dataRow));
			HeroEntity heroEntity = GetSystem<EntitySystem>().CreateEntity<HeroEntity>(teamConfig[i].Id, new EntityData
			{
				pointData = new EntityPositionData
				{
					position = points[i],
					scale = Vector3.one,
					rotation = Vector3.up * points[i].w
				},
				entityObject = entityObject,
				updateType = EntityUpdateType.Local,
				logicType = EntityLogicType.None,
				collisionLayer = CollisionSetting.CollisionLayer.Hero,
				collisionMass = 2,
				userData = teamConfig[i]
			});
			if (i == 0)
			{
				world.SetActorId(heroEntity);
				actorEntity = heroEntity;
			}
			heroEntity.SetAi(i != 0);
			heroEntity.BattleHeroData.IsSelf = i == 0;
			GetSystem<BattleSystem>().InitHeroData(heroModel.SeatId, heroEntity, 0);
		}
		GetSystem<BattleSystem>().InitHeroComplete();
		AddBuff(actorEntity);
		return true;
	}

	private void AddBuff(BaseEntity entity)
	{
		List<int> list = CollectionPool<List<int>, int>.Get();
		if (talentTowerBuffs != null && talentTowerBuffs.Count > 0)
		{
			list.AddRange(talentTowerBuffs);
		}
		List<int> list2 = FilterAddRogueBuff(rogueTowerBuffs);
		if (list2 != null && list2.Count > 0)
		{
			list.AddRange(list2);
		}
		CollectionPool<List<int>, int>.Release(list2);
		if (curTowerFloorData.EnvironmentBuff != null && curTowerFloorData.EnvironmentBuff.Length != 0)
		{
			list.AddRange(curTowerFloorData.EnvironmentBuff);
		}
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < list.Count; i++)
			{
				GetSystem<BuffSystem>().CheckAndAcquireBuff(entity, entity, list[i]);
			}
		}
		CollectionPool<List<int>, int>.Release(list);
		randomBuffDisplayVM.RefreshBuff(rogueTowerBuffs);
	}

	private async UniTask LoadMonsterEntity(int monsterId, Vector4 pos, int monsterAttackCtrlId, BattleConfigLoadInfo battleConfigLoadInfo)
	{
		DRMonsterAttr drMonsterAttr = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(monsterId);
		if (drMonsterAttr == null)
		{
			Log.Error($"爬塔没有找到怪物种类 = {monsterId}的怪物配置..");
			return;
		}
		DRMonster drMonster = GameEntry.DataTable.GetDataRow<DRMonster>(drMonsterAttr.MonsterType);
		if (drMonster == null)
		{
			Log.Error($"爬塔没有找到怪物种类 = {drMonsterAttr.MonsterType}的怪物配置..");
			return;
		}
		GameObject gameObject = await AsyncLoadEntity(drMonster.AIParadoxId, drMonster.Id, drMonster.AssetPath);
		if (gameObject == null)
		{
			Log.Error("爬塔加载怪物失败" + drMonster.AssetPath);
			return;
		}
		EntityData entityData = CreateEntityData(pos, gameObject, drMonster, drMonsterAttr);
		if (battleConfigLoadInfo != null)
		{
			monsterAttrDifficultyFactors.Add(entityData, battleConfigLoadInfo.CurWaveDifficultyFactor);
		}
		MonsterEntity monsterEntity = GetSystem<EntitySystem>().CreateEntity<MonsterEntity>(drMonster.Id, entityData);
		if (monsterEntity.IsBoss)
		{
			bossEntity = monsterEntity;
		}
		if (battleConfigLoadInfo != null)
		{
			monsterEntity.SetData(battleConfigLoadInfo.TowerMarkStr, 1);
			battleConfigLoadInfo.SurviveMonsterCount++;
		}
		monsterEntity.SetMonsterAttackCtrlId(monsterAttackCtrlId);
	}

	private EntityData CreateEntityData(Vector4 pos, GameObject entityObject, DRMonster drMonster, DRMonsterAttr drMonsterAttr)
	{
		return new EntityData
		{
			pointData = new EntityPositionData
			{
				position = pos,
				scale = Vector3.one,
				rotation = Vector3.up * pos.w
			},
			entityObject = entityObject,
			updateType = EntityUpdateType.Local,
			logicType = EntityLogicType.None,
			collisionLayer = CollisionSetting.CollisionLayer.Monster,
			collisionMass = 2,
			campType = CampType.Monster,
			userData = drMonster,
			userDataPam = drMonsterAttr,
			callbacks = new EntityCallbacks(null, OnMonsterEntityRelease)
		};
	}

	private async UniTask LoadInteractiveEntity(int mapItemId, Vector3 pos)
	{
		DRMapItem drMapItem = GameEntry.DataTable.GetDataRow<DRMapItem>(mapItemId);
		if (drMapItem == null)
		{
			Log.Error($"没有找到编号 = {mapItemId}的交互物配置..");
			return;
		}
		GameObject gameObject = await AsyncLoadEntity(drMapItem.AIParadoxId, mapItemId, drMapItem.AssetPath);
		if (gameObject == null)
		{
			Log.Error("加载交互物失败" + drMapItem.AssetPath);
			return;
		}
		InteractiveEntity interactiveEntity = GetSystem<EntitySystem>().CreateEntity<InteractiveEntity>(mapItemId, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = pos,
				scale = Vector3.one,
				rotation = Vector3.zero
			},
			entityObject = gameObject,
			userData = drMapItem,
			updateType = EntityUpdateType.Authority,
			logicType = EntityLogicType.None
		});
		interactiveEntity.SetData(Constant.InteractiveConstant.INTERACTIVE_NAME, drMapItem.Name);
		await UniTask.WaitUntil(() => interactiveEntity.IsSurvival).Timeout(TimeSpan.FromSeconds(5.0));
	}

	private async UniTask<GameObject> AsyncLoadEntity(int paradoxId, int entityId, string assetPath)
	{
		ParadoxSystem system = GetSystem<ParadoxSystem>();
		if (system == null || this == null)
		{
			return null;
		}
		await system.PreLoadParadoxGraph(paradoxId);
		if (this == null)
		{
			return null;
		}
		EntityViewCacheSystem system2 = GetSystem<EntityViewCacheSystem>();
		if (system2 == null || this == null)
		{
			return null;
		}
		GameObject result = await system2.AsyncLoadEntityView(entityId, assetPath);
		if (this == null)
		{
			return null;
		}
		return result;
	}

	private async UniTask LoadTowerScene(string scenePath)
	{
		if (!(sceneLoadPath != scenePath))
		{
			return;
		}
		unloadSceneSuccess = false;
		loadingSceneFinish = false;
		loadingSceneSuccess = false;
		if (!string.IsNullOrEmpty(sceneLoadPath))
		{
			unloadSceneFinish = false;
			GameEntry.Scene.UnloadScene(AssetUtility.GetSceneAsset(sceneLoadPath), new UnloadSceneCallbacks(UnloadSceneSuccessCallback, UnloadSceneFailureCallback));
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetSceneLoadPath(string.Empty);
			await UniTask.WaitUntil(() => unloadSceneFinish);
			if (this == null)
			{
				return;
			}
		}
		else
		{
			unloadSceneFinish = true;
		}
		sceneLoadPath = scenePath;
		GameEntry.Scene.LoadScene(AssetUtility.GetSceneAsset(sceneLoadPath), LoadSceneMode.Additive, new LoadSceneCallbacks(LoadSceneSuccessCallback, LoadSceneFailureCallback));
		await UniTask.WaitUntil(() => loadingSceneFinish);
		if (this == null)
		{
			GameEntry.Scene.UnloadScene(AssetUtility.GetSceneAsset(scenePath), new UnloadSceneCallbacks(UnloadSceneSuccessCallback, UnloadSceneFailureCallback));
		}
		else
		{
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetSceneLoadPath(sceneLoadPath);
		}
	}

	private void LoadSceneFailureCallback(string sceneAssetName, LoadResourceStatus status, string errormessage, object userdata)
	{
		loadingSceneSuccess = false;
		loadingSceneFinish = true;
	}

	private void LoadSceneSuccessCallback(string sceneAssetName, float duration, object userdata)
	{
		loadingSceneSuccess = true;
		loadingSceneFinish = true;
		Scene sceneByPath = SceneManager.GetSceneByPath(sceneAssetName);
		SceneManager.SetActiveScene(sceneByPath);
	}

	private void UnloadSceneFailureCallback(string sceneAssetName, object userdata)
	{
		unloadSceneSuccess = false;
		unloadSceneFinish = true;
	}

	private void UnloadSceneSuccessCallback(string sceneAssetName, object userdata)
	{
		unloadSceneSuccess = true;
		unloadSceneFinish = true;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		if (towerConfigData != null)
		{
			UnityEngine.Object.Destroy(towerConfigData);
		}
		GameEntry.Resource.UnloadAsset(AssetUtility.GetActivityMapDataAsset("TowerConfig"));
		if (_systemIsInitSuccess)
		{
			SceneManager.UnloadSceneAsync(mapDataScene);
		}
		if (levelFailWindow != null)
		{
			levelFailWindow.DoHide();
			levelFailWindow.Dismiss();
			levelFailWindow = null;
		}
		CloseWindow(randomBuffDisplayVM, randomBuffDisplayWindow);
		randomBuffDisplayVM = null;
		CloseWindow(towerRandomBuffViewModel, randomBuffWindow);
		towerRandomBuffViewModel = null;
		teamConfig = null;
		curTowerFloorData = null;
		_systemIsInitSuccess = false;
	}

	private void CloseWindow(OptionBase vm, Window window)
	{
		if (vm != null)
		{
			vm.Close();
			vm = null;
			window = null;
		}
	}

	public async UniTask OpenTalentStrengthWindow(Action closeAction)
	{
		TowerTalentStrengthViewModel userData = new TowerTalentStrengthViewModel();
		await GameEntry.UI.OpenWindow<TowerTalentStrengthenWindow>("OperatingActivity/TownChallenge/TowerTalentStrengthenWindow", "DEFAULT", userData, closeAction);
	}

	public async UniTask EnterNextFloor()
	{
		towerBlackScreenVM = new TowerBlackScreenViewModel();
		if (curTowerFloorData.IsBossFloor)
		{
			TowerBlackScreenWindow towerBlackScreenWindow = await GameEntry.UI.LoadWindow<TowerBlackScreenWindow>("OperatingActivity/TownChallenge/TowerBlackScreenWindow1", towerBlackScreenVM);
			towerBlackScreenWindow.Show();
			towerBlackScreenVM.SetHideTime(towerBlackScreenWindow.HideTime);
			await UniTask.WaitForSeconds(1);
		}
		else
		{
			TowerBlackScreenWindow towerBlackScreenWindow2 = await GameEntry.UI.LoadWindow<TowerBlackScreenWindow>("OperatingActivity/TownChallenge/TowerBlackScreenWindow2", towerBlackScreenVM);
			towerBlackScreenWindow2.Show();
			towerBlackScreenVM.SetHideTime(towerBlackScreenWindow2.HideTime);
			await UniTask.WaitForSeconds(1);
		}
		climbTowerWorld.EnterNextTower();
	}

	private async UniTask ShowClimbTowerTile()
	{
		string copyName = "";
		string copyDesc = "";
		climbTowerWorld.GetCopyNameDesc(ref copyName, ref copyDesc);
		TowerTitleViewModel towerTitleViewModel = new TowerTitleViewModel(copyName, copyDesc);
		TowerTitleWindow towerTitleWindow = await GameEntry.UI.LoadWindow<TowerTitleWindow>("OperatingActivity/TownChallenge/TowerTitleWindow", towerTitleViewModel);
		if (towerTitleWindow != null)
		{
			towerTitleWindow.Show();
			await UniTask.WaitForSeconds(towerTitleWindow.ShowTime);
		}
		towerTitleViewModel.Close();
	}

	public int ShowDirUI(string iconName, Vector3 pos)
	{
		return GetSystem<BattleSystem>().AddDirUI(iconName, pos);
	}

	public void CloseDirUI(int index)
	{
		GetSystem<BattleSystem>().RemoveDirUIById(index);
	}

	private void CloseAllDirUI()
	{
		GetSystem<BattleSystem>().RemoveAllDirUI();
	}

	public async UniTask<int> ShowRandomBuffWindow(int refreshCount, List<int> holdBuffs, int copyId, List<int> achievementSelectBuffs, List<int> achievementSeeBuffs)
	{
		if (curTowerFloorData == null)
		{
			return refreshCount;
		}
		if (!curTowerFloorData.OpenRandomBuff)
		{
			return refreshCount;
		}
		if (curTowerFloorData.OpenResetRefresh)
		{
			refreshCount = curTowerFloorData.RefreshCount;
		}
		if (curTowerFloorData.ShowBuffCount <= 0)
		{
			return refreshCount;
		}
		if (curTowerFloorData.GetBuffCount <= 0)
		{
			return refreshCount;
		}
		towerRandomBuffViewModel = new TowerRandomBuffViewModel(refreshCount, curTowerFloorData.RandomPoolId, curTowerFloorData.ShowBuffCount, curTowerFloorData.GetBuffCount, copyId, holdBuffs);
		randomBuffWindow = await GameEntry.UI.LoadWindow<TowerRandomBuffWindow>("OperatingActivity/TownChallenge/TowerRandomBuffWindow", towerRandomBuffViewModel);
		randomBuffWindow.Show();
		await UniTask.WaitUntil(() => towerRandomBuffViewModel.SelectFinish);
		towerRandomBuffViewModel.AchievementBuffSend(achievementSelectBuffs, achievementSeeBuffs);
		towerRandomBuffViewModel.AddSelectBuff(holdBuffs);
		refreshCount = towerRandomBuffViewModel.RefreshCount;
		randomBuffWindow = null;
		towerRandomBuffViewModel = null;
		randomBuffDisplayVM.RefreshBuff(holdBuffs);
		return refreshCount;
	}

	private List<int> FilterAddRogueBuff(List<int> buffIds)
	{
		if (buffIds == null)
		{
			return null;
		}
		int num = 1;
		int num2 = 0;
		DRTowerBuffUp[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRTowerBuffUp>();
		int num3 = allDataRow.Length;
		_ = buffIds.Count;
		List<int> list = CollectionPool<List<int>, int>.Get();
		for (int i = 0; i < num3; i++)
		{
			DRTowerBuffUp dRTowerBuffUp = allDataRow[i];
			if (buffIds.Contains(dRTowerBuffUp.Id) && dRTowerBuffUp.Bufflv >= num)
			{
				num2 = dRTowerBuffUp.Id;
				num = dRTowerBuffUp.Bufflv;
			}
			if (dRTowerBuffUp.Bufflv == 5 && num2 != 0)
			{
				list.Add(num2);
				num2 = 0;
				num = 1;
			}
		}
		return list;
	}

	public int GetEndlessScore()
	{
		if (endlessLayer > 0)
		{
			return curTowerLayerCapacity * (endlessLayer + towerIndex + 1);
		}
		return 0;
	}
}
