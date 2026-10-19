using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.UI;

public class EntityBuffIconData
{
	private Dictionary<string, BuffIconInfo> _buffIconInfoMap = new Dictionary<string, BuffIconInfo>();

	private List<BuffIconInfo> _sortedBuffList = new List<BuffIconInfo>();

	public Entity Entity { get; private set; }

	public EntityBuffIconData(Entity entity)
	{
		Entity = entity;
		RefreshFromEntity();
	}

	public bool RefreshFromEntity()
	{
		bool result = false;
		HashSet<string> hashSet = BuffListOptimizer.GetHashSet();
		if (Entity.IsLogicAvailable() && Entity.TryGetCompAbility(out CompAbility component))
		{
			foreach (Ability ability in component.abilities)
			{
				if (ability?.config == null || !ability.config.showIcon || ability.stack <= 0)
				{
					continue;
				}
				string name = ability.config.name;
				hashSet.Add(name);
				if (_buffIconInfoMap.TryGetValue(name, out var value))
				{
					if (value.Stack != ability.stack)
					{
						value.Stack = ability.stack;
						result = true;
					}
				}
				else
				{
					AddAbility(name, ability.config.iconID, ability.config.iconPriority, ability.config.iconType, ability.stack);
					result = true;
				}
			}
		}
		List<string> list = BuffListOptimizer.CalculateRemovedKeys(_buffIconInfoMap, hashSet);
		foreach (string item in list)
		{
			RemoveAbility(item);
			result = true;
		}
		BuffListOptimizer.ReleaseHashSet(hashSet);
		BuffListOptimizer.ReleaseStringList(list);
		return result;
	}

	public void AddAbility(string abilityName, int iconId, int priority, BuffIconType iconType, int stack)
	{
		if (!_buffIconInfoMap.ContainsKey(abilityName))
		{
			BuffIconInfo buffIconInfo = new BuffIconInfo(abilityName, iconId, priority, iconType, stack);
			_buffIconInfoMap[abilityName] = buffIconInfo;
			InsertNewAtHeadBinary(_sortedBuffList, buffIconInfo);
		}
	}

	public void RemoveAbility(string abilityName)
	{
		if (_buffIconInfoMap.Remove(abilityName, out var value))
		{
			_sortedBuffList.Remove(value);
		}
	}

	public List<BuffIconInfo> GetSortedBuffList()
	{
		return _sortedBuffList;
	}

	private int FindHeadIndexDescBinary(List<BuffIconInfo> list, int priority)
	{
		int num = 0;
		int num2 = list.Count;
		while (num < num2)
		{
			int num3 = num + num2 >> 1;
			if (list[num3].Priority > priority)
			{
				num = num3 + 1;
			}
			else
			{
				num2 = num3;
			}
		}
		return num;
	}

	private void InsertNewAtHeadBinary(List<BuffIconInfo> list, BuffIconInfo item)
	{
		int index = FindHeadIndexDescBinary(list, item.Priority);
		list.Insert(index, item);
	}
}
