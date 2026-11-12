using System;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class StarTowerSpecialMode_TimeLimit : StarTowerSpecialMode
{
	private StarTowerFloor fixedRoguelikeFloor;

	private int totalTime;

	private FP timeing = 0;

	private bool isPause;

	private int delayTime;

	private FP delayTimeing;

	private bool isDelayEnd;

	public override void InitRoom(GameplayRoomData roomData, StarTowerCombatEvent eventData)
	{
		base.InitRoom(roomData, eventData);
		fixedRoguelikeFloor = base.roomData.fixedRoguelikeFloor;
		if (fixedRoguelikeFloor != null)
		{
			totalTime = fixedRoguelikeFloor.LimitTime;
		}
	}

	public override void EntryRoom(Action<HotfixEnum.levelState> callback)
	{
		base.EntryRoom(callback);
		if (roomData == null)
		{
			Debug.LogError("房间数据为空!");
			return;
		}
		if (!roomData.isReconnected || (roomData.isReconnected && !roomData.isBattleFinish))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_SetCountDownTime", totalTime);
		}
		isComplete = true;
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		if (!isActived)
		{
			return;
		}
		if (roomData == null)
		{
			Debug.LogError("房间数据为空!");
		}
		else
		{
			if (roomData.isReconnected && (!roomData.isReconnected || roomData.isBattleFinish))
			{
				return;
			}
			if (!isDelayEnd)
			{
				delayTimeing += logicDeltaTime;
				if (delayTimeing > delayTime)
				{
					isDelayEnd = true;
					MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_CountDown", totalTime);
				}
			}
			if (!isPause && isDelayEnd && totalTime > 0)
			{
				timeing += logicDeltaTime;
				if (timeing >= 1)
				{
					CountDown();
					timeing = 0;
				}
			}
		}
	}

	public override void Pause()
	{
		isPause = true;
	}

	public override void Resume()
	{
		isPause = false;
	}

	public override void LeaveRoom()
	{
		fixedRoguelikeFloor = null;
		timeing = 0;
	}

	private void CountDown()
	{
		totalTime--;
		if (totalTime <= 0)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_Fail");
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_CountDown", totalTime);
	}
}
