using System.Collections.Generic;
using UnityEngine;

namespace T0World;

public class T0WorldAgentManager
{
	private List<T0WorldAgent> _agents = new List<T0WorldAgent>();

	private T0CharacterAgent characteraAgent;

	public List<T0WorldAgent> agents => _agents;

	public T0CharacterAgent CharacteraAgent
	{
		get
		{
			if (characteraAgent == null)
			{
				characteraAgent = GetCharacterAgent();
			}
			return characteraAgent;
		}
	}

	public void Init()
	{
	}

	public void Dispose()
	{
		if (_agents != null)
		{
			for (int num = _agents.Count - 1; num >= 0; num--)
			{
				_agents[num].DisposeAgent();
			}
			_agents.Clear();
		}
		characteraAgent = null;
	}

	public void Register(T0WorldAgent agent)
	{
		_agents.Add(agent);
		if (!(T0WorldScene.Scene.mapData != null))
		{
			return;
		}
		foreach (T0EntityData entity in T0WorldScene.Scene.mapData.entityList)
		{
			if (agent.Blackboard.EntityID == entity.entityID)
			{
				agent.Blackboard.SetInterationData(entity.interationList);
				if (entity.initTreeID >= 0)
				{
					agent.TriggerTargetInteraction(entity.initTreeID);
				}
			}
		}
	}

	public void UnRegister(T0WorldAgent agent)
	{
		_agents.Remove(agent);
	}

	public T0CharacterAgent GetCharacterAgent()
	{
		for (int num = _agents.Count - 1; num >= 0; num--)
		{
			T0WorldAgent t0WorldAgent = _agents[num];
			if (t0WorldAgent.GetAgentLayer() == T0AgentLayer.Character)
			{
				T0CharacterAgent t0CharacterAgent = t0WorldAgent as T0CharacterAgent;
				if (t0CharacterAgent != null && t0CharacterAgent.CharacterBoard.characterID == T0WorldScene.Scene.characterID)
				{
					return t0CharacterAgent;
				}
			}
		}
		return null;
	}

	public T0WorldAgent GetAgent(int entityID)
	{
		for (int num = _agents.Count - 1; num >= 0; num--)
		{
			T0WorldAgent t0WorldAgent = _agents[num];
			if (t0WorldAgent.Blackboard.EntityID == entityID)
			{
				return t0WorldAgent;
			}
		}
		return null;
	}

	public void Tick()
	{
		int num = _agents.Count - 1;
		while (num >= 0 && _agents.Count > num)
		{
			_agents[num]?.UpdateAgent();
			num--;
		}
	}

	public void LateTick()
	{
		int num = _agents.Count - 1;
		while (num >= 0 && _agents != null)
		{
			_agents[num]?.LateUpdateAgent();
			num--;
		}
	}

	public void InitAgentData(T0WorldMapData mapData)
	{
		foreach (T0EntityData entity in mapData.entityList)
		{
			if (entity.loadType == LoadTypeEnum.NO_LOAD_ANY)
			{
				CreateNormalAgent(entity);
			}
			else if (entity.loadType == LoadTypeEnum.LOAD_IN_INIT)
			{
				CreateLoadAgent(entity);
			}
		}
	}

	public void CreateNormalAgent(T0EntityData entityData)
	{
		GameObject gameObject = new GameObject("Agent_" + entityData.entityID);
		gameObject.transform.position = entityData.pos;
		gameObject.transform.rotation = Quaternion.Euler(entityData.rot);
		gameObject.transform.SetParent(T0WorldScene.Scene.T0EntityContent);
		gameObject.AddComponent<T0WorldBlackboard>().EntityID = entityData.entityID;
		gameObject.AddComponent<T0WorldInteractionBehavior>();
		gameObject.AddComponent<T0FurnitureAgent>().Initialize();
	}

	public void CreateLoadAgent(T0EntityData entityData)
	{
		GameObject gameObject = Asset.Instantiate(entityData.loadResPath);
		gameObject.transform.position = entityData.pos;
		gameObject.transform.rotation = Quaternion.Euler(entityData.rot);
		gameObject.transform.SetParent(T0WorldScene.Scene.T0EntityContent);
		U3DUtil.Get<T0WorldBlackboard>(gameObject).EntityID = entityData.entityID;
		T0WorldAgent t0WorldAgent = gameObject.GetComponent<T0WorldAgent>();
		if (t0WorldAgent != null && t0WorldAgent.GetAgentLayer() == T0AgentLayer.Character)
		{
			gameObject.GetComponent<T0CharacterBlackborad>().loadResPath = entityData.loadResPath;
		}
		else
		{
			gameObject.AddComponent<T0WorldInteractionBehavior>();
			t0WorldAgent = gameObject.AddComponent<T0FurnitureAgent>();
		}
		t0WorldAgent.Initialize();
	}

	public void RefreshFurnitureAgentEvent()
	{
		for (int num = _agents.Count - 1; num >= 0; num--)
		{
			T0WorldAgent t0WorldAgent = _agents[num];
			if (t0WorldAgent.GetAgentLayer() == T0AgentLayer.Furniture)
			{
				(t0WorldAgent as T0FurnitureAgent).UpdateEvent();
			}
		}
	}
}
