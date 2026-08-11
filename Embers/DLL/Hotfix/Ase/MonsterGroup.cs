using System;
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

[Serializable]
public class MonsterGroup : BaseMapDataNodeGroup<MonsterNode>
{
	[SerializeField]
	private int uid;

	public bool OtherGroupControllActive = true;

	[SerializeField]
	private MonsterGroupExpandConfig activeExpandConfig;

	[SerializeField]
	private MonsterGroupExpandConfig deadExpandConfig;

	public static string LOW_MONSTER_ALERTRANGE_KEY = "e_mobsAlertRange";

	public static string LOW_MONSTER_HAVEALERT_KEY = "e_mobsHaveAlert";

	public static string LOW_MONSTER_ACTIVEAREA_KEY = "e_mobsActiveAreaEntities";

	public static string LOW_MONSTER_BORNANIMATION_KEY = "e_mobsBornAnimation";

	public static string MONSTERGROUP_KEY = "MONSTERGROUP_KEY";

	public static string MONSTERNODE_KEY = "MONSTERNODE_KEY";

	[SerializeField]
	private bool startActive = true;

	[SerializeField]
	private string groupDesc;

	[SerializeField]
	private float alertAreaRange;

	[SerializeField]
	private float activityAreaRange;

	[SerializeField]
	private Vector2 activityAreaRangeOffset;

	[SerializeField]
	private bool SaveData;

	public MonsterDieRefreshTime MonsterDieRefreshTime;

	public bool meetAllconditions;

	public bool invertCondition;

	public List<OpenCondition> activeTaskCondition = new List<OpenCondition>();

	public MonsterGroup allDeadActivemonsterGroup;

	public float delayTimer;

	private bool defaultActiveState;

	private new SceneSystem sceneSystem;

	private bool taskConditionResult;

	private List<MonsterGroupEventTrigger> monsterGroupEventTriggers = new List<MonsterGroupEventTrigger>();

	[HideInInspector]
	public Action UpdateDieTimeAction;

	private bool allMonsterNodeCreated;

	private bool forceBattle;

	public int Uid => uid;

	public bool Active
	{
		get
		{
			if (defaultActiveState && TaskConditionResult && OtherGroupControllActive)
			{
				return SateRefreshTime;
			}
			return false;
		}
	}

	private LevelAreaType LevelAreaType => levelArea.areaType;

	public bool ForceBattle => forceBattle;

	public bool TaskConditionResult
	{
		get
		{
			CheckTaskCondition();
			return taskConditionResult;
		}
	}

	private bool SateRefreshTime
	{
		get
		{
			if (MonsterDieRefreshTime == MonsterDieRefreshTime.Never && SaveData)
			{
				return Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetMonsterGroupLastAllDieTime(sceneSystem.GetLevelId(), uid) <= 0;
			}
			if (MonsterDieRefreshTime == MonsterDieRefreshTime.Day && SaveData)
			{
				DateTime dateTime = TimeHelper.GetDateTimeSeconds(Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetMonsterGroupLastAllDieTime(sceneSystem.GetLevelId(), uid)).ToLocalTime();
				DateTime dateTime2 = TimeHelper.GetDateTimeSeconds(TimeHelper.ClientNowSeconds()).ToLocalTime();
				if (dateTime.Date == dateTime2.Date)
				{
					return false;
				}
				return true;
			}
			if (MonsterDieRefreshTime == MonsterDieRefreshTime.NoLimit)
			{
				_ = SaveData;
				return true;
			}
			return true;
		}
	}

	public override void OnInited(object data = null)
	{
		sceneSystem = (SceneSystem)data;
		defaultActiveState = startActive;
		foreach (MonsterNode node in nodeList)
		{
			node.BindMonsterGroup(this);
		}
		if ((UnityEngine.Object)(object)allDeadActivemonsterGroup != null)
		{
			allDeadActivemonsterGroup.OtherGroupControllActive = false;
			allDeadActivemonsterGroup.UpdateDieTimeAction = UpdateGroupDieTime;
		}
	}

