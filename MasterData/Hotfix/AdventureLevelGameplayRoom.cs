using System;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class AdventureLevelGameplayRoom
{
	private GameplayRoom room;

	public bool isComplete
	{
		get
		{
			if (room != null)
			{
				return room.isComplete;
			}
			return true;
		}
	}

	public void Init(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
		initRoom(data, levelStateCallback);
	}

	private void initRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
		initStarTowerRoom(data, levelStateCallback);
	}

	private void initStarTowerRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
		StarTowerStage starTowerStage = data.starTowerStage;
		if (starTowerStage == null)
		{
			Debug.LogError("星塔StarTowerStage数据为空!");
			return;
		}
		bool flag = true;
		bool hasSpecialMode = data.eventId != 0;
		bool playBornPerformance = false;
		HotfixEnum.starTowerRoomType roomType = (HotfixEnum.starTowerRoomType)starTowerStage.RoomType;
		switch (roomType)
		{
		case HotfixEnum.starTowerRoomType.BattleRoom:
			room = new StarTowerRoom_Regular();
			break;
		case HotfixEnum.starTowerRoomType.EliteBattleRoom:
			room = new StarTowerRoom_Regular();
			break;
		case HotfixEnum.starTowerRoomType.BossRoom:
			room = new StarTowerRoom_Regular();
			playBornPerformance = true;
			break;
		case HotfixEnum.starTowerRoomType.FinalBossRoom:
			room = new StarTowerRoom_Regular();
			playBornPerformance = true;
			break;
		case HotfixEnum.starTowerRoomType.DangerRoom:
			room = new StarTowerRoom_Regular();
			break;
		case HotfixEnum.starTowerRoomType.HorrorRoom:
			room = new StarTowerRoom_Regular();
			break;
		case HotfixEnum.starTowerRoomType.ShopRoom:
			room = new StarTowerRoom_FixedShop();
			break;
		case HotfixEnum.starTowerRoomType.EventRoom:
			room = new StarTowerRoom_Regular();
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
		if (room == null)
		{
			Debug.LogError($"固定rog:没有找到对应的房间类型类![func1={roomType}]");
			return;
		}
		room.InitRoom(data, levelStateCallback);
		if (flag)
		{
			(ModuleController<AdventureModuleController>.Instance.levelInstance as StarTowerLevelController)?.HandleSpecialMode(hasSpecialMode, playBornPerformance);
		}
	}

	private void initFixRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
		_ = data.starTowerMap;
		bool flag = true;
		bool hasSpecialMode = data.eventId != 0;
		bool playBornPerformance = false;
		room = new StarTowerRoom_Regular();
		if (room != null)
		{
			room.InitRoom(data, levelStateCallback);
			if (flag)
			{
				(ModuleController<AdventureModuleController>.Instance.levelInstance as StarTowerLevelController)?.HandleSpecialMode(hasSpecialMode, playBornPerformance);
			}
		}
	}

	private void initDailyRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
	}

	private void initEquipmentRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
	}

	private void initSkillRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
	}

	public void EntryRoom()
	{
		room?.EntryRoom();
	}

	public void UpdateLogic(FP logicDeltaTime)
	{
		room?.UpdateLogic(logicDeltaTime);
	}

	public void Pause()
	{
		room?.Pause();
	}

	public void Resume()
	{
		room?.Resume();
	}

	public void LeaveRoom()
	{
		room?.LeaveRoom();
		room = null;
	}
}
