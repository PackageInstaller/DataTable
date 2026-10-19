using System.Collections.Generic;
using ACT.Config;
using ACT.Core;

namespace ACT.Model;

public class RogueCard
{
	public int id;

	public int triggerId;

	public List<int> effects;

	public int suitid;

	public int level;

	public int rarity => GetRarity();

	public int weight => GetSuitWeight();

	public RogueCard(int _id, int _triggerId, List<int> _effects, int _level, int _suitid)
	{
		id = _id;
		triggerId = _triggerId;
		effects = _effects;
		level = _level;
		suitid = _suitid;
	}

	public int GetSuitWeight()
	{
		return CoreUtils.GetData(id, RuntimeConfigs.data.rogueEffectCards).weight * Model<RoGueModel>.Interface.GetSuitWeightById(suitid);
	}

	public int GetRarity()
	{
		int num = 0;
		RogueTriggerCard data = CoreUtils.GetData(triggerId, RuntimeConfigs.data.rogueTriggerCards);
		for (int i = 0; i < effects.Count; i++)
		{
			RogueEffectCard data2 = CoreUtils.GetData(effects[i], RuntimeConfigs.data.rogueEffectCards);
			if (num < data2.rarity)
			{
				num = data2.rarity;
			}
		}
		if (num < data.rarity)
		{
			num = data.rarity;
		}
		return num;
	}
}
