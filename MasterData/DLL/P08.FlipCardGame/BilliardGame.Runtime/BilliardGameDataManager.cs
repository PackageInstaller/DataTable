using System.Collections.Generic;
using System.Linq;
using LuaInterface;

namespace BilliardGame.Runtime;

public static class BilliardGameDataManager
{
	public enum GameType
	{
		BALL = 1,
		Vehicle
	}

	private static GameType curGameType;

	private static Dictionary<int, BilliardCharacterConfig> PlayerCfg;

	private static Dictionary<int, BilliardEntityConfig> MonsterCfg;

	private static Dictionary<int, BilliardEntityConfig> MechanismCfg;

	private static Dictionary<int, BilliardStageConfig> StageCfg;

	private static Dictionary<int, BilliardBuffConfig> buffCfg;

	private static float[] roundHpRatio;

	public static void Init()
	{
		InitPlayerData();
		InitEntityData();
		InitStageData();
		InitBuffData();
		InitRoundHpRatio();
	}

	private static void InitPlayerData()
	{
		PlayerCfg = new Dictionary<int, BilliardCharacterConfig>();
		object[] array = ((curGameType != GameType.BALL) ? LuaHelper.CallFunction("GetVehiclePlayerData") : LuaHelper.CallFunction("GetPlayerData"));
		object[] array2 = (array[0] as LuaTable).ToArray();
		for (int i = 0; i < array2.Length; i++)
		{
			LuaTable luaTable = array2[i] as LuaTable;
			BilliardCharacterConfig billiardCharacterConfig = new BilliardCharacterConfig();
			billiardCharacterConfig.id = (int)(double)luaTable["id"];
			billiardCharacterConfig.name = luaTable["name"].ToString();
			billiardCharacterConfig.baseHp = (float)(double)luaTable["baseHP"];
			billiardCharacterConfig.baseAttack = (float)(double)luaTable["baseAttack"];
			billiardCharacterConfig.baseSpeed = (float)(double)luaTable["baseSpeed"];
			billiardCharacterConfig.baseCollideRatio = (float)(double)luaTable["baseCollide"];
			billiardCharacterConfig.hero_skill_image = luaTable["hero_skill_image"].ToString();
			billiardCharacterConfig.hero_head_image = luaTable["hero_head_image"].ToString();
			billiardCharacterConfig.hero_ball_image = luaTable["hero_ball_image"].ToString();
			billiardCharacterConfig.activeSkillID = (int)(double)luaTable["active_skill"];
			billiardCharacterConfig.passiveSkillID = (int)(double)luaTable["passive_skill"];
			billiardCharacterConfig.skillCd = (int)(double)luaTable["skill_cd"];
			billiardCharacterConfig.cost = (int)(double)luaTable["cost"];
			billiardCharacterConfig.heroType = (int)(double)luaTable["hero_type"];
			PlayerCfg.Add(billiardCharacterConfig.id, billiardCharacterConfig);
		}
	}

	private static void InitEntityData()
	{
		MonsterCfg = new Dictionary<int, BilliardEntityConfig>();
		MechanismCfg = new Dictionary<int, BilliardEntityConfig>();
		object[] array = ((curGameType != GameType.BALL) ? LuaHelper.CallFunction("GetVehicleEntityData") : LuaHelper.CallFunction("GetEntityData"));
		object[] array2 = (array[0] as LuaTable).ToArray();
		for (int i = 0; i < array2.Length; i++)
		{
			LuaTable luaTable = array2[i] as LuaTable;
			BilliardEntityConfig billiardEntityConfig = new BilliardEntityConfig();
			billiardEntityConfig.id = (int)(double)luaTable["id"];
			billiardEntityConfig.activityId = (int)(double)luaTable["activityId"];
			billiardEntityConfig.type = (int)(double)luaTable["type"];
			billiardEntityConfig.name = luaTable["name"].ToString();
			billiardEntityConfig.desc = luaTable["desc"].ToString();
			billiardEntityConfig.skillDesc = luaTable["skillDesc"].ToString();
			billiardEntityConfig.littleIcon = luaTable["littleIcon"].ToString();
			billiardEntityConfig.icon = luaTable["icon"].ToString();
			billiardEntityConfig.skillId = (int)(double)luaTable["skillId"];
			billiardEntityConfig.baseHP = (int)(double)luaTable["baseHP"];
			billiardEntityConfig.baseAttack = (int)(double)luaTable["baseAttack"];
			billiardEntityConfig.hpBarType = (int)(double)luaTable["hpBarType"];
			if (billiardEntityConfig.type == 2)
			{
				MechanismCfg.Add(billiardEntityConfig.id, billiardEntityConfig);
			}
			else if (billiardEntityConfig.type == 1)
			{
				MonsterCfg.Add(billiardEntityConfig.id, billiardEntityConfig);
			}
		}
	}

