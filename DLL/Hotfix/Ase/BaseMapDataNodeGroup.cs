using System.Collections.Generic;
using Ase.ECS;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

public abstract class BaseMapDataNodeGroup<T> : SerializedMonoBehaviour, IInit, IStart, IDispose where T : BaseMapDataNode
{
	protected SceneSystem sceneSystem;

	protected List<T> nodeList = new List<T>();

	public LevelArea levelArea;

	public SceneSystem SceneSystem
	{
		get
		{
			return sceneSystem;
		}
		set
		{
			sceneSystem = value;
		}
	}

	public WorldBase World => sceneSystem?.GetWorld();

	public virtual string NodeGroupType => "Default";

	public void OnInit(object data = null)
	{
		sceneSystem = (SceneSystem)data;
		T[] componentsInChildren = ((Component)this).transform.GetComponentsInChildren<T>();
		nodeList.Clear();
		T[] array = componentsInChildren;
		foreach (T val in array)
		{
			if (((Component)(object)val).gameObject.activeSelf)
			{
				nodeList.Add(val);
				val.OnInit(data);
			}
		}
		OnInited(data);
	}

	public virtual void OnInited(object data = null)
	{
	}

	public void OnStart(object data = null)
	{
		OnStarted();
		foreach (T node in nodeList)
		{
			node.OnStart(data);
		}
	}

	public virtual void OnStarted(object data = null)
	{
	}

	public virtual void ClearDataRefrence()
	{
		sceneSystem = null;
	}

	public void ReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
		for (int i = 0; i < nodeList.Count; i++)
		{
			nodeList[i].ReceiveMapDataEvent(eventType, otherEntity);
		}
		OnReceiveMapDataEvent(eventType, otherEntity);
	}

	public virtual void OnReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
	}

	public abstract void OnDispose();
}
