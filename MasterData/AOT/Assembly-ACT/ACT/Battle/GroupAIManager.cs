using System.Collections.Generic;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Battle;

public class GroupAIManager : Singleton<GroupAIManager>
{
	public Dictionary<int, ConfigGroupAI> m_ConfigGroupAIs = new Dictionary<int, ConfigGroupAI>();

	public Dictionary<int, List<Entity>> groups = new Dictionary<int, List<Entity>>();

	public Dictionary<int, Entity> groupAIEntity = new Dictionary<int, Entity>();

	public override ContextType ContextType => ContextType.GAME;

	public override void Init()
	{
		foreach (ConfigGroupAI configGroupAI in GameLoader.meta.groupAIs.configGroupAIs)
		{
			m_ConfigGroupAIs.Add(configGroupAI.id, configGroupAI);
		}
	}

	public override void UnInit()
	{
		List<int> list = ListPool<int>.Get();
		foreach (KeyValuePair<int, Entity> item in groupAIEntity)
		{
			list.Add(item.Key);
		}
		foreach (int item2 in list)
		{
			RemoveGroup(item2);
		}
		ListPool<int>.Release(list);
		m_ConfigGroupAIs.Clear();
		groups.Clear();
		groupAIEntity.Clear();
		base.UnInit();
	}

	public void RegisterGroupAI(Entity behave, int groupId, int aiIndex)
	{
		if (groupId >= 0 && aiIndex >= 0)
		{
			if (!groups.ContainsKey(groupId))
			{
				groups[groupId] = new List<Entity>();
			}
			if (groups[groupId].Count == 0)
			{
				AddGroup(groupId, aiIndex);
			}
			groups[groupId].Add(behave);
		}
	}

	public void UnRegisterGroupAI(Entity behave, int index)
	{
		if (groups.ContainsKey(index) && groups[index].Remove(behave) && groups[index].Count == 0)
		{
			RemoveGroup(index);
		}
	}

	private void AddGroup(int groupId, int aiIndex)
	{
		Entity entity = GameManager.entities.factory.CreateGroupAIEntity(groupId, m_ConfigGroupAIs[aiIndex].behaviorTreeAssetID);
		groupAIEntity.Add(groupId, entity);
		MonoECS.instance.SpawnGroupAI(entity, groupId, m_ConfigGroupAIs[aiIndex].behaviorTreeAssetID).Forget();
	}

	private void RemoveGroup(int index)
	{
		MonoECS.instance.TryRemoveBehave(groupAIEntity[index]);
		groupAIEntity.Remove(index);
	}

	public bool GetGroupAI(int groupId, out Entity entity)
	{
		if (groupAIEntity.TryGetValue(groupId, out var value))
		{
			entity = value;
			return true;
		}
		entity = default;
		return false;
	}
}
