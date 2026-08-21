using System.Collections.Generic;
using Ase;
using Ase.ECS;

public class MultiAttributeBuffs
{
	private BaseSystem system;

	public void OnInit(BaseSystem baseSystem)
	{
		system = baseSystem;
	}

	public void OnStart()
	{
		DRAttributeMatching[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRAttributeMatching>();
		if (allDataRow == null)
		{
			return;
		}
		Dictionary<HeroAttributeEnum, List<BaseEntity>> attrbuteEntityDic = GetAttrbuteEntityDic();
		if (attrbuteEntityDic == null)
		{
			return;
		}
		DRAttributeMatching[] array = allDataRow;
		foreach (DRAttributeMatching dRAttributeMatching in array)
		{
			HeroAttributeEnum heroAttributeEnum = dRAttributeMatching.HeroAttributeEnum;
			if (attrbuteEntityDic.TryGetValue(heroAttributeEnum, out var value))
			{
				int attributeBuffId = GetAttributeBuffId(dRAttributeMatching, GetAttributeCount(value));
				if (attributeBuffId != 0)
				{
					OnAddAttributeBuff(value, attributeBuffId);
				}
			}
		}
	}

	private int GetAttributeCount(List<BaseEntity> list)
	{
		List<int> list2 = new List<int>();
		foreach (BaseEntity item in list)
		{
			if (!list2.Contains(item.EntityId))
			{
				list2.Add(item.EntityId);
			}
		}
		return list2.Count;
	}

	private Dictionary<HeroAttributeEnum, List<BaseEntity>> GetAttrbuteEntityDic()
	{
		EntitySystem entitySystem = system.GetSystem<EntitySystem>();
		if (entitySystem == null)
		{
			return null;
		}
		Dictionary<HeroAttributeEnum, List<BaseEntity>> dictionary = new Dictionary<HeroAttributeEnum, List<BaseEntity>>();
		foreach (HeroEntity item in entitySystem.GetTeamHero())
		{
			if (!dictionary.TryGetValue(item.BattleHeroData.Attribute, out var value))
			{
				value = new List<BaseEntity>();
				dictionary.Add(item.BattleHeroData.Attribute, value);
			}
			value.Add(item);
		}
		return dictionary;
	}

	private int GetAttributeBuffId(DRAttributeMatching tbl, int attributeCount)
	{
		string conditionBuffs = tbl.ConditionBuffs;
		if (conditionBuffs == null || string.IsNullOrEmpty(conditionBuffs))
		{
			return 0;
		}
		string[] array = conditionBuffs.Split('#');
		if (array == null || array.Length == 0)
		{
			return 0;
		}
		for (int i = 0; i < array.Length; i++)
		{
			string[] array2 = array[i].Split(',');
			if (array2 != null && array2.Length == 2 && attributeCount == int.Parse(array2[0]))
			{
				return int.Parse(array2[1]);
			}
		}
		return 0;
	}

	private void OnAddAttributeBuff(List<BaseEntity> list, int buffId)
	{
		BuffSystem buffSystem = system.GetSystem<BuffSystem>();
		if (buffSystem == null)
		{
			return;
		}
		foreach (BaseEntity item in list)
		{
			buffSystem.CheckAndAcquireBuff(item, item, buffId);
		}
	}
}
