using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using UnityEngine;

public class RandomMonsterSpawnWaveGizmo : MonsterSpawnWaveGizmo
{
	[Serializable]
	public class RdmMonsterSpawnInfo
	{
		[SerializeField]
		public List<StarTowerLevelController.MonsterSpawnDataList> spawnMonsterDataList;

		public int rdmMonsterNumLimit;

		public int rdmMonsterIntensityLimit;

		public int refNextWaveRemaindNum;
	}

	protected bool isTool;

	private PlayerVirtualSpawnPoint toolVirtualSpawnPoint;

	private List<long> spawnMonsters;

	protected List<RandomMonsterSpawnPointGizmo> randomMonsterSpawnPointGizmos = new List<RandomMonsterSpawnPointGizmo>();

	protected bool isFirstSpawned;

	protected GameObject objPlayerVirtualSpawnPoint;

	protected readonly Dictionary<int, PlayerVirtualSpawnPoint> PlayerVirtualSpawnPointDic = new Dictionary<int, PlayerVirtualSpawnPoint>();

	public List<StarTowerLevelController.MonsterSpawnDataList> spawnMonsterDataList;

	public int refNextWaveRemainMonsterNums;

	private int indexOfCurSpawnWave;

	private bool isAllActived;

	private bool isAllActivedAndDied;

	private bool isAllActivedAndDiedNoSummons;

	public bool limitlessMode;

	[Space]
	public HotfixEnum.fixedRoguelikeGameplayType groupIndex;

	private readonly List<StarTowerLevelController.MonsterSpawnData> tmpReplenishMonsterList = new List<StarTowerLevelController.MonsterSpawnData>();

	private int waitReplenishCount;

	private Coroutine corSpawnLogic;

	private Coroutine corReplenishMonster;

	private Dictionary<int, int> waveSurviveMonsters = new Dictionary<int, int>();

	private bool isFirstWave = true;

	private List<RandomMonsterSpawnPointGizmo> tempRandomMonsterSpawnPointGizmo;

	private bool isWaitReplenish => waitReplenishCount > 0;

	private bool IsWaveComplete => indexOfCurSpawnWave >= spawnMonsterDataList.Count - 1;

	private int GetMonsterSurviveCount(int wave)
	{
		if (waveSurviveMonsters.TryGetValue(wave, out var value))
		{
			return value;
		}
		return 0;
	}

	private int GetMonsterSurviveCount()
	{
		return GetMonsterSurviveCount(indexOfCurSpawnWave);
	}

	private void EditMonsterSurviveCount(int wave, int count)
	{
		if (!waveSurviveMonsters.TryGetValue(wave, out var _))
		{
			waveSurviveMonsters.Add(wave, count);
		}
		else
		{
			waveSurviveMonsters.set_Item(wave, count);
		}
	}

	private void EditMonsterSurviveCount(int count)
	{
		EditMonsterSurviveCount(indexOfCurSpawnWave, count);
	}

	private int AddMonsterSurviveCount(int wave)
	{
		if (!waveSurviveMonsters.TryGetValue(wave, out var value))
		{
			waveSurviveMonsters.Add(wave, 1);
		}
		else
		{
			value++;
			waveSurviveMonsters.set_Item(wave, value);
		}
		return value;
	}

	private int AddMonsterSurviveCount()
	{
		return AddMonsterSurviveCount(indexOfCurSpawnWave);
	}

	private int MinusMonsterSurviveCount(int wave)
	{
		if (!waveSurviveMonsters.TryGetValue(wave, out var value))
		{
			Debug.LogError("未知错误，联系程序:hyf");
		}
		else
		{
			value--;
			waveSurviveMonsters.set_Item(wave, value);
		}
		return value;
	}

	private int MinusMonsterSurviveCount()
	{
		return MinusMonsterSurviveCount(indexOfCurSpawnWave);
	}

