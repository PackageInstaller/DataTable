using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle;

public static class BossInfoGroupUtility
{
	public static bool TryGetGroupId(Entity entity, out int groupId)
	{
		groupId = -1;
		if (!entity.IsValid || entity.GetEntityType() != EntityType.Boss)
		{
			return false;
		}
		if (!entity.TryGetCompMonster(out CompMonster component) || !component.shareBossInfoUI || !entity.TryGetCompAI(out CompAI component2) || component2.groupUid < 0)
		{
			return false;
		}
		groupId = component2.groupUid;
		return true;
	}

	public static List<Entity> GetMembers(int groupId, bool aliveOnly = false)
	{
		List<Entity> list = new List<Entity>();
		if (groupId < 0)
		{
			return list;
		}
		foreach (Entity allEntity in GameManager.entities.GetAllEntities())
		{
			if (IsMember(allEntity, groupId) && (!aliveOnly || allEntity.IsAlive()))
			{
				list.Add(allEntity);
			}
		}
		return list;
	}

	public static bool HasAliveMember(int groupId, Entity excludedEntity = default(Entity))
	{
		if (groupId < 0)
		{
			return false;
		}
		foreach (Entity allEntity in GameManager.entities.GetAllEntities())
		{
			if (allEntity != excludedEntity && IsMember(allEntity, groupId) && allEntity.IsAlive())
			{
				return true;
			}
		}
		return false;
	}

	public static bool IsMember(Entity entity, int groupId)
	{
		if (TryGetGroupId(entity, out var groupId2))
		{
			return groupId2 == groupId;
		}
		return false;
	}
}
