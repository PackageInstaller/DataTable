using System;
using Nova.Hotfix;
using TrueSync;

public class StarTowerSpecialMode_KillStreak : StarTowerSpecialMode
{
	private bool isSuccess = true;

	private bool isStartTimeing;

	private int maxLimitTime;

	private int countDownTime;

	private int killMonsterCount;

	private FP timeing = 0;

	private bool isPause;

	public override void InitRoom(GameplayRoomData roomData, StarTowerCombatEvent eventData)
	{
		base.InitRoom(roomData, eventData);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
		if (roomType == HotfixEnum.starTowerRoomType.BattleRoom)
		{
			maxLimitTime = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("KillStreakMaxTimeLimit").Value);
		}
		else
		{
			maxLimitTime = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("KillStreakMaxTimeLimitElite").Value);
		}
	}

	public override void EntryRoom(Action<HotfixEnum.levelState> callback)
	{
		base.EntryRoom(callback);
		isComplete = true;
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		if (isActived && !isPause && isStartTimeing && isSuccess)
		{
			timeing += logicDeltaTime;
			if (timeing >= 1)
			{
				CountDown();
				timeing = 0;
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
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
	}

	private void MonsterDeath(IEvent evt)
	{
		if (!isSuccess)
		{
			return;
		}
		int monsterID = (evt as AdventureMonsterDiedEvent).monsterID;
		StarTowerMonsterSpAttr starTowerMonsterSpAttr = Singleton<HotfixDataController>.Instance.GetStarTowerMonsterSpAttr(monsterID);
		if (starTowerMonsterSpAttr != null)
		{
			countDownTime += starTowerMonsterSpAttr.ContinuousKillingTime;
			if (countDownTime >= maxLimitTime)
			{
				countDownTime = maxLimitTime;
			}
			if (!isStartTimeing)
			{
				countDownTime = maxLimitTime;
				isStartTimeing = true;
				MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_KillStreakStart");
			}
			killMonsterCount++;
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_KillStreakCountDown", countDownTime);
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_KillStreakMonsterCount", killMonsterCount, starTowerMonsterSpAttr.ContinuousKillingTime);
		}
	}

	private void CountDown()
	{
		if (isSuccess)
		{
			countDownTime--;
			if (countDownTime <= 0)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_Fail");
				isSuccess = false;
			}
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_KillStreakCountDown", countDownTime);
		}
	}
}