	public override void OnStarted(object data = null)
	{
	}

	public override void OnReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
		base.OnReceiveMapDataEvent(eventType, otherEntity);
		if (eventType == LevelMapDataEvent.RestLevel)
		{
			OnRestLevel();
		}
	}

	public void OnRestLevel()
	{
		defaultActiveState = startActive;
		if ((UnityEngine.Object)(object)allDeadActivemonsterGroup != null)
		{
			allDeadActivemonsterGroup.OtherGroupControllActive = false;
			allDeadActivemonsterGroup.SetForceBattle(isFroceBattle: false);
		}
		if ((UnityEngine.Object)(object)activeExpandConfig != null)
		{
			activeExpandConfig.SetAirWalls(isShow: false);
		}
	}

	public override void OnDispose()
	{
		foreach (MonsterNode node in nodeList)
		{
			node.OnDispose();
		}
		monsterGroupEventTriggers.Clear();
		UpdateDieTimeAction = null;
	}

	public void ChangeAcitveState(bool state)
	{
		defaultActiveState = state;
		bool flag = false;
		if (SaveData)
		{
			flag = ((Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetMonsterGroupLastAllDieTime(sceneSystem.GetLevelId(), uid) > 0) ? true : false);
		}
		if (state && (UnityEngine.Object)(object)activeExpandConfig != null && (!flag || activeExpandConfig.TriggerType != 0))
		{
			ExcuteMonsterGroupExpand(activeExpandConfig, isDead: false);
		}
	}

	public bool GetGroupAllNodeDie()
	{
		if (SaveData)
		{
			return Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetMonsterGroupLastAllDieTime(sceneSystem.GetLevelId(), uid) > 0;
		}
		return false;
	}

	private bool GetAllGroupAllDie()
	{
		if (GetGroupAllNodeDie())
		{
			if ((UnityEngine.Object)(object)allDeadActivemonsterGroup != null)
			{
				return allDeadActivemonsterGroup.GetAllGroupAllDie();
			}
			return true;
		}
		return false;
	}

	public float GetAlertAreaRange()
	{
		return alertAreaRange;
	}

	public float GetActivityAreaRange()
	{
		return activityAreaRange;
	}

	public Vector2 GetActivityAreaRangeOffset()
	{
		return activityAreaRangeOffset;
	}

	public void KillMonsterGroup()
	{
		foreach (MonsterNode node in nodeList)
		{
			node.KillMonsterSelf();
		}
	}

	public void GetAllLoadedEntity(List<int> entityIds)
	{
		if (nodeList == null)
		{
			return;
		}
		foreach (MonsterNode node in nodeList)
		{
			if (node.Entity != null)
			{
				entityIds.Add(node.Entity.Id);
			}
		}
	}

	public void OnEntityCreated()
	{
		foreach (MonsterNode node in nodeList)
		{
			if (node.MonsterNodeLife == MonsterNodeLife.None || node.MonsterNodeLife == MonsterNodeLife.NoDeadRelease)
			{
				return;
			}
		}
		PublishMonsterEvent(MonsterGroupEventType.Start);
		allMonsterNodeCreated = true;
	}

	public async void OnEntityDead()
	{
		foreach (MonsterNode node in nodeList)
		{
			if (node.MonsterNodeLife == MonsterNodeLife.None || node.MonsterNodeLife == MonsterNodeLife.Created)
			{
				return;
			}
		}
		if (allMonsterNodeCreated)
		{
			ExcuteMonsterGroupExpand(deadExpandConfig, isDead: true);
			allMonsterNodeCreated = false;
		}
	}

	public async void OnEnrityRelease()
	{
		foreach (MonsterNode node in nodeList)
		{
			if (node.MonsterNodeLife != MonsterNodeLife.DeadRelease)
			{
				return;
			}
		}
		PublishMonsterEvent(MonsterGroupEventType.Dead);
		if (SaveData && (UnityEngine.Object)(object)allDeadActivemonsterGroup == null)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMonsterGroupAllDieTime(sceneSystem.GetLevelId(), uid);
			UpdateDieTimeAction?.Invoke();
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(sceneSystem.GetLevelId());
		}
		if ((UnityEngine.Object)(object)allDeadActivemonsterGroup != null)
		{
			await UniTask.Delay((int)delayTimer * 1000);
			allDeadActivemonsterGroup.OtherGroupControllActive = true;
		}
	}

	private void ExcuteMonsterGroupExpand(MonsterGroupExpandConfig config, bool isDead)
	{
		if (!((UnityEngine.Object)(object)config != null))
		{
			return;
		}
		config.Excute(isDead);
		if (config.mode)
		{
			sceneSystem.GetSystem<BattleSystem>().SetMiniMapVisible(!config.closeMiniMap);
		}
		else
		{
			sceneSystem.GetSystem<BattleSystem>().SetLockMiniMap(config.lockMiniMap);
		}
		if (config.TaskBtnCtrl)
		{
			sceneSystem.GetSystem<BattleSystem>().TaskBtnCanClick(config.TaskBtnLockClick);
		}
		if (config.TLId != 0)
		{
			Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, config.TLId);
		}
		if (Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetMonsterGroupLastAllDieTime(sceneSystem.GetLevelId(), uid) > 0 || !config.IsHaveAirWall())
		{
			return;
		}
		if (isDead)
		{
			levelArea.ForceBattleEnd(uid);
			sceneSystem.GetSystem<BattleStateSystem>().ForceBattleHeroHandle(isStart: false);
			SetForceBattle(isFroceBattle: false);
			if ((UnityEngine.Object)(object)allDeadActivemonsterGroup != null)
			{
				allDeadActivemonsterGroup.SetForceBattle(isFroceBattle: false);
			}
		}
		else
		{
			levelArea.ForceBattleStart(uid);
			sceneSystem.GetSystem<BattleStateSystem>().ForceBattleHeroHandle(isStart: true);
			SetForceBattle(isFroceBattle: true);
			if ((UnityEngine.Object)(object)allDeadActivemonsterGroup != null)
			{
				allDeadActivemonsterGroup.SetForceBattle(isFroceBattle: true);
			}
		}
	}

	public void SetForceBattle(bool isFroceBattle)
	{
		forceBattle = isFroceBattle;
		if (isFroceBattle)
		{
			for (int i = 0; i < nodeList.Count; i++)
			{
				nodeList[i].ForceBattleStart();
			}
		}
	}

	public void UpdateGroupDieTime()
	{
		if (SaveData)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMonsterGroupAllDieTime(sceneSystem.GetLevelId(), uid);
		}
		UpdateDieTimeAction?.Invoke();
	}

	private void CheckTaskCondition()
	{
		taskConditionResult = sceneSystem.CheckCondition(activeTaskCondition, meetAllconditions, invertCondition);
	}

	public void PublishMonsterEvent(MonsterGroupEventType eventType)
	{
		for (int i = 0; i < monsterGroupEventTriggers.Count; i++)
		{
			monsterGroupEventTriggers[i].OnMessage(this, eventType);
		}
	}

	public void RegisterSubscription(MonsterGroupEventTrigger monsterGroupEventTrigger)
	{
		if (!monsterGroupEventTriggers.Contains(monsterGroupEventTrigger))
		{
			monsterGroupEventTriggers.Add(monsterGroupEventTrigger);
		}
	}

	public void UnRegisterSubscription(MonsterGroupEventTrigger monsterGroupEventTrigger)
	{
		if (monsterGroupEventTriggers.Contains(monsterGroupEventTrigger))
		{
			monsterGroupEventTriggers.Remove(monsterGroupEventTrigger);
		}
	}

	public void BattleDataKillMonster(bool isBoss)
	{
		levelArea.BattleDataKillMonster(isBoss);
	}
}
