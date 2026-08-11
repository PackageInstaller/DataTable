#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class MonsterMapData : MapDataBase, IDeadCount
{
	[SerializeField]
	private List<MonsterCtrl> MonsterCtrls;

	[SerializeField]
	private int firstTaskId;

	public ScenePoint scenePoint;

	private SceneSystem sceneSystem;

	private DRDungeonTask currentTaskConfig;

	private int TaskNeedCount;

	private int TaskProgress;

	public HeroBornPointConfig HeroBornPointConfig;

	private bool isFinishLevel;

	public void OnInit(object data = null)
	{
		sceneSystem = (SceneSystem)data;
		foreach (MonsterCtrl monsterCtrl in MonsterCtrls)
		{
			monsterCtrl.OnInit(data);
			monsterCtrl.DeadCountInit(this);
		}
	}

	public void OnDispose()
	{
		StopAllBGM();
	}

	public ScenePoint GetHeroBornPoint(string heroBornPointKey, int index)
	{
		return HeroBornPointConfig.GetHeroBornPoint(heroBornPointKey, index);
	}

	public void CountIncrease()
	{
		if (!isFinishLevel)
		{
			TaskProgress++;
			if (currentTaskConfig.TaskType == 2)
			{
				TaskDes();
			}
			if (TaskNeedCount <= TaskProgress && CanActiveNextTask())
			{
				StartTask();
			}
		}
	}

	private bool CanActiveNextTask()
	{
		if (currentTaskConfig != null && currentTaskConfig.NextTask == 0)
		{
			sceneSystem.GetSystem<BattleSystem>().SetMonsterCopyFinish();
			isFinishLevel = true;
			return false;
		}
		return true;
	}

	public async void StartTask()
	{
		TaskProgress = 0;
		TaskNeedCount = 0;
		if (currentTaskConfig == null)
		{
			currentTaskConfig = GameEntry.DataTable.GetDataRow<DRDungeonTask>(firstTaskId);
		}
		else
		{
			currentTaskConfig = GameEntry.DataTable.GetDataRow<DRDungeonTask>(currentTaskConfig.NextTask);
		}
		if (currentTaskConfig == null)
		{
			return;
		}
		foreach (MonsterCtrl monsterCtrl in MonsterCtrls)
		{
			if (currentTaskConfig.Monsters.Contains(monsterCtrl.ID))
			{
				monsterCtrl.SetActive();
			}
			if (currentTaskConfig.TargetMonsters.Contains(monsterCtrl.ID))
			{
				monsterCtrl.DeadIncreaseCount = true;
			}
		}
		TaskNeedCount = currentTaskConfig.TaskData;
		if (currentTaskConfig.TaskType == 1)
		{
			sceneSystem.GetSystem<BattleSystem>().RefreshMonsterCopyData(currentTaskConfig.TaskDesc, string.Empty);
		}
		else if (currentTaskConfig.TaskType == 2)
		{
			TaskDes();
		}
		await UniTask.WaitForSeconds(currentTaskConfig.DelayTime);
		sceneSystem.GetSystem<BattleSystem>().ShowBattleTipsWindow(currentTaskConfig.LifeTime, currentTaskConfig.MessageDesc);
	}

	private void TaskDes()
	{
		sceneSystem.GetSystem<BattleSystem>().RefreshMonsterCopyData("限时击败敌人 ", $"{TaskProgress}/{TaskNeedCount}");
	}

	public ScenePoint GetScenePoint()
	{
		if (scenePoint != null)
		{
			return scenePoint;
		}
		Log.Error("MapData中没有找到场景点配置..");
		return null;
	}
}
