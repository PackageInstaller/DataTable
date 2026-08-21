using System.Collections.Generic;
using UnityEngine;

namespace Capture.Runtime;

public class CaptureEntity
{
	private int entityIdentify;

	public int entityType = EntityType.Unknow;

	public GameObject obj;

	private EntityArcheType archeType = EntityArcheType.None;

	private Dictionary<int, long> components = new Dictionary<int, long>(10);

	public bool isOnScreen = true;

	public OBBCalculator obbCalculator;

	public int Identify
	{
		get
		{
			return entityIdentify;
		}
		set
		{
			entityIdentify = value;
		}
	}

	public EntityArcheType ArcheType => archeType;

	public bool IsOcculuded()
	{
		if (GetComponent(ComponentConst.OcclusionComponentType, out var id))
		{
			ComponentAccessor<OcculusionComponent> occulusionComponents = WorldManager.Instance.GetGameContext().componentMgr.occulusionComponents;
			int componentIndex = occulusionComponents.GetComponentIndex(id);
			return occulusionComponents.ComponentList[componentIndex].isOcculuded;
		}
		return false;
	}

	public bool HasComponent(int type)
	{
		return (archeType.type & (1 << type)) > 0;
	}

	public bool GetComponent(int type, out long id)
	{
		if (components.TryGetValue(type, out var value))
		{
			id = value;
			return true;
		}
		id = -1L;
		return false;
	}

	public bool AdaptArcheType(EntityArcheType arch)
	{
		return arch.type == archeType.type;
	}

	public void AddComponent(int type)
	{
		if (!components.ContainsKey(type))
		{
			components.Add(type, WorldManager.ComponentMgr.AllocComponent(type));
		}
		archeType.type |= 1 << type;
	}

	public void RemoveComponent(int type)
	{
		if (components.TryGetValue(type, out var value))
		{
			WorldManager.ComponentMgr.ReleaseComponnet(type, value);
			components.Remove(type);
		}
		archeType.type &= ~(1 << type);
	}

	public void Dispose()
	{
		WorldManager.Instance.GetGameContext().RemoveEntity(Identify);
		if (obj != null)
		{
			Object.Destroy(obj);
		}
	}
}