	private static int[] luaTable2intArray(LuaTable tbl)
	{
		int length = tbl.Length;
		int[] array = new int[length];
		for (int i = 0; i < length; i++)
		{
			array[i] = (int)(double)tbl[i + 1];
		}
		return array;
	}

	public static void InitStageData()
	{
		StageCfg = new Dictionary<int, BilliardStageConfig>();
		object[] array = ((curGameType != GameType.BALL) ? LuaHelper.CallFunction("GetVehicleStageData") : LuaHelper.CallFunction("GetStageData"));
		object[] array2 = (array[0] as LuaTable).ToArray();
		for (int i = 0; i < array2.Length; i++)
		{
			LuaTable luaTable = array2[i] as LuaTable;
			BilliardStageConfig billiardStageConfig = new BilliardStageConfig();
			billiardStageConfig.id = (int)(double)luaTable["id"];
			billiardStageConfig.stageType = (int)(double)luaTable["type"];
			billiardStageConfig.winType = (WinType)(double)luaTable["winType"];
			billiardStageConfig.winCondition = luaTable2intArray(luaTable["winCondition"] as LuaTable);
			billiardStageConfig.monsterAttribute = luaTable2intArray(luaTable["monsterAttribute"] as LuaTable);
			billiardStageConfig.monsterUnlockID = luaTable2intArray(luaTable["monsterUnlockID"] as LuaTable);
			billiardStageConfig.skillPoint = (int)(double)luaTable["skillPoint"];
			StageCfg.Add(billiardStageConfig.id, billiardStageConfig);
		}
	}

	public static void InitBuffData()
	{
		buffCfg = new Dictionary<int, BilliardBuffConfig>();
		object[] array = ((curGameType != GameType.BALL) ? LuaHelper.CallFunction("GetBilliardVehicleBuffData") : LuaHelper.CallFunction("GetBilliardBuffData"));
		object[] array2 = (array[0] as LuaTable).ToArray();
		for (int i = 0; i < array2.Length; i++)
		{
			LuaTable luaTable = array2[i] as LuaTable;
			BilliardBuffConfig billiardBuffConfig = new BilliardBuffConfig();
			billiardBuffConfig.id = (int)(double)luaTable["id"];
			billiardBuffConfig.desc = luaTable["desc"].ToString();
			billiardBuffConfig.icon = luaTable["icon"].ToString();
			buffCfg.Add(billiardBuffConfig.id, billiardBuffConfig);
		}
	}

	public static void InitRoundHpRatio()
	{
		object[] array = LuaHelper.CallFunction("GetMonsterHpRatio");
		if (array != null && array.Length != 0)
		{
			object[] array2 = (array[0] as LuaTable).ToArray();
			roundHpRatio = new float[array2.Length];
			for (int i = 0; i < array2.Length; i++)
			{
				roundHpRatio[i] = (float)(double)array2[i];
			}
		}
	}

	public static BilliardCharacterConfig GetPlayerCfg(int heroId)
	{
		if (PlayerCfg.TryGetValue(heroId, out var value))
		{
			return value;
		}
		return null;
	}

	public static BilliardEntityConfig GetMonsterCfg(int id)
	{
		if (MonsterCfg.TryGetValue(id, out var value))
		{
			return value;
		}
		return null;
	}

	public static BilliardEntityConfig GetMechanismCfg(int id)
	{
		if (MechanismCfg.TryGetValue(id, out var value))
		{
			return value;
		}
		return null;
	}

	public static BilliardStageConfig GetStageCfg(int id)
	{
		if (StageCfg.TryGetValue(id, out var value))
		{
			return value;
		}
		return null;
	}

	public static BilliardBuffConfig GetBuffCfg(int id)
	{
		if (buffCfg.TryGetValue(id, out var value))
		{
			return value;
		}
		return null;
	}

	public static int GetInitFood()
	{
		object[] array = LuaHelper.CallFunction("GetInitFood");
		int result = 3;
		if (array != null && array.Length != 0)
		{
			result = (int)(double)array[0];
		}
		return result;
	}

	public static float GetRoundHpRatio(int round)
	{
		if (round <= roundHpRatio.Length)
		{
			return roundHpRatio[round - 1];
		}
		return roundHpRatio.Last();
	}

	public static void Dispose()
	{
		PlayerCfg = null;
		MonsterCfg = null;
		MechanismCfg = null;
		StageCfg = null;
	}

	public static void SetGameType(GameType gameType)
	{
		curGameType = gameType;
	}

	public static bool IsBallGame()
	{
		return curGameType == GameType.BALL;
	}
}
