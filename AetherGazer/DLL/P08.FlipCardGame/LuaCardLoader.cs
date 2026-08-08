using System.Collections.Generic;
using System.Linq;
using LuaInterface;
using P08.Quiz;
using UnityEngine;

public class LuaCardLoader : LazySingleton<LuaCardLoader>
{
	private static Dictionary<int, CardData> cacheCfgData = new Dictionary<int, CardData>();

	public LuaState luaState => LuaHelper.GetFunc("SendStartBloodardGameRequest").GetLuaState();

	public CardData GetCardData(int cardID)
	{
		if (cacheCfgData.ContainsKey(cardID))
		{
			return DeepCopyCardData(cacheCfgData[cardID]);
		}
		LuaTable luaTable = luaState["BloodCardGameCardCfg"] as LuaTable;
		if (luaTable == null)
		{
			Debug.LogError("未找到BloodCardGameCardCfg类。");
			return new CardData();
		}
		LuaTable luaTable2 = luaTable.ToArrayTable()[cardID] as LuaTable;
		if (luaTable2 == null)
		{
			Debug.LogError("未找到ID为 " + cardID + " 的卡牌配置。");
			return new CardData();
		}
		CardData cardData = ConvertToCardData(luaTable2);
		cacheCfgData[cardID] = cardData;
		return DeepCopyCardData(cardData);
	}

	private CardData DeepCopyCardData(CardData original)
	{
		return new CardData
		{
			id = original.id,
			needPoint = original.needPoint,
			pos = original.pos,
			name = string.Copy(original.name),
			desc = string.Copy(original.desc),
			type = original.type,
			power = original.power,
			rare = original.rare,
			controllEffects = ((original.controllEffects != null) ? new List<Vector2>(original.controllEffects) : null),
			effects = ((original.effects != null) ? original.effects.Select((Effect e) => new Effect(e.id, (e.effectPosList != null) ? new List<Vector2>(e.effectPosList) : null)).ToList() : null),
			icon = string.Copy(original.icon),
			limit = original.limit
		};
	}

	private CardData ConvertToCardData(LuaTable table)
	{
		return new CardData
		{
			id = (int)(double)table["id"],
			name = (table["name"] as string),
			desc = (table["desc"] as string),
			type = (int)(double)table["type"],
			needPoint = (int)(double)table["need_point"],
			power = (int)(double)table["power"],
			rare = (BloodCardEnum.CardRarity)(double)table["kind"],
			controllEffects = ConvertToVector2PosList(table["c_grid_list"] as LuaTable),
			effects = ConvertToVector2EffectList(table["s_grid_list"] as LuaTable, table["effect_list"] as LuaTable),
			icon = (table["illustration"] as string),
			limit = (int)(double)table["limit"]
		};
	}

	private List<Vector2> ConvertToVector2PosList(LuaTable controllPosTable)
	{
		List<Vector2> list = new List<Vector2>();
		if (controllPosTable == null)
		{
			return list;
		}
		int length = controllPosTable.Length;
		LuaArrayTable luaArrayTable = controllPosTable.ToArrayTable();
		for (int i = 1; i <= length; i++)
		{
			if (luaArrayTable[i] != null)
			{
				int length2 = (luaArrayTable[i] as LuaTable).Length;
				for (int j = 1; j <= length2; j++)
				{
					LuaArrayTable luaArrayTable2 = (luaArrayTable[i] as LuaTable).ToArrayTable();
					Vector2 item = new Vector2((float)(double)luaArrayTable2[1], (float)(double)luaArrayTable2[2]);
					list.Add(item);
				}
			}
		}
		return list;
	}

	private List<Effect> ConvertToVector2EffectList(LuaTable effectPosTable, LuaTable effectIDTable)
	{
		List<Effect> list = new List<Effect>();
		if (effectPosTable == null || effectIDTable == null)
		{
			return list;
		}
		LuaArrayTable luaArrayTable = effectPosTable.ToArrayTable();
		LuaArrayTable luaArrayTable2 = effectIDTable.ToArrayTable();
		int length = effectPosTable.Length;
		int length2 = effectIDTable.Length;
		Dictionary<int, List<Vector2>> dictionary = new Dictionary<int, List<Vector2>>();
		for (int i = 1; i <= length; i++)
		{
			LuaArrayTable luaArrayTable3 = (luaArrayTable[i] as LuaTable).ToArrayTable();
			Vector2 item = new Vector2((float)(double)luaArrayTable3[1], (float)(double)luaArrayTable3[2]);
			if (i > length2)
			{
				continue;
			}
			LuaArrayTable luaArrayTable4 = (luaArrayTable2[i] as LuaTable).ToArrayTable();
			for (int j = 1; j <= luaArrayTable4.Length; j++)
			{
				int key = (int)(double)luaArrayTable4[j];
				if (!dictionary.ContainsKey(key))
				{
					dictionary[key] = new List<Vector2>();
				}
				dictionary[key].Add(item);
			}
		}
		foreach (KeyValuePair<int, List<Vector2>> item2 in dictionary)
		{
			list.Add(new Effect(item2.Key, item2.Value));
		}
		return list;
	}
}
