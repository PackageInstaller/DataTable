using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class VampireMonsterSpawnWaveGizmo : BaseSpawnPointGizmo
{
	public class tmpVMSet
	{
		public int setId;

		public int groupNum;

		public int monsterId;

		public int monsterLevel;

		public int levelChange;

		public int delayTime;

		public bool isSpwan;

		public int maxNum;

		public int killCount;

		public int addCount;

		public int addDelay;

		public bool isWaitAdd;

		public int addWaitStartSec;

		public int maxNumAddDelay;

		public int maxNumAddMonsterCount;

		public int maxNumAddWaveCount;

		public int maxNumAddCount;

		public int spawnType;

		public int monsterPoint;

		public int dropExpId;

		public int dropExpVal;

		public int dropChestId;

		public int dropHpId;

		public int dropMpId;

		public int dropAtkId;

		public int dropGetId;

		public int dropClearId;

		public int monsterWarning;

		public int SpawnWave;
	}

	public class tmpDropMsg
	{
		public int dropProb;

		public int growthProb;

		public int dropMaxCount;

		public int realDropProb;

		public int growthTime;

		public bool isDrop;

		public int dropTime;

		public int dropCount;
	}

	public class tmpMonsterInfo
	{
		public int waveNum;

		public int groupNum;
	}

	protected readonly System.Random _random = new System.Random();

	protected Dictionary<int, VampireEnemyPool> vEPoolDic = new Dictionary<int, VampireEnemyPool>();

	protected Dictionary<int, List<tmpVMSet>> setDic = new Dictionary<int, List<tmpVMSet>>();

	protected Dictionary<long, tmpMonsterInfo> monsterSpwanInfoDic = new Dictionary<long, tmpMonsterInfo>();

	protected int haveMonsterCount;

	protected int totalWaveNum;

	protected int currentWaveNum;

	protected VampireEnemyPool curPool;

	protected int waveKeepTime;

	protected int curWaveRunTime;

	protected PlayerAdventureActor mainCtrActor;

	protected List<VampireMonsterSpawnPointGizmo> pointList;

	protected Action actionSuccess;

	protected Action<bool> actionFailed;

	protected bool isLastWave;

	protected bool isSendBossSpawn;

	protected int lastBossCount;

	protected int lastWaveTime;

	protected bool isSettlement;

	protected int VampireMonsterMaxCount;

	protected int SpecialSpawnWaveCount;

	protected Dictionary<int, List<tmpVMSet>> SpecialWaveDic = new Dictionary<int, List<tmpVMSet>>();

	protected Dictionary<int, int> SpecialWaveMonsterCount = new Dictionary<int, int>();

	protected Dictionary<int, int> SpecialWaveMonsterKillCount = new Dictionary<int, int>();

	protected int TreasureSpawnWaveCount = -100;

	protected bool isCurrentHaveTips;

	protected Dictionary<int, tmpDropMsg> dropDic = new Dictionary<int, tmpDropMsg>();

	protected string SpecialEnemySetId;

	protected string TreasureSetId;

	protected bool showGMMonsterCount;

	public void InitSpawnMonsterDatas(List<VampireEnemyPool> poolList, Action successCB, Action<bool> failedCB, List<VampireDropData> listDropData, string specialEnemySetId, string treasureSetId)
	{
		haveMonsterCount = 0;
		SpecialSpawnWaveCount = 0;
		TreasureSpawnWaveCount = -100;
		isLastWave = false;
		isSendBossSpawn = false;
		lastBossCount = 0;
		isSettlement = false;
		lastWaveTime = 0;
		VampireMonsterMaxCount = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("VampireMonsterMaxCount").Value);
		SpecialEnemySetId = specialEnemySetId;
		TreasureSetId = treasureSetId;
		for (int i = 0; i < poolList.Count; i++)
		{
			vEPoolDic.set_Item(poolList.get_Item(i).WaveNum, poolList.get_Item(i));
		}
		totalWaveNum = poolList.Count;
		currentWaveNum = 0;
		actionSuccess = successCB;
		actionFailed = failedCB;
		lastWaveTime = vEPoolDic.get_Item(totalWaveNum).WaveKeepTime;
		pointList = gameObject.GetComponentsInChildren<VampireMonsterSpawnPointGizmo>().ToList();
		for (int j = 0; j < listDropData.Count; j++)
		{
			tmpDropMsg tmpDropMsg2 = new tmpDropMsg();
			VampireDropData vampireDropData = listDropData.get_Item(j);
			tmpDropMsg2.dropProb = vampireDropData.DropProb;
			tmpDropMsg2.growthProb = vampireDropData.GrowthProb;
			tmpDropMsg2.dropMaxCount = vampireDropData.DropMaxCount;
			tmpDropMsg2.realDropProb = vampireDropData.DropProb;
			tmpDropMsg2.growthTime = 0;
			tmpDropMsg2.isDrop = false;
			tmpDropMsg2.dropTime = 0;
			tmpDropMsg2.dropCount = 0;
			dropDic.set_Item(vampireDropData.DropId, tmpDropMsg2);
		}
	}

	public override void EnableSpawnLogic()
	{
		if (ActiveSelf && !isSpawnEnabled)
		{
			isSpawnEnabled = true;
			AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
			if (!(null == instance))
			{
				instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
				Singleton<EventDispatchManager>.Instance?.AddEventListener("GM_ShowMonsterCount", GMShowMonsterCount);
			}
		}
	}

	protected override void OnDeactive()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (!(null == instance))
		{
			Singleton<EventDispatchManager>.Instance?.RemoveEventListener("GM_ShowMonsterCount", GMShowMonsterCount);
			instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
			vEPoolDic.Clear();
			setDic.Clear();
			monsterSpwanInfoDic.Clear();
			pointList?.Clear();
			mainCtrActor = null;
			curPool = null;
			SpecialWaveDic.Clear();
			SpecialWaveMonsterCount.Clear();
			SpecialWaveMonsterKillCount.Clear();
			dropDic.Clear();
			StopAllCoroutines();
		}
	}

	public override void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
	}

	public void SpwanWaveMonster()
	{
		if (mainCtrActor == null)
		{
			mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		}
		currentWaveNum++;
		if (currentWaveNum == totalWaveNum)
		{
			isLastWave = true;
		}
		isCurrentHaveTips = false;
		if (currentWaveNum > totalWaveNum)
		{
			return;
		}
		curPool = vEPoolDic.get_Item(currentWaveNum);
		waveKeepTime = curPool.WaveKeepTime;
		curWaveRunTime = 0;
		int enemySetID = curPool.EnemySetID;
		List<tmpVMSet> list = new List<tmpVMSet>();
		List<VampireEnemySet> vampireEnemySetData = Singleton<HotfixDataController>.Instance.VampireEnemySetData;
		for (int i = 0; i < vampireEnemySetData.Count; i++)
		{
			if (enemySetID == vampireEnemySetData.get_Item(i).SetId)
			{
				VampireEnemySet vampireEnemySet = vampireEnemySetData.get_Item(i);
				tmpVMSet item = new tmpVMSet
				{
					setId = vampireEnemySet.SetId,
					groupNum = vampireEnemySet.GroupNum,
					monsterId = vampireEnemySet.MonsterId,
					monsterLevel = curPool.MonsterLevel,
					levelChange = vampireEnemySet.LevelChange,
					delayTime = vampireEnemySet.DelayTime,
					isSpwan = false,
					maxNum = vampireEnemySet.MaxNum,
					killCount = 0,
					addCount = ((vampireEnemySet.AddData.Count > 1) ? vampireEnemySet.AddData.get_Item(0) : 0),
					addDelay = ((vampireEnemySet.AddData.Count > 1) ? vampireEnemySet.AddData.get_Item(1) : 0),
					maxNumAddDelay = ((vampireEnemySet.MaxNumImproveData.Count > 2) ? vampireEnemySet.MaxNumImproveData.get_Item(0) : 0),
					maxNumAddMonsterCount = ((vampireEnemySet.MaxNumImproveData.Count > 2) ? vampireEnemySet.MaxNumImproveData.get_Item(1) : 0),
					maxNumAddWaveCount = ((vampireEnemySet.MaxNumImproveData.Count > 2) ? vampireEnemySet.MaxNumImproveData.get_Item(2) : 0),
					maxNumAddCount = 0,
					spawnType = vampireEnemySet.MonsterSpawnType,
					monsterPoint = vampireEnemySet.MonsterPoint,
					dropExpId = ((vampireEnemySet.DropExp.Count > 1) ? vampireEnemySet.DropExp.get_Item(0) : 0),
					dropExpVal = ((vampireEnemySet.DropExp.Count > 1) ? vampireEnemySet.DropExp.get_Item(1) : 0),
					dropChestId = ((vampireEnemySet.DropChest.Count > 0) ? vampireEnemySet.DropChest.get_Item(0) : 0),
					dropHpId = ((vampireEnemySet.DropHp.Count > 0) ? vampireEnemySet.DropHp.get_Item(0) : 0),
					dropMpId = ((vampireEnemySet.DropMp.Count > 0) ? vampireEnemySet.DropMp.get_Item(0) : 0),
					dropAtkId = ((vampireEnemySet.DropAtk.Count > 0) ? vampireEnemySet.DropAtk.get_Item(0) : 0),
					dropGetId = ((vampireEnemySet.DropGet.Count > 0) ? vampireEnemySet.DropGet.get_Item(0) : 0),
					dropClearId = ((vampireEnemySet.DropClear.Count > 0) ? vampireEnemySet.DropClear.get_Item(0) : 0),
					monsterWarning = vampireEnemySet.MonsterWarning,
					SpawnWave = curPool.WaveNum
				};
				list.Add(item);
				if (isLastWave && vampireEnemySet.MonsterWarning == 1)
				{
					lastBossCount++;
				}
			}
		}
		setDic.set_Item(currentWaveNum, list);
		MonsterFindPointSpawn();
		SetSpecialEnemy();
		SpecialWaveSpawnPoint();
	}

	public void SpwanWaveUpdate(int totalTime)
	{
		if (!isLastWave)
		{
			waveKeepTime--;
		}
		curWaveRunTime++;
		if (waveKeepTime == 0)
		{
			SpwanWaveMonster();
		}
		if (waveKeepTime > 0)
		{
			MonsterFindPointSpawn();
		}
		if (isSendBossSpawn)
		{
			lastWaveTime--;
			if (lastWaveTime == 0)
			{
				actionFailed?.Invoke(obj: false);
				isSettlement = true;
			}
		}
		foreach (KeyValuePair<int, tmpDropMsg> item in dropDic)
		{
			if (!item.Value.isDrop)
			{
				item.Value.growthTime++;
				if (item.Value.growthTime >= 10)
				{
					item.Value.realDropProb += item.Value.growthProb;
					item.Value.growthTime = 0;
				}
			}
			else
			{
				item.Value.dropTime++;
				if (item.Value.dropTime >= 20)
				{
					item.Value.isDrop = false;
					item.Value.dropTime = 0;
				}
			}
		}
	}

	protected void MonsterFindPointSpawn()
	{
		if (!isSpawnEnabled || waveKeepTime <= 0 || isSettlement)
		{
			return;
		}
		for (int i = 0; i < setDic.get_Item(currentWaveNum).Count; i++)
		{
			tmpVMSet tmpVMSet2 = setDic.get_Item(currentWaveNum).get_Item(i);
			if (!tmpVMSet2.isSpwan && tmpVMSet2.delayTime <= curWaveRunTime)
			{
				if (tmpVMSet2.monsterWarning > 0)
				{
					if (!isCurrentHaveTips)
					{
						MonoSingleton<LuaManager>.Instance.FireEvent("Show_Survivor_Warning", tmpVMSet2.monsterWarning);
						isCurrentHaveTips = true;
					}
					else
					{
						StartCoroutine(DelayTips(tmpVMSet2.monsterWarning));
					}
				}
				ChooseSpawnPoint(currentWaveNum, tmpVMSet2.groupNum, tmpVMSet2.monsterId, tmpVMSet2.maxNum, tmpVMSet2.monsterLevel, tmpVMSet2.levelChange, tmpVMSet2.spawnType, tmpVMSet2.setId);
				tmpVMSet2.isSpwan = true;
			}
			if (tmpVMSet2.isSpwan && tmpVMSet2.maxNumAddCount < tmpVMSet2.maxNumAddWaveCount && curWaveRunTime - tmpVMSet2.delayTime > 0 && (curWaveRunTime - tmpVMSet2.delayTime) % tmpVMSet2.maxNumAddDelay == 0)
			{
				ChooseSpawnPoint(currentWaveNum, tmpVMSet2.groupNum, tmpVMSet2.monsterId, tmpVMSet2.maxNumAddMonsterCount, tmpVMSet2.monsterLevel, tmpVMSet2.levelChange, tmpVMSet2.spawnType, tmpVMSet2.setId);
				tmpVMSet2.maxNumAddCount++;
			}
			if (tmpVMSet2.isWaitAdd && curWaveRunTime - tmpVMSet2.addWaitStartSec >= tmpVMSet2.addDelay)
			{
				ChooseSpawnPoint(currentWaveNum, tmpVMSet2.groupNum, tmpVMSet2.monsterId, tmpVMSet2.killCount, tmpVMSet2.monsterLevel, tmpVMSet2.levelChange, tmpVMSet2.spawnType, tmpVMSet2.setId);
				tmpVMSet2.killCount = 0;
				tmpVMSet2.isWaitAdd = false;
			}
		}
	}

	protected void ChooseSpawnPoint(int waveNum, int groupNum, int monsterId, int monsterNum, int monsterLv, int changeLv, int spawnType, int setId)
	{
		NewWaveRemoveMonster(monsterNum);
		VampireEnemySpAttr vampireEnemySpAttr = Singleton<HotfixDataController>.Instance.GetVampireEnemySpAttr(monsterId);
		if (vampireEnemySpAttr == null)
		{
			_logger.LogError($"吸血鬼模式怪物 VampireEnemySpAttr 表不存在，怪物ID = {monsterId}");
			return;
		}
		int num = vampireEnemySpAttr.RefDistance.get_Item(0);
		int num2 = vampireEnemySpAttr.RefDistance.get_Item(1);
		float num3 = (float)vampireEnemySpAttr.RefInterval.get_Item(0) / 10000f;
		float num4 = (float)vampireEnemySpAttr.RefInterval.get_Item(1) / 10000f;
		List<VampireMonsterSpawnPointGizmo> list = new List<VampireMonsterSpawnPointGizmo>();
		Vector3 position = mainCtrActor.transform.position;
		bool flag = false;
		while (list.Count < monsterNum)
		{
			List<VampireMonsterSpawnPointGizmo> list2 = new List<VampireMonsterSpawnPointGizmo>();
			if (flag)
			{
				num2++;
			}
			for (int i = 0; i < pointList.Count; i++)
			{
				if (pointList.get_Item(i).monsterID == 0)
				{
					Vector3 position2 = pointList.get_Item(i).transform.position;
					float num5 = Vector3.Distance(position, position2);
					if ((float)num <= num5 && num5 <= (float)num2)
					{
						list2.Add(pointList.get_Item(i));
					}
				}
			}
			Shuffle(list2);
			for (int j = 0; j < monsterNum; j++)
			{
				List<VampireMonsterSpawnPointGizmo> list3 = new List<VampireMonsterSpawnPointGizmo>();
				for (int k = 0; k < list2.Count; k++)
				{
					VampireMonsterSpawnPointGizmo vampireMonsterSpawnPointGizmo = list2.get_Item(k);
					if (vampireMonsterSpawnPointGizmo.monsterID != 0)
					{
						continue;
					}
					bool flag2 = false;
					for (int l = 0; l < list.Count; l++)
					{
						float num6 = Vector3.Distance(vampireMonsterSpawnPointGizmo.transform.position, list.get_Item(l).transform.position);
						switch (spawnType)
						{
						case 1:
						{
							float num7 = (float)_random.Next(vampireEnemySpAttr.RefInterval.get_Item(0), vampireEnemySpAttr.RefInterval.get_Item(1)) / 10000f;
							if (num6 < num7)
							{
								flag2 = true;
							}
							break;
						}
						case 2:
							if (num6 < num3)
							{
								flag2 = true;
							}
							break;
						case 3:
							if (num6 < num4)
							{
								flag2 = true;
							}
							break;
						}
					}
					if (!flag2)
					{
						list3.Add(vampireMonsterSpawnPointGizmo);
					}
				}
				if (list3.Count > 0 && list.Count < monsterNum)
				{
					int index = _random.Next(0, list3.Count);
					VampireMonsterSpawnPointGizmo vampireMonsterSpawnPointGizmo2 = list3.get_Item(index);
					vampireMonsterSpawnPointGizmo2.monsterID = monsterId;
					list.Add(vampireMonsterSpawnPointGizmo2);
				}
			}
			flag = true;
		}
		for (int m = 0; m < list.Count; m++)
		{
			list.get_Item(m).SetSpawnCallback(MonsterSpawnCallBack, monsterId, monsterLv, changeLv, waveNum, groupNum, setId);
			list.get_Item(m).ExecuteSpawnLogic();
		}
	}

	protected void MonsterSpawnCallBack(long uid, int wNum, int gNum, HotfixEnum.monsterEpicType epicType)
	{
		monsterSpwanInfoDic.set_Item(uid, new tmpMonsterInfo
		{
			waveNum = wNum,
			groupNum = gNum
		});
		if (isLastWave && epicType == HotfixEnum.monsterEpicType.LORD && !isSendBossSpawn)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Vampire_Boss_Spawn");
			isSendBossSpawn = true;
		}
	}

	protected void NewWaveRemoveMonster(int count)
	{
		haveMonsterCount += count;
		if (haveMonsterCount > VampireMonsterMaxCount)
		{
			int num = haveMonsterCount - VampireMonsterMaxCount;
			for (int i = 0; i < num; i++)
			{
				RemoveGreaterThanMonster();
			}
		}
	}

	protected void DropChest(int dropChestId, Vector3 pos, int type, int wave, int monsterId)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("Kill_SpecialType", type, monsterId);
		SceneSingleton<DropsManager>.Instance.PlayDropsVampire(mainCtrActor, dropChestId, pos, 0, type, wave);
	}

	protected void DropOther(int dropId, Vector3 pos)
	{
		if (!isSettlement && dropId > 0 && dropDic.ContainsKey(dropId) && !dropDic.get_Item(dropId).isDrop && dropDic.get_Item(dropId).dropCount < dropDic.get_Item(dropId).dropMaxCount && Random(dropDic.get_Item(dropId).realDropProb))
		{
			dropDic.get_Item(dropId).realDropProb = dropDic.get_Item(dropId).dropProb;
			dropDic.get_Item(dropId).isDrop = true;
			dropDic.get_Item(dropId).growthTime = 0;
			dropDic.get_Item(dropId).dropCount++;
			SceneSingleton<DropsManager>.Instance.PlayDropsVampire(mainCtrActor, dropId, pos);
		}
	}

	private bool Random(int Prob)
	{
		int num = 0;
		if (null != MonoSingleton<GameController>.Instance)
		{
			num = MonoSingleton<GameController>.Instance.Random_Roguelike(0, 10000);
		}
		else
		{
			_logger.LogInfo("缺少[GameController.cs]");
		}
		return num <= Prob;
	}

	protected void MonsterDeclareDeath(IEvent ievent)
	{
		if (!isSpawnEnabled || ievent == null)
		{
			return;
		}
		AdventureMonsterDeclareDiedEvent adventureMonsterDeclareDiedEvent = (AdventureMonsterDeclareDiedEvent)ievent;
		long key = adventureMonsterDeclareDiedEvent.id;
		Vector3 vector = Vector3.zero;
		LogicEntity logicEntity = adventureMonsterDeclareDiedEvent.sender as LogicEntity;
		if (logicEntity.IsPlayerSummoned(out var _, out var _))
		{
			return;
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("Vampire_Monster_DeclareDeath", (int)adventureMonsterDeclareDiedEvent.epicType);
		if (logicEntity != null)
		{
			vector = new Vector3(logicEntity.transform.position.x, mainCtrActor.transform.position.y, logicEntity.transform.position.z);
		}
		if (!monsterSpwanInfoDic.TryGetValue(key, out var value))
		{
			return;
		}
		int waveNum = value.waveNum;
		int groupNum = value.groupNum;
		if (setDic.get_Item(waveNum) != null && setDic.get_Item(waveNum).get_Item(groupNum - 1) != null)
		{
			tmpVMSet tmpVMSet2 = setDic.get_Item(waveNum).get_Item(groupNum - 1);
			int dropExpId = tmpVMSet2.dropExpId;
			int dropExpVal = tmpVMSet2.dropExpVal;
			int dropChestId = tmpVMSet2.dropChestId;
			if (waveNum < 0 && waveNum > -100)
			{
				if (SpecialWaveMonsterKillCount.ContainsKey(waveNum))
				{
					SpecialWaveMonsterKillCount.get_Item(waveNum)++;
				}
				else
				{
					SpecialWaveMonsterKillCount.set_Item(waveNum, 1);
				}
			}
			if (dropExpId > 0)
			{
				SceneSingleton<DropsManager>.Instance.PlayDropsVampire(mainCtrActor, dropExpId, vector, dropExpVal);
			}
			if (dropChestId > 0)
			{
				if (waveNum > 0)
				{
					if (adventureMonsterDeclareDiedEvent.epicType != HotfixEnum.monsterEpicType.LORD)
					{
						DropChest(dropChestId, vector, -3, setDic.get_Item(waveNum).get_Item(groupNum - 1).SpawnWave, adventureMonsterDeclareDiedEvent.monsterID);
					}
					else
					{
						DropChest(dropChestId, vector, -4, setDic.get_Item(waveNum).get_Item(groupNum - 1).SpawnWave, adventureMonsterDeclareDiedEvent.monsterID);
					}
				}
				else if (waveNum <= -100)
				{
					DropChest(dropChestId, vector, -2, setDic.get_Item(waveNum).get_Item(groupNum - 1).SpawnWave, adventureMonsterDeclareDiedEvent.monsterID);
				}
				else if (SpecialWaveMonsterKillCount.get_Item(waveNum) == SpecialWaveMonsterCount.get_Item(waveNum))
				{
					DropChest(dropChestId, vector, -1, setDic.get_Item(waveNum).get_Item(groupNum - 1).SpawnWave, adventureMonsterDeclareDiedEvent.monsterID);
				}
			}
			DropOther(tmpVMSet2.dropHpId, vector);
			DropOther(tmpVMSet2.dropMpId, vector);
			DropOther(tmpVMSet2.dropAtkId, vector);
			DropOther(tmpVMSet2.dropGetId, vector);
			DropOther(tmpVMSet2.dropClearId, vector);
			monsterSpwanInfoDic.Remove(key);
			haveMonsterCount--;
			if (waveNum != currentWaveNum)
			{
				return;
			}
			tmpVMSet2.killCount++;
			if (tmpVMSet2.addCount > 0 && tmpVMSet2.killCount >= tmpVMSet2.addCount && !tmpVMSet2.isWaitAdd && !isSettlement)
			{
				if (tmpVMSet2.addDelay == 0)
				{
					ChooseSpawnPoint(currentWaveNum, tmpVMSet2.groupNum, tmpVMSet2.monsterId, tmpVMSet2.killCount, tmpVMSet2.monsterLevel, tmpVMSet2.levelChange, tmpVMSet2.spawnType, tmpVMSet2.setId);
					tmpVMSet2.maxNumAddCount++;
					tmpVMSet2.killCount = 0;
					setDic.get_Item(waveNum).get_Item(groupNum - 1).killCount = 0;
				}
				else
				{
					tmpVMSet2.addWaitStartSec = curWaveRunTime;
					tmpVMSet2.isWaitAdd = true;
				}
			}
		}
		if (waveNum == totalWaveNum && adventureMonsterDeclareDiedEvent.epicType == HotfixEnum.monsterEpicType.LORD)
		{
			lastBossCount--;
			if (lastBossCount == 0)
			{
				actionSuccess?.Invoke();
				isSettlement = true;
				ModuleController<AdventureModuleController>.Instance.KillAllMonsters(clearOrDestroy: false, ignoreAll: true);
			}
		}
	}

	protected void RemoveGreaterThanMonster()
	{
		long num = 0L;
		List<MonsterAdventureActor> list = new List<MonsterAdventureActor>();
		FP fP = 0;
		foreach (KeyValuePair<long, tmpMonsterInfo> item in monsterSpwanInfoDic)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(item.Key);
			if (!(null != logicEntity))
			{
				continue;
			}
			MonsterAdventureActor monsterAdventureActor = logicEntity as MonsterAdventureActor;
			if (monsterAdventureActor.monsterInfo.epicType != HotfixEnum.monsterEpicType.LORD && monsterAdventureActor.monsterInfo.epicType != HotfixEnum.monsterEpicType.LEADER && monsterSpwanInfoDic.get_Item(item.Key).waveNum >= 0)
			{
				FP fP2 = (FP)monsterAdventureActor.actorHealthInfo.hpPercentage;
				if (fP2 > fP)
				{
					list.Clear();
					list.Add(monsterAdventureActor);
					fP = fP2;
				}
				else if (fP2 == fP)
				{
					list.Add(monsterAdventureActor);
				}
			}
		}
		if (num == 0L && list.Count > 0)
		{
			if (fP >= 1)
			{
				for (int i = 0; i < list.Count; i++)
				{
					if (num == 0L)
					{
						num = list.get_Item(i).Id;
					}
					else if (num > list.get_Item(i).Id)
					{
						num = list.get_Item(i).Id;
					}
				}
			}
			else
			{
				float num2 = 0f;
				for (int j = 0; j < list.Count; j++)
				{
					float num3 = Vector3.Distance(mainCtrActor.transform.position, list.get_Item(j).transform.position);
					if (num3 > num2)
					{
						num2 = num3;
						num = list.get_Item(j).Id;
					}
				}
			}
		}
		if (num != 0L)
		{
			monsterSpwanInfoDic.Remove(num);
			haveMonsterCount--;
			LogicEntity logicEntity2 = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(num);
			if (null != logicEntity2)
			{
				(logicEntity2 as MonsterAdventureActor).ClearSelf();
			}
		}
	}

	protected void Shuffle<T>(List<T> list)
	{
		int num = list.Count;
		while (num > 1)
		{
			num--;
			int index = _random.Next(num + 1);
			T value = list.get_Item(index);
			list.set_Item(index, list.get_Item(num));
			list.set_Item(num, value);
		}
	}

	protected void SetSpecialEnemy()
	{
		AdventureModuleLevelLoadParams levelLoadParams = ModuleController<AdventureModuleController>.Instance.levelLoadParams;
		if (levelLoadParams.vampireSpecialEnemySet.Contains(currentWaveNum))
		{
			List<List<int>> list = JsonConvert.DeserializeObject<List<List<int>>>(SpecialEnemySetId);
			int num = 0;
			Dictionary<int, int> dictionary = new Dictionary<int, int>();
			for (int i = 0; i < list.Count; i++)
			{
				num += list.get_Item(i).get_Item(1);
				dictionary.set_Item(list.get_Item(i).get_Item(0), num);
			}
			int num2 = MonoSingleton<GameController>.Instance.Random_Roguelike(0, num);
			int num3 = 0;
			foreach (KeyValuePair<int, int> item3 in dictionary)
			{
				if (num2 <= item3.Value)
				{
					num3 = item3.Key;
					break;
				}
			}
			List<tmpVMSet> list2 = new List<tmpVMSet>();
			List<VampireEnemySet> vampireEnemySetData = Singleton<HotfixDataController>.Instance.VampireEnemySetData;
			for (int j = 0; j < vampireEnemySetData.Count; j++)
			{
				if (num3 == vampireEnemySetData.get_Item(j).SetId)
				{
					tmpVMSet item = GetTmpVMSet(vampireEnemySetData.get_Item(j));
					list2.Add(item);
				}
			}
			SpecialSpawnWaveCount--;
			SpecialWaveDic.set_Item(SpecialSpawnWaveCount, list2);
			setDic.set_Item(SpecialSpawnWaveCount, list2);
			if (!isCurrentHaveTips)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("Show_Survivor_Warning", -1);
				isCurrentHaveTips = true;
			}
			else
			{
				StartCoroutine(DelayTips(-1));
			}
			int num4 = 0;
			for (int k = 0; k < list2.Count; k++)
			{
				num4 += list2.get_Item(k).maxNum;
			}
			SpecialWaveMonsterCount.set_Item(SpecialSpawnWaveCount, num4);
		}
		if (!levelLoadParams.vampireTreasureSet.Contains(currentWaveNum))
		{
			return;
		}
		List<List<int>> list3 = JsonConvert.DeserializeObject<List<List<int>>>(TreasureSetId);
		int num5 = 0;
		Dictionary<int, int> dictionary2 = new Dictionary<int, int>();
		for (int l = 0; l < list3.Count; l++)
		{
			num5 += list3.get_Item(l).get_Item(1);
			dictionary2.set_Item(list3.get_Item(l).get_Item(0), num5);
		}
		int num6 = MonoSingleton<GameController>.Instance.Random_Roguelike(0, num5);
		int num7 = 0;
		foreach (KeyValuePair<int, int> item4 in dictionary2)
		{
			if (num6 <= item4.Value)
			{
				num7 = item4.Key;
				break;
			}
		}
		List<tmpVMSet> list4 = new List<tmpVMSet>();
		List<VampireEnemySet> vampireEnemySetData2 = Singleton<HotfixDataController>.Instance.VampireEnemySetData;
		for (int m = 0; m < vampireEnemySetData2.Count; m++)
		{
			if (num7 == vampireEnemySetData2.get_Item(m).SetId)
			{
				tmpVMSet item2 = GetTmpVMSet(vampireEnemySetData2.get_Item(m));
				list4.Add(item2);
			}
		}
		TreasureSpawnWaveCount--;
		setDic.set_Item(TreasureSpawnWaveCount, list4);
		for (int n = 0; n < list4.Count; n++)
		{
			tmpVMSet tmpVMSet2 = list4.get_Item(n);
			ChooseSpawnPoint(TreasureSpawnWaveCount, tmpVMSet2.groupNum, tmpVMSet2.monsterId, tmpVMSet2.maxNum, tmpVMSet2.monsterLevel, tmpVMSet2.levelChange, tmpVMSet2.spawnType, tmpVMSet2.setId);
		}
	}

	protected void SpecialWaveSpawnPoint()
	{
		foreach (KeyValuePair<int, List<tmpVMSet>> item in SpecialWaveDic)
		{
			for (int i = 0; i < item.Value.Count; i++)
			{
				tmpVMSet tmpVMSet2 = item.Value.get_Item(i);
				if (!tmpVMSet2.isSpwan && tmpVMSet2.delayTime <= curWaveRunTime)
				{
					ChooseSpawnPoint(item.Key, tmpVMSet2.groupNum, tmpVMSet2.monsterId, tmpVMSet2.maxNum, tmpVMSet2.monsterLevel, tmpVMSet2.levelChange, tmpVMSet2.spawnType, tmpVMSet2.setId);
					tmpVMSet2.isSpwan = true;
				}
			}
		}
	}

	protected tmpVMSet GetTmpVMSet(VampireEnemySet tmpSet)
	{
		return new tmpVMSet
		{
			setId = tmpSet.SetId,
			groupNum = tmpSet.GroupNum,
			monsterId = tmpSet.MonsterId,
			monsterLevel = curPool.MonsterLevel,
			levelChange = tmpSet.LevelChange,
			delayTime = tmpSet.DelayTime,
			isSpwan = false,
			maxNum = tmpSet.MaxNum,
			killCount = 0,
			addCount = 0,
			addDelay = 0,
			maxNumAddDelay = 0,
			maxNumAddMonsterCount = 0,
			maxNumAddWaveCount = 0,
			maxNumAddCount = 0,
			spawnType = tmpSet.MonsterSpawnType,
			monsterPoint = tmpSet.MonsterPoint,
			dropExpId = ((tmpSet.DropExp.Count > 1) ? tmpSet.DropExp.get_Item(0) : 0),
			dropExpVal = ((tmpSet.DropExp.Count > 1) ? tmpSet.DropExp.get_Item(1) : 0),
			dropChestId = ((tmpSet.DropChest.Count > 0) ? tmpSet.DropChest.get_Item(0) : 0),
			dropHpId = ((tmpSet.DropHp.Count > 0) ? tmpSet.DropHp.get_Item(0) : 0),
			dropMpId = ((tmpSet.DropMp.Count > 0) ? tmpSet.DropMp.get_Item(0) : 0),
			dropAtkId = ((tmpSet.DropAtk.Count > 0) ? tmpSet.DropAtk.get_Item(0) : 0),
			dropGetId = ((tmpSet.DropGet.Count > 0) ? tmpSet.DropGet.get_Item(0) : 0),
			dropClearId = ((tmpSet.DropClear.Count > 0) ? tmpSet.DropClear.get_Item(0) : 0),
			monsterWarning = tmpSet.MonsterWarning,
			SpawnWave = curPool.WaveNum
		};
	}

	protected IEnumerator DelayTips(int index)
	{
		yield return new WaitForSecondsRealtime(4f);
		MonoSingleton<LuaManager>.Instance.FireEvent("Show_Survivor_Warning", index);
	}

	public int SetGMNextWave()
	{
		if (isLastWave)
		{
			return 0;
		}
		int result = waveKeepTime;
		SpwanWaveMonster();
		return result;
	}

	private void GMShowMonsterCount(IEvent ievent)
	{
		showGMMonsterCount = true;
	}
}
