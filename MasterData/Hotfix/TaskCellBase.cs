using Nova.Hotfix;
using TrueSync;
using UnityEngine;

[RequireComponent(typeof(TriggerTask))]
public class TaskCellBase : LogicMonoComponent, ILogicComponentUpdate, ILogicComponent
{
	public enum TaskStatus
	{
		active,
		runing,
		finished
	}

	protected int x = -1;

	protected int y = -1;

	private FP excuteTime;

	private TaskStatus taskState;

	protected FP ElapsedTime => Entity.LogicTime - excuteTime;

	public TaskStatus CurrentState => taskState;

	public override void OnActive()
	{
		taskState = TaskStatus.active;
	}

	public void OnLogicUpdate()
	{
		if (taskState == TaskStatus.runing)
		{
			LogicUpdate();
		}
	}

	protected virtual void OnExecute()
	{
	}

	protected virtual void LogicUpdate()
	{
	}

	protected virtual void OnStop(bool success)
	{
	}

	protected virtual void EndAction(bool success = true)
	{
		if (taskState == TaskStatus.runing)
		{
			taskState = TaskStatus.finished;
			OnStop(success);
			(Entity as TriggerTask).OnTriggerNextTask();
		}
	}

	public bool ToExecute()
	{
		if (!ActiveSelf)
		{
			return false;
		}
		if (taskState == TaskStatus.runing)
		{
			return false;
		}
		taskState = TaskStatus.runing;
		excuteTime = Entity.LogicTime;
		OnExecute();
		return true;
	}

	protected GameObject GetOwner()
	{
		return (Entity as TriggerTask).triggerOwner;
	}

	protected int GetGlobTempleteId()
	{
		return (Entity as TriggerTask).templeteId;
	}

	protected long GetGlobAttributeId()
	{
		int globTempleteId = GetGlobTempleteId();
		MonsterValueTempleteAdjust monsterValueTempleteAdjust = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteAdjust(globTempleteId);
		if (monsterValueTempleteAdjust != null)
		{
			AdventureModuleLevelLoadParams levelLoadParams = ModuleController<AdventureModuleController>.Instance.levelLoadParams;
			int num = 1;
			if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.StarTower)
			{
				num = levelLoadParams.levelDifficultLv;
			}
			return (long)monsterValueTempleteAdjust.TemplateId * 1000L + levelLoadParams.monsterLevel * 10 + num;
		}
		Debug.LogError($"Task Trigger, MonsterValueTempleteAdjust Config Not Exist, Id:{globTempleteId}");
		return 0L;
	}

	protected AdventureActor GetOwnerFakeActor()
	{
		if (GetGlobTempleteId() == 0)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance?.GetFakeActor(GetGlobTempleteId(), GetGlobAttributeId());
	}

	protected TSVector2 GetSpecifyMonsterPos()
	{
		return (Entity as TriggerTask).triggeCom.GetSpecifyMonsterPos();
	}

	protected static void SuspendPlayer()
	{
		ModuleController<AdventureModuleController>.Instance.EqueueActionOnEndOfLogicFrame(() =>
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		});
	}

	protected static void ResumePlayer()
	{
		ModuleController<AdventureModuleController>.Instance.EqueueActionOnEndOfLogicFrame(() =>
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		});
	}

	protected static void PauseLogic()
	{
		ModuleController<AdventureModuleController>.Instance.PauseLogic();
	}

	protected static void ResumeLogic()
	{
		ModuleController<AdventureModuleController>.Instance.ResumeLogic();
	}

	protected static void EnterCinemaMode()
	{
		ModuleController<AdventureModuleController>.Instance.EqueueActionOnEndOfLogicFrame(() =>
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("OpenCinema");
		});
	}

	protected static void ExitCinemaMode()
	{
		ModuleController<AdventureModuleController>.Instance.EqueueActionOnEndOfLogicFrame(() =>
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("CloseCinema");
		});
	}

	protected static void SetHud_Visible()
	{
		ModuleController<AdventureModuleController>.Instance.EqueueActionOnEndOfLogicFrame(() =>
		{
			SceneSingleton<AdventureHUDController>.Instance.ShowAllHUD();
		});
	}

	protected static void SetHud_Invisible()
	{
		ModuleController<AdventureModuleController>.Instance.EqueueActionOnEndOfLogicFrame(() =>
		{
			SceneSingleton<AdventureHUDController>.Instance.HideAllHUD();
		});
	}

	protected static void StopLevelMusic()
	{
		ModuleController<AdventureModuleController>.Instance.StopLevelMusic();
	}

	protected static void PlayLevelMusic()
	{
		ModuleController<AdventureModuleController>.Instance.PlayLevelMusic();
	}

	protected void LogWarning(string warningText)
	{
		Debug.LogWarning(warningText);
	}
}
