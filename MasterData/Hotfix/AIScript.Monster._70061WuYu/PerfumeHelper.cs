#define LOG_DEBUG
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public static class PerfumeHelper
{
	public static void FireBossPerfumeChange(LogicEntity target, int currentValue, int maxValue, bool forceSend = false)
	{
		if (target != null && !forceSend)
		{
			int num = CommonUtils_MonsterAPI.GetLogicTagFpValue(target, "LastSentBossPerfumeInt").AsInt();
			if (currentValue == num)
			{
				return;
			}
			CommonUtils_MonsterAPI.SetLogicTagFpValue(target, "LastSentBossPerfumeInt", currentValue);
		}
		else if (target != null)
		{
			CommonUtils_MonsterAPI.SetLogicTagFpValue(target, "LastSentBossPerfumeInt", currentValue);
		}
		NovaLogger.Debug($"BossPerfumeChange, current = {currentValue}, maxValue = {maxValue}");
		MonoSingleton<LuaManager>.Instance?.FireEvent("BossPerfumeChange", currentValue, maxValue);
	}

	public static void FireMoWangPerfumeChange(LogicEntity target, int currentValue, int maxValue, bool forceSend = false)
	{
		if (target != null && !forceSend)
		{
			int num = CommonUtils_MonsterAPI.GetLogicTagFpValue(target, "LastSentPlayerPerfumeInt").AsInt();
			if (currentValue == num)
			{
				return;
			}
			CommonUtils_MonsterAPI.SetLogicTagFpValue(target, "LastSentPlayerPerfumeInt", currentValue);
		}
		else if (target != null)
		{
			CommonUtils_MonsterAPI.SetLogicTagFpValue(target, "LastSentPlayerPerfumeInt", currentValue);
		}
		NovaLogger.Debug($"MoWangPerfumeChange, current = {currentValue}, maxValue = {maxValue}");
		MonoSingleton<LuaManager>.Instance?.FireEvent("MoWangPerfumeChange", currentValue, maxValue);
	}

	public static void AddPerfumeToSummoner(LogicEntity summoner, FP gain)
	{
		if (!(summoner == null))
		{
			FP fP = CommonUtils_MonsterAPI.GetLogicTagFpValue(summoner, "PerfumeValue") + gain;
			if (fP > 100)
			{
				fP = 100;
			}
			CommonUtils_MonsterAPI.SetLogicTagFpValue(summoner, "PerfumeValue", fP);
			FireBossPerfumeChange(summoner, fP.AsInt(), 100);
		}
	}

	public static void AddPerfumeToPlayer(LogicEntity player, FP gain)
	{
		if (!(player == null))
		{
			FP fP = CommonUtils_MonsterAPI.GetLogicTagFpValue(player, "PerfumeValue") + gain;
			if (fP > 100)
			{
				fP = 100;
			}
			CommonUtils_MonsterAPI.SetLogicTagFpValue(player, "PerfumeValue", fP);
			FireMoWangPerfumeChange(player, fP.AsInt(), 100);
		}
	}
}
