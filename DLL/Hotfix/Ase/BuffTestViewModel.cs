using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class BuffTestViewModel : OptionBase
{
	private List<BTEntityViewModel> bteVMs = new List<BTEntityViewModel>();

	private InteractionRequest updateEntityListRequest = new InteractionRequest();

	private int count;

	private bool isUpdate;

	public bool IsUpdate
	{
		get
		{
			return isUpdate;
		}
		set
		{
			isUpdate = value;
		}
	}

	public int Count => count;

	public List<BTEntityViewModel> BteVMs => bteVMs;

	public InteractionRequest UpdateEntityListRequest => updateEntityListRequest;

	public void InitEntityVms(WorldBase worldBase)
	{
		List<BaseEntity> allEntity = worldBase.GetSystem<EntitySystem>().GetAllEntity();
		count = 0;
		foreach (BaseEntity item in allEntity)
		{
			if (item != null && item.IsSurvival)
			{
				bteVMs.Add(new BTEntityViewModel(item));
				count++;
			}
		}
	}

	public void UpdateEntityVms(WorldBase worldBase)
	{
		List<BaseEntity> allEntity = worldBase.GetSystem<EntitySystem>().GetAllEntity();
		count = 0;
		foreach (BaseEntity item in allEntity)
		{
			if (item != null && item.IsSurvival)
			{
				if (bteVMs.Count > count)
				{
					bteVMs[count].UpdateEntity(item);
				}
				else
				{
					bteVMs.Add(new BTEntityViewModel(item));
				}
				count++;
			}
		}
		updateEntityListRequest.Raise();
	}

	public void OnUpdate()
	{
		if (isUpdate)
		{
			for (int i = 0; i < count; i++)
			{
				bteVMs[i].OnUpdate();
			}
		}
	}
}
