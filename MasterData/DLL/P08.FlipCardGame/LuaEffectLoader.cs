using System.Collections.Generic;
using LuaInterface;
using P08.Quiz;
using UnityEngine;

public class LuaEffectLoader : LazySingleton<LuaEffectLoader>
{
	private static Dictionary<int, EffectData> cacheCfgData = new Dictionary<int, EffectData>();

	public LuaState luaState => LuaHelper.GetFunc("SendStartBloodardGameRequest").GetLuaState();

	public EffectData GetEffectData(int effectID)
	{
		if (cacheCfgData.ContainsKey(effectID))
		{
			return DeepCopyEffectData(cacheCfgData[effectID]);
		}
		LuaTable luaTable = luaState["BloodCardGameEffectCfg"] as LuaTable;
		if (luaTable == null)
		{
			Debug.LogError("未找到BloodCardGameEffectCfg类。");
			return new EffectData();
		}
		LuaTable luaTable2 = luaTable.ToArrayTable()[effectID] as LuaTable;
		if (luaTable2 == null)
		{
			Debug.LogError("未找到ID为 " + effectID + " 的效果配置。");
			return new EffectData();
		}
		EffectData effectData = ConvertToEffectData(luaTable2);
		cacheCfgData[effectID] = effectData;
		return DeepCopyEffectData(effectData);
	}

	private EffectData DeepCopyEffectData(EffectData original)
	{
		return new EffectData
		{
			id = original.id,
			name = string.Copy(original.name),
			desc = string.Copy(original.desc),
			type = original.type,
			launchTime = original.launchTime,
			target = original.target,
			effectTargetTime = original.effectTargetTime,
			effectParams = ((original.effectParams != null) ? new List<int>(original.effectParams) : null)
		};
	}

	public EffectData ConvertToEffectData(LuaTable table)
	{
		return new EffectData
		{
			id = (int)(double)table["id"],
			name = (table["name"] as string),
			desc = (table["desc"] as string),
			type = (int)(double)table["type"],
			launchTime = (int)(double)table["launch_time"],
			target = (int)(double)table["object"],
			effectTargetTime = (int)(double)table["object"],
			effectParams = ConvertToList(table["param_list"] as LuaTable)
		};
	}

	public List<int> ConvertToList(LuaTable table)
	{
		List<int> list = new List<int>();
		if (table != null)
		{
			LuaArrayTable luaArrayTable = table.ToArrayTable();
			for (int i = 1; i <= table.Length; i++)
			{
				list.Add((int)(double)luaArrayTable[i]);
			}
		}
		return list;
	}
}
