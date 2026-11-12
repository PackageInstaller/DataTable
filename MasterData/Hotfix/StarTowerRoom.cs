using System;
using TrueSync;

public class StarTowerRoom : GameplayRoom
{
	public HotfixEnum.starTowerRoomType RoomType;

	public GameplayRoomData FRRData;

	public Action<HotfixEnum.levelState, int> LevelStateCallback;

	public FP levelTime;

	public bool isStartTime;

	public override void InitRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
		FRRData = data;
		LevelStateCallback = levelStateCallback;
		if (data.starTowerMap != null)
		{
			RoomType = ((data.starTowerStage != null) ? ((HotfixEnum.starTowerRoomType)data.starTowerStage.RoomType) : HotfixEnum.starTowerRoomType.BattleRoom);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("LEVEL_START_TIMING", StartTiming);
		Singleton<EventDispatchManager>.Instance.AddEventListener("LUA2CSHARP_UI_PAUSE", Lua2CSharp_UIPause);
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		if (isStartTime)
		{
			levelTime += logicDeltaTime;
		}
	}

	public override void Pause()
	{
	}

	public override void Resume()
	{
	}

	public override void LeaveRoom()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_START_TIMING", StartTiming);
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("LUA2CSHARP_UI_PAUSE", Lua2CSharp_UIPause);
	}

	public void StartTiming(IEvent evt)
	{
		if (!FRRData.isReconnected || (FRRData.isReconnected && !FRRData.isBattleFinish))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("StarTower_Start_Battle");
			isStartTime = true;
			StartTime();
		}
	}

	public virtual void StartTime()
	{
	}

	protected void Lua2CSharp_UIPause(IEvent ievent)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("LevelPauseUseTotalTime", (int)(long)levelTime);
	}
}
