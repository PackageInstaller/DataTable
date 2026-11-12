using System.Collections.Generic;
using UnityEngine;

public class AdventureEntityGroup
{
	public string id { get; private set; }

	public List<LogicEntity> members { get; private set; } = new List<LogicEntity>();

	public bool isAlive
	{
		get
		{
			bool result = false;
			for (int i = 0; i < members.Count; i++)
			{
				if (members.get_Item(i).GetLogicComponent<ActorHealthInfo>().isAlive)
				{
					result = true;
					break;
				}
			}
			return result;
		}
	}

	public AdventureEntityGroup(string groupID)
	{
		id = groupID;
	}

	public bool AddMember(LogicEntity member)
	{
		if (members.Contains(member))
		{
			return false;
		}
		members.Add(member);
		return true;
	}

	public bool RemoveMember(LogicEntity member)
	{
		return members.Remove(member);
	}

	public bool ContainMember(LogicEntity member)
	{
		return members.Contains(member);
	}

	public LogicEntity GetMemberByDataID(int dataID)
	{
		if (members == null || members.Count == 0)
		{
			Debug.LogError("角色组为空!");
			return null;
		}
		for (int i = 0; i < members.Count; i++)
		{
			LogicEntity logicEntity = members.get_Item(i);
			if (null == logicEntity)
			{
				Debug.LogError("组成员为空" + id);
				continue;
			}
			AdventureActor adventureActor = logicEntity as AdventureActor;
			if (!(null == adventureActor) && adventureActor.dataID == dataID)
			{
				return adventureActor;
			}
		}
		return null;
	}

	public void Broadcast(IEvent evt, bool sendMyself = false)
	{
		for (int i = 0; i < members.Count; i++)
		{
			AdventureActor component = members.get_Item(i).GetComponent<AdventureActor>();
			if (!(null == component) && (sendMyself || !evt.sender.Equals(component)))
			{
				(component as IGroupMessage)?.OnMessage(evt);
			}
		}
		ModuleController<AdventureModuleController>.Instance?.ReleaseEvent((BaseAdventureEvent)evt);
	}
}
