using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class BTEntityViewModel : OptionBase
{
	private int entityId;

	private int configId;

	private string name;

	private int count;

	private InteractionRequest updateBuffListRequest = new InteractionRequest();

	private List<BTBuffViewModel> btbVMs = new List<BTBuffViewModel>();

	private BaseEntity entity;

	public List<BTBuffViewModel> BtbVMs => btbVMs;

	public int Count => count;

	public int EntityId
	{
		get
		{
			return entityId;
		}
		set
		{
			Set(ref entityId, value, "EntityId");
		}
	}

	public int ConfigId
	{
		get
		{
			return configId;
		}
		set
		{
			Set(ref configId, value, "ConfigId");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public InteractionRequest UpdateBuffListRequest => updateBuffListRequest;

	public BTEntityViewModel(BaseEntity entity)
	{
		entityId = entity.Id;
		configId = entity.EntityId;
		name = entity.Name();
		this.entity = entity;
		LinkedList<Buff> linkedList = entity.GetSystem<BuffSystem>()?.GetEntityBuffs(entityId);
		if (linkedList == null)
		{
			return;
		}
		foreach (Buff item in linkedList)
		{
			btbVMs.Add(new BTBuffViewModel(item));
		}
		count = linkedList.Count;
	}

	public void UpdateEntityBuffs()
	{
		if (entity == null)
		{
			return;
		}
		LinkedList<Buff> linkedList = entity.GetSystem<BuffSystem>()?.GetEntityBuffs(entityId);
		if (linkedList == null)
		{
			return;
		}
		count = 0;
		foreach (Buff item in linkedList)
		{
			if (btbVMs.Count > count)
			{
				btbVMs[count].UpdateBuff(item);
			}
			else
			{
				btbVMs.Add(new BTBuffViewModel(item));
			}
			count++;
		}
		updateBuffListRequest.Raise();
	}

	public void UpdateEntity(BaseEntity entity)
	{
		EntityId = entity.Id;
		ConfigId = entity.EntityId;
		Name = entity.Name();
		this.entity = entity;
		LinkedList<Buff> linkedList = entity.GetSystem<BuffSystem>()?.GetEntityBuffs(entityId);
		if (linkedList == null)
		{
			return;
		}
		count = 0;
		foreach (Buff item in linkedList)
		{
			if (btbVMs.Count > count)
			{
				btbVMs[count].UpdateBuff(item);
			}
			else
			{
				btbVMs.Add(new BTBuffViewModel(item));
			}
			count++;
		}
		updateBuffListRequest.Raise();
	}

	public void OnUpdate()
	{
		for (int i = 0; i < btbVMs.Count; i++)
		{
			btbVMs[i].OnUpdate();
		}
	}
}