	public override void EnableSpawnLogic()
	{
		if (!ActiveSelf || isSpawnEnabled || spawnMonsterDataList == null || spawnMonsterDataList.Count == 0)
		{
			return;
		}
		_logger?.LogInfo("激活刷怪点：" + name);
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null == instance)
		{
			return;
		}
		randomMonsterSpawnPointGizmos = gameObject.GetComponentsInChildren<RandomMonsterSpawnPointGizmo>().ToList();
		if (randomMonsterSpawnPointGizmos.Count == 0)
		{
			return;
		}
		isSpawnEnabled = true;
		isFirstSpawned = true;
		instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		Transform transform = gameObject.transform.parent.parent.Find("---- PlayerVirtualSpawnPoints ----");
		PlayerVirtualSpawnWave playerVirtualSpawnWave = null;
		if (null != transform)
		{
			PlayerVirtualSpawnWave[] componentsInChildren = transform.transform.GetComponentsInChildren<PlayerVirtualSpawnWave>();
			foreach (PlayerVirtualSpawnWave playerVirtualSpawnWave2 in componentsInChildren)
			{
				if (playerVirtualSpawnWave2.groupIndex == groupIndex && playerVirtualSpawnWave2.ChildCount == spawnMonsterDataList.Count)
				{
					playerVirtualSpawnWave = playerVirtualSpawnWave2;
					break;
				}
			}
			if (playerVirtualSpawnWave == null && componentsInChildren.Length != 0)
			{
				playerVirtualSpawnWave = componentsInChildren[0];
			}
		}
		if (null != playerVirtualSpawnWave)
		{
			List<PlayerVirtualSpawnPoint> list = playerVirtualSpawnWave.gameObject.GetComponentsInChildren<PlayerVirtualSpawnPoint>().ToList();
			if (list != null)
			{
				for (int j = 0; j < list.Count; j++)
				{
					PlayerVirtualSpawnPointDic.set_Item(list.get_Item(j).waveIndex, list.get_Item(j));
				}
			}
		}
		spawnMonsters = new List<long>();
	}

	protected override void OnDeactive()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (!(null == instance))
		{
			instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
			if (corSpawnLogic != null)
			{
				StopCoroutine(corSpawnLogic);
			}
			if (corReplenishMonster != null)
			{
				StopCoroutine(corReplenishMonster);
			}
			corSpawnLogic = null;
			corReplenishMonster = null;
		}
	}

	private bool ContainsSpawnMonster(long id)
	{
		if (spawnMonsters == null)
		{
			return false;
		}
		for (int i = 0; i < spawnMonsters.Count; i++)
		{
			if (id == spawnMonsters.get_Item(i))
			{
				spawnMonsters.RemoveAt(i);
				return true;
			}
		}
		return false;
	}

	protected void MonsterDied(IEvent ievent)
	{
		if (!isSpawnActived || ievent == null)
		{
			return;
		}
		object sender = ievent.sender;
		int dataId;
		int monsterSpawnIndex;
		if (sender == null)
		{
			_logger.LogError("怪物死亡消息的发送者为空!");
		}
		else if (!(sender is MonsterAdventureActor monsterAdventureActor))
		{
			_logger.LogError("怪物死亡消息的发送者类型错误!");
		}
		else
		{
			if (monsterAdventureActor.monsterSummonInfo != null && monsterAdventureActor.monsterSummonInfo.SummonActor != null)
			{
				return;
			}
			AdventureMonsterDiedEvent adventureMonsterDiedEvent = (AdventureMonsterDiedEvent)ievent;
			dataId = adventureMonsterDiedEvent.monsterID;
			long num = adventureMonsterDiedEvent.id;
			if (!ContainsSpawnMonster(num))
			{
				_logger.LogError($"{name} 波次怪物死亡时没有找到相应的怪物:怪物ID_{adventureMonsterDiedEvent.monsterID} 唯一ID_{adventureMonsterDiedEvent.id}!");
				return;
			}
			monsterSpawnIndex = adventureMonsterDiedEvent.indexOfSpawnWave;
			CheckRefreshCurWaveMonster();
			if (IsAllCleared())
			{
				Cleared();
			}
			else
			{
				if (!IsRefreshNextWave() || IsWaveComplete || !spawnMonsterDataList.get_Item(indexOfCurSpawnWave).IsInRefreshing)
				{
					return;
				}
				indexOfCurSpawnWave++;
				if (indexOfCurSpawnWave >= PlayerVirtualSpawnPointDic.Count)
				{
					Cleared();
					return;
				}
				float delayTime = 0f;
				if (PlayerVirtualSpawnPointDic.TryGetValue(indexOfCurSpawnWave, out var value))
				{
					delayTime = value.waveRefreshInterval;
				}
				corSpawnLogic = StartCoroutine(CorSpawnLogic(delayTime, indexOfCurSpawnWave));
			}
		}
		void CheckRefreshCurWaveMonster()
		{
			if (spawnMonsterDataList != null && spawnMonsterDataList.Count != 0 && monsterSpawnIndex < spawnMonsterDataList.Count)
			{
				StarTowerLevelController.MonsterSpawnDataList monsterSpawnDataList = spawnMonsterDataList.get_Item(monsterSpawnIndex);
				if (monsterSpawnDataList != null)
				{
					List<StarTowerLevelController.MonsterSpawnData> monsterSpawnDatas = monsterSpawnDataList.monsterSpawnDatas;
					if (monsterSpawnDatas != null && monsterSpawnDatas.Count != 0)
					{
						for (int i = 0; i < monsterSpawnDatas.Count; i++)
						{
							StarTowerLevelController.MonsterSpawnData monsterSpawnData = monsterSpawnDatas.get_Item(i);
							if (monsterSpawnData.monsterId == dataId)
							{
								monsterSpawnData.curWaveRemaindNum--;
								if (monsterSpawnData.curWaveRemaindNum <= monsterSpawnData.maxNum / 2)
								{
									int num2 = monsterSpawnData.maxNum - monsterSpawnData.curWaveRemaindNum;
									if (num2 == 0)
									{
										break;
									}
									num2 = Mathf.Min(num2, monsterSpawnData.waveMaxNum - monsterSpawnData.curWaveMonsterNum);
									monsterSpawnData.curWaveRemaindNum += num2;
									monsterSpawnData.curWaveMonsterNum += num2;
									RefreshCurWaveMonster(monsterSpawnData, num2);
								}
								monsterSpawnDatas.set_Item(i, monsterSpawnData);
								break;
							}
						}
					}
				}
			}
		}
		bool IsAllCleared()
		{
			if (spawnMonsterDataList == null || spawnMonsterDataList.Count == 0)
			{
				return true;
			}
			for (int i = 0; i < spawnMonsterDataList.Count; i++)
			{
				StarTowerLevelController.MonsterSpawnDataList monsterSpawnDataList = spawnMonsterDataList.get_Item(i);
				if (monsterSpawnDataList.WaveRemaindNum > 0 || monsterSpawnDataList.WaveSurviveMonsterNum > 0)
				{
					return false;
				}
			}
			return true;
		}
		bool IsRefreshNextWave()
		{
			if (spawnMonsterDataList == null || spawnMonsterDataList.Count == 0)
			{
				return false;
			}
			int num2 = 0;
			for (int i = 0; i < spawnMonsterDataList.Count; i++)
			{
				StarTowerLevelController.MonsterSpawnDataList monsterSpawnDataList = spawnMonsterDataList.get_Item(i);
				if (monsterSpawnDataList.IsInRefreshing)
				{
					num2 += monsterSpawnDataList.WaveRemaindNum;
				}
			}
			return num2 <= refNextWaveRemainMonsterNums;
		}
		void RefreshCurWaveMonster(StarTowerLevelController.MonsterSpawnData data, int refNum)
		{
			if (refNum > 0)
			{
				for (int i = 0; i < refNum; i++)
				{
					waitReplenishCount++;
					PlayerVirtualSpawnPoint playerVirtualSpawnPoint = PlayerVirtualSpawnPointDic.get_Item(indexOfCurSpawnWave + 1);
					if (playerVirtualSpawnPoint.replenishMonsterInterval > 0f)
					{
						StartCoroutine(CorReplenishMonster(playerVirtualSpawnPoint.replenishMonsterInterval, playerVirtualSpawnPoint.isReplenishMonsterSameTimeBattle, monsterSpawnIndex, data.monsterId));
					}
					else
					{
						DoCorReplenishMonster(playerVirtualSpawnPoint.isReplenishMonsterSameTimeBattle, monsterSpawnIndex, data.monsterId);
					}
				}
			}
		}
	}

	private void Cleared()
	{
		if (limitlessMode)
		{
			Restart();
			return;
		}
		isAllActivedAndDied = true;
		isAllActivedAndDiedNoSummons = true;
	}

	private IEnumerator CorReplenishMonster(float delayTime, bool isSameTimeBattle, int indexOfSpawnWave, int monsterID)
	{
		yield return new WaitForSeconds(delayTime);
		DoCorReplenishMonster(isSameTimeBattle, indexOfSpawnWave, monsterID);
	}

	private void DoCorReplenishMonster(bool isSameTimeBattle, int indexOfSpawnWave, int monsterID)
	{
		RandomMonsterSpawnPointGizmo randomMonsterSpawnPointGizmo = RandomOneMonsterPoint(monsterID);
		randomMonsterSpawnPointGizmo.JumpOverBornPerformance();
		if (!isTool)
		{
			SpawnMonster(randomMonsterSpawnPointGizmo, indexOfSpawnWave, isSameTimeBattle, isReplenish: true);
		}
	}

	private IEnumerator CorSpawnLogic(float delayTime, int indexOfSpawnWave)
	{
		yield return new WaitForSeconds(delayTime);
		DoExecuteSpawnLogic(indexOfSpawnWave);
	}

	private void DoExecuteSpawnLogic(int index)
	{
		int num = indexOfCurSpawnWave;
		indexOfCurSpawnWave = index;
		ExecuteSpawnLogic();
		indexOfCurSpawnWave = num;
	}

	protected Vector3 getPlayerPos()
	{
		Vector3 result = Vector3.zero;
		if (!isTool)
		{
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (activedPlayerActor != null)
			{
				result = activedPlayerActor.transform.position;
			}
		}
		else
		{
			result = toolVirtualSpawnPoint.transform.position;
		}
		return result;
	}

	public void InitSpawnMonsterDatas(RdmMonsterSpawnInfo spawnInfo, bool limitlessMode = false)
	{
		spawnMonsterDataList = spawnInfo.spawnMonsterDataList;
		refNextWaveRemainMonsterNums = spawnInfo.refNextWaveRemaindNum;
		indexOfCurSpawnWave = 0;
		this.limitlessMode = limitlessMode;
		if (spawnMonsterDataList == null || spawnMonsterDataList.Count == 0)
		{
			_logger.LogError("怪物出生数据为空!");
		}
	}

	public void Restart()
	{
		indexOfCurSpawnWave = 0;
		isAllActived = false;
		isAllActivedAndDied = false;
		isFirstSpawned = true;
		spawnMonsters?.Clear();
		isAllActivedAndDiedNoSummons = false;
		for (int i = 0; i < spawnMonsterDataList.Count; i++)
		{
			List<StarTowerLevelController.MonsterSpawnData> monsterSpawnDatas = spawnMonsterDataList.get_Item(i).monsterSpawnDatas;
			if (monsterSpawnDatas != null)
			{
				for (int j = 0; j < monsterSpawnDatas.Count; j++)
				{
					StarTowerLevelController.MonsterSpawnData value = monsterSpawnDatas.get_Item(j);
					value.curWaveMonsterNum = 0;
					monsterSpawnDatas.set_Item(j, value);
				}
			}
		}
		ExecuteSpawnLogic();
	}

	public void ExecuteExtrlSpawnLogic(StarTowerLevelController.MonsterSpawnData monsterSpawnData, int callSpawnSrc = 0, bool includeInStatistics = true)
	{
		bool flag = PlayerVirtualSpawnPointDic.get_Item(indexOfCurSpawnWave + 1).isInitialMonsterSameTimeBattle && indexOfCurSpawnWave == 0;
		Mathf.Min(monsterSpawnData.maxNum, monsterSpawnData.waveMaxNum);
		for (int i = 0; i < monsterSpawnData.waveMaxNum; i++)
		{
			RandomMonsterSpawnPointGizmo randomMonsterSpawnPointGizmo = RandomOneMonsterPoint(indexOfCurSpawnWave + 1, monsterSpawnData);
			randomMonsterSpawnPointGizmo.JumpOverBornPerformance(flag);
			SpawnMonster(randomMonsterSpawnPointGizmo, -1, flag, isReplenish: false, includeInStatistics, callSpawnSrc);
		}
	}

	public override void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
		if (spawnMonsterDataList == null || spawnMonsterDataList.Count == 0)
		{
			return;
		}
		if (indexOfCurSpawnWave >= spawnMonsterDataList.Count)
		{
			_logger.LogError($"随机怪物出生点数组下标越界!{indexOfCurSpawnWave}_{spawnMonsterDataList.Count}");
			return;
		}
		StarTowerLevelController.MonsterSpawnDataList monsterSpawnDataList = spawnMonsterDataList.get_Item(indexOfCurSpawnWave);
		if (monsterSpawnDataList == null)
		{
			_logger.LogError("怪物出生数据为空!");
			return;
		}
		List<StarTowerLevelController.MonsterSpawnData> monsterSpawnDatas = monsterSpawnDataList.monsterSpawnDatas;
		if (monsterSpawnDatas == null || monsterSpawnDatas.Count == 0)
		{
			_logger.LogError("怪物出生数据为空!");
			return;
		}
		monsterSpawnDatas.Sort((StarTowerLevelController.MonsterSpawnData a, StarTowerLevelController.MonsterSpawnData b) =>
		{
			StarTowerMonsterSpAttr starTowerMonsterSpAttr2 = Singleton<HotfixDataController>.Instance.GetStarTowerMonsterSpAttr(a.monsterId);
			StarTowerMonsterSpAttr starTowerMonsterSpAttr3 = Singleton<HotfixDataController>.Instance.GetStarTowerMonsterSpAttr(b.monsterId);
			if (starTowerMonsterSpAttr2 == null || starTowerMonsterSpAttr3 == null)
			{
				return -1;
			}
			if (starTowerMonsterSpAttr2.RefInterval < starTowerMonsterSpAttr3.RefInterval)
			{
				return -1;
			}
			return (starTowerMonsterSpAttr2.RefInterval > starTowerMonsterSpAttr3.RefInterval) ? 1 : 0;
		});
		isFirstSpawned = false;
		if (indexOfCurSpawnWave >= PlayerVirtualSpawnPointDic.Count)
		{
			return;
		}
		PlayerVirtualSpawnPoint playerVirtualSpawnPoint = PlayerVirtualSpawnPointDic.get_Item(indexOfCurSpawnWave + 1);
		bool flag = playerVirtualSpawnPoint.isInitialMonsterSameTimeBattle && indexOfCurSpawnWave == 0;
		List<MonsterStrollSchemes.MonsterStrollScheme> schemes = null;
		if (playerVirtualSpawnPoint.MonsterStrollSchemes != null)
		{
			schemes = playerVirtualSpawnPoint.MonsterStrollSchemes.ToList();
		}
		HotfixDataController instance = Singleton<HotfixDataController>.Instance;
		for (int num = 0; num < monsterSpawnDatas.Count; num++)
		{
			StarTowerLevelController.MonsterSpawnData monsterSpawnData = monsterSpawnDatas.get_Item(num);
			StarTowerMonsterSpAttr starTowerMonsterSpAttr = instance.GetStarTowerMonsterSpAttr(monsterSpawnData.monsterId);
			if (starTowerMonsterSpAttr == null)
			{
				Debug.LogError($"怪物数据缺失，ID：{monsterSpawnData.monsterId}");
				continue;
			}
			bool flag2 = isFirstWave && starTowerMonsterSpAttr.WayPointShift;
			int num2 = Mathf.Min(monsterSpawnData.maxNum, monsterSpawnData.waveMaxNum);
			for (int num3 = 0; num3 < num2; num3++)
			{
				RandomMonsterSpawnPointGizmo randomMonsterSpawnPointGizmo = RandomOneMonsterPoint(indexOfCurSpawnWave + 1, monsterSpawnData);
				randomMonsterSpawnPointGizmo.JumpOverBornPerformance(flag);
				MonsterStrollSchemes.MonsterStrollScheme strollScheme = null;
				if (flag2)
				{
					strollScheme = GetAScheme(randomMonsterSpawnPointGizmo.transform.position);
				}
				SpawnMonster(randomMonsterSpawnPointGizmo, indexOfCurSpawnWave, flag, isReplenish: false, doCallback: true, 0, strollScheme);
			}
			monsterSpawnData.curWaveMonsterNum = num2;
			monsterSpawnData.curWaveRemaindNum = num2;
			monsterSpawnDatas.set_Item(num, monsterSpawnData);
		}
		AdventureFixedRandomWaveActived adventureFixedRandomWaveActived = AdventureFixedRandomWaveActived.Generate();
		adventureFixedRandomWaveActived.isFinalWave = isAllActived;
		adventureFixedRandomWaveActived.isFirstWave = isFirstWave;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureFixedRandomWaveActived);
		isSpawnActived = true;
		isFirstWave = false;
		MonsterStrollSchemes.MonsterStrollScheme GetAScheme(Vector3 position)
		{
			if (schemes == null || schemes.Count == 0)
			{
				return null;
			}
			float num4 = float.MaxValue;
			MonsterStrollSchemes.MonsterStrollScheme result = null;
			int num5 = -1;
			for (int i = 0; i < schemes.Count; i++)
			{
				MonsterStrollSchemes.MonsterStrollScheme monsterStrollScheme = schemes.get_Item(i);
				Vector3[] array = monsterStrollScheme?.GetPoints3();
				if (array != null && array.Length != 0)
				{
					Vector3 vector = array[0];
					float num6 = Vector2.Distance(new Vector2(position.x, position.z), new Vector2(vector.x, vector.z));
					if (num6 < num4)
					{
						num4 = num6;
						result = monsterStrollScheme;
						num5 = i;
					}
				}
			}
			if (num5 >= 0)
			{
				schemes.RemoveAt(num5);
			}
			return result;
		}
	}

	private void MonsterSpawned(long id, bool isReplenish)
	{
		spawnMonsters.Add(id);
		if (isReplenish)
		{
			waitReplenishCount--;
		}
		AddMonsterSurviveCount();
	}

	private void SpawnMonster(RandomMonsterSpawnPointGizmo gizmo, int indexOfSpawnWave, bool enterActionWhenSpawned = false, bool isReplenish = false, bool doCallback = true, int callSpawnSrc = 0, MonsterStrollSchemes.MonsterStrollScheme strollScheme = null)
	{
		gizmo.callSpawnSrc = callSpawnSrc;
		if (doCallback)
		{
			gizmo.SetSpawnCallback(MonsterSpawned, isReplenish);
		}
		gizmo.enterActionWhenSpawned = enterActionWhenSpawned;
		gizmo.strollScheme = strollScheme;
		gizmo.indexOfSpawnWave = indexOfSpawnWave;
		gizmo.ExecuteSpawnLogic();
	}

	protected RandomMonsterSpawnPointGizmo RandomOneMonsterPoint(int monsterId)
	{
		Vector3 playerPos = getPlayerPos();
		List<Vector3> list = new List<Vector3>();
		if (spawnMonsters.Count != 0)
		{
			AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
			for (int i = 0; i < spawnMonsters.Count; i++)
			{
				long num = spawnMonsters.get_Item(i);
				LogicEntity logicEntity = instance.QueryEntityByID(num);
				if (!(null == logicEntity))
				{
					list.Add(logicEntity.transform.position);
				}
			}
		}
		StarTowerMonsterSpAttr starTowerMonsterSpAttr = Singleton<HotfixDataController>.Instance.GetStarTowerMonsterSpAttr(monsterId);
		int refDistanceMin = starTowerMonsterSpAttr.RefDistance.get_Item(0);
		int refDistanceMax = starTowerMonsterSpAttr.RefDistance.get_Item(1);
		float refIntervalRadius = (float)starTowerMonsterSpAttr.RefInterval / 10000f;
		return FindFitPoint(monsterId, playerPos, refDistanceMin, refDistanceMax, refIntervalRadius, list);
	}

	protected RandomMonsterSpawnPointGizmo FindFitPoint(int monsterId, Vector3 playerPos, int refDistanceMin, int refDistanceMax, float refIntervalRadius, List<Vector3> tempMonsterPos)
	{
		if (tempRandomMonsterSpawnPointGizmo == null)
		{
			tempRandomMonsterSpawnPointGizmo = new List<RandomMonsterSpawnPointGizmo>();
		}
		tempRandomMonsterSpawnPointGizmo.Clear();
		for (int i = 0; i < randomMonsterSpawnPointGizmos.Count; i++)
		{
			if (randomMonsterSpawnPointGizmos.get_Item(i).monsterID != 0)
			{
				continue;
			}
			Vector3 position = randomMonsterSpawnPointGizmos.get_Item(i).transform.position;
			float num = Vector3.Distance(playerPos, position);
			if (!((float)refDistanceMin <= num) || !(num <= (float)refDistanceMax))
			{
				continue;
			}
			bool flag = false;
			for (int j = 0; j < tempMonsterPos.Count; j++)
			{
				if (Vector3.Distance(position, tempMonsterPos.get_Item(j)) < refIntervalRadius)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				tempRandomMonsterSpawnPointGizmo.Add(randomMonsterSpawnPointGizmos.get_Item(i));
			}
		}
		if (tempRandomMonsterSpawnPointGizmo.Count > 0)
		{
			int index = Random(0, tempRandomMonsterSpawnPointGizmo.Count);
			RandomMonsterSpawnPointGizmo randomMonsterSpawnPointGizmo = tempRandomMonsterSpawnPointGizmo.get_Item(index);
			randomMonsterSpawnPointGizmo.monsterID = monsterId;
			tempMonsterPos.Add(randomMonsterSpawnPointGizmo.transform.position);
			return randomMonsterSpawnPointGizmo;
		}
		return FindFitPoint(monsterId, playerPos, refDistanceMin, refDistanceMax + 1, refIntervalRadius, tempMonsterPos);
	}

	protected RandomMonsterSpawnPointGizmo RandomOneMonsterPoint(int waveIndex, StarTowerLevelController.MonsterSpawnData data)
	{
		StarTowerMonsterSpAttr starTowerMonsterSpAttr = Singleton<HotfixDataController>.Instance.GetStarTowerMonsterSpAttr(data.monsterId);
		if (starTowerMonsterSpAttr == null)
		{
			_logger.LogError($"FixedRoguelikeMonsterSpAttrData 表 id ==== {data.monsterId} 缺失");
			for (int i = 0; i < randomMonsterSpawnPointGizmos.Count; i++)
			{
				if (randomMonsterSpawnPointGizmos.get_Item(i).monsterID == 0)
				{
					return randomMonsterSpawnPointGizmos.get_Item(i);
				}
			}
		}
		bool flag = starTowerMonsterSpAttr != null && starTowerMonsterSpAttr.MonsterPosition == 1;
		if (!PlayerVirtualSpawnPointDic.TryGetValue(waveIndex, out var value))
		{
			Debug.Log("玩家虚拟位置不存在 波次==== " + waveIndex);
			return RandomOneMonsterPoint(data.monsterId);
		}
		float refIntervalRadius = (float)starTowerMonsterSpAttr.RefInterval / 10000f;
		List<Vector3> list = new List<Vector3>();
		Dictionary<int, List<Vector3>> tempSimilarMonsterPos = new Dictionary<int, List<Vector3>>();
		if (spawnMonsters.Count != 0)
		{
			AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
			for (int j = 0; j < spawnMonsters.Count; j++)
			{
				long num = spawnMonsters.get_Item(j);
				LogicEntity logicEntity = instance.QueryEntityByID(num);
				if (!(null == logicEntity))
				{
					list.Add(logicEntity.transform.position);
				}
			}
		}
		if (flag)
		{
			float rotation = value.meleeRotation * value.transform.lossyScale.x;
			return FindFitPointFan(data, value, value.meleeInnerRadius, value.meleeOuterRadius, value.meleeAngle, rotation, refIntervalRadius, data.refInterval, list, tempSimilarMonsterPos, 0);
		}
		float rotation2 = value.remotelyRotation * value.transform.lossyScale.x;
		return FindFitPointFan(data, value, value.remotelyInnerRadius, value.remotelyOuterRadius, value.remotelyAngle, rotation2, refIntervalRadius, data.refInterval, list, tempSimilarMonsterPos, 0);
	}

	private bool isInFan(GameObject obj, Vector3 point, float fanRot, float fanAngle, Transform center)
	{
		Vector2 to = new Vector2(point.x - center.position.x, point.z - center.position.z);
		fanRot = NormalizeAngle(fanRot * -1f);
		Vector3 forward = center.forward;
		return Vector2.Angle(MathMisc.Rotate(new Vector2(forward.x, forward.z), fanRot), to) <= fanAngle / 2f;
	}

	private float NormalizeAngle(float angle)
	{
		while (angle < 0f)
		{
			angle += 360f;
		}
		while (angle >= 360f)
		{
			angle -= 360f;
		}
		return angle;
	}

	protected RandomMonsterSpawnPointGizmo FindFitPointFan(StarTowerLevelController.MonsterSpawnData data, PlayerVirtualSpawnPoint point, float innerRadius, float outerRadius, float Angle, float Rotation, float refIntervalRadius, float similarInterval, List<Vector3> tempMonsterPos, Dictionary<int, List<Vector3>> tempSimilarMonsterPos, int rCount)
	{
		if (tempRandomMonsterSpawnPointGizmo == null)
		{
			tempRandomMonsterSpawnPointGizmo = new List<RandomMonsterSpawnPointGizmo>();
		}
		tempRandomMonsterSpawnPointGizmo.Clear();
		for (int i = 0; i < randomMonsterSpawnPointGizmos.Count; i++)
		{
			if (randomMonsterSpawnPointGizmos.get_Item(i).monsterID != 0)
			{
				continue;
			}
			Vector3 position = randomMonsterSpawnPointGizmos.get_Item(i).transform.position;
			float num = Vector3.Distance(point.transform.position, position);
			if (!(innerRadius <= num) || !(num <= outerRadius) || !isInFan(randomMonsterSpawnPointGizmos.get_Item(i).gameObject, randomMonsterSpawnPointGizmos.get_Item(i).transform.position, Rotation, Angle, point.transform))
			{
				continue;
			}
			bool flag = false;
			for (int j = 0; j < tempMonsterPos.Count; j++)
			{
				if (Vector3.Distance(position, tempMonsterPos.get_Item(j)) < refIntervalRadius)
				{
					flag = true;
					break;
				}
			}
			if (tempSimilarMonsterPos.ContainsKey(data.monsterId))
			{
				for (int k = 0; k < tempSimilarMonsterPos.get_Item(data.monsterId).Count; k++)
				{
					if (Vector3.Distance(position, tempSimilarMonsterPos.get_Item(data.monsterId).get_Item(k)) < similarInterval)
					{
						flag = true;
						break;
					}
				}
			}
			if (!flag)
			{
				tempRandomMonsterSpawnPointGizmo.Add(randomMonsterSpawnPointGizmos.get_Item(i));
			}
		}
		if (tempRandomMonsterSpawnPointGizmo.Count > 0)
		{
			int index = Random(0, tempRandomMonsterSpawnPointGizmo.Count);
			RandomMonsterSpawnPointGizmo randomMonsterSpawnPointGizmo = tempRandomMonsterSpawnPointGizmo.get_Item(index);
			randomMonsterSpawnPointGizmo.monsterID = data.monsterId;
			tempMonsterPos.Add(randomMonsterSpawnPointGizmo.transform.position);
			if (tempSimilarMonsterPos.ContainsKey(data.monsterId))
			{
				tempSimilarMonsterPos.get_Item(data.monsterId).Add(randomMonsterSpawnPointGizmo.transform.position);
			}
			else
			{
				List<Vector3> list = new List<Vector3>();
				list.Add(randomMonsterSpawnPointGizmo.transform.position);
				tempSimilarMonsterPos.Add(data.monsterId, list);
			}
			return randomMonsterSpawnPointGizmo;
		}
		int num2 = rCount + 1;
		switch (rCount)
		{
		case 1:
			similarInterval = 0f;
			break;
		case 2:
			innerRadius = 0f;
			break;
		case 3:
			outerRadius = 999f;
			break;
		default:
			refIntervalRadius = 0f;
			Debug.LogWarning($"没有符合规则选取的点 波次{indexOfCurSpawnWave} ，怪物id{data.monsterId}");
			break;
		}
		if (num2 < 5)
		{
			return FindFitPointFan(data, point, innerRadius, outerRadius, Angle, Rotation, refIntervalRadius, similarInterval, tempMonsterPos, tempSimilarMonsterPos, num2);
		}
		return RandomOneMonsterPoint(data.monsterId);
	}

	public int Random(int min, int max)
	{
		int result = min;
		if (Application.isPlaying)
		{
			if (null != MonoSingleton<GameController>.Instance)
			{
				result = MonoSingleton<GameController>.Instance.Random_Roguelike(min, max);
			}
			else
			{
				_logger.LogInfo("缺少[GameController.cs]");
			}
		}
		return result;
	}

	public override bool IsAllActivedAndDied()
	{
		if (isSpawnEnabled)
		{
			return isAllActivedAndDied;
		}
		return true;
	}

	public override bool IsAllActived()
	{
		if (isSpawnEnabled)
		{
			return isAllActived;
		}
		return true;
	}

	public override bool IsAllActivedAndDied_NoSummons()
	{
		if (isSpawnEnabled)
		{
			return isAllActivedAndDiedNoSummons;
		}
		return true;
	}

	public void FinishSpawnLogic()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		isSpawnActived = false;
		if (corSpawnLogic != null)
		{
			StopCoroutine(corSpawnLogic);
		}
		if (corReplenishMonster != null)
		{
			StopCoroutine(corReplenishMonster);
		}
		corSpawnLogic = null;
		corReplenishMonster = null;
	}
}
