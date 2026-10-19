using System.Collections.Generic;
using Bamboo.Collections;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Buff数量", "Function", new string[] { "get", "buff", "num", "value", "float", "int" })]
public class GetBuffNum : ConfigFunction<float>
{
	public enum SpecailBuffType
	{
		normal,
		specialDebuff
	}

	public BuffType type;

	public SpecailBuffType haveSpecailBuffType;

	protected override float Evaluate(ActionMemory memory)
	{
		BSet<Ability> abilities = memory.target.entity.GetCompAbility().abilities;
		int num = 0;
		if (type == BuffType.Debuff && haveSpecailBuffType == SpecailBuffType.specialDebuff)
		{
			HashSet<uint> hashSet = new HashSet<uint>();
			foreach (Ability item in abilities)
			{
				if (item.config.buffType != BuffType.Debuff)
				{
					continue;
				}
				uint debuffId = item.config.debuffName;
				if (!hashSet.Contains(debuffId))
				{
					hashSet.Add(debuffId);
					num += GameLoader.meta.configDebuff.debuffs.Find((DebuffItem d) => d.id == debuffId).weight;
				}
			}
		}
		else
		{
			foreach (Ability item2 in abilities)
			{
				if (item2.config.buffType == type)
				{
					num++;
				}
			}
		}
		return num;
	}
}
