using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationControlEntityShow : T0InterationFunctionDataBase
{
	public bool isShow = true;

	public int workIngEntityID = -1;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0EntityData t0EntityData = T0WorldScene.Scene.mapData.entityList.Find((T0EntityData data) => data.entityID == workIngEntityID);
		if (t0EntityData != null)
		{
			if (isShow)
			{
				LoadEntity(t0EntityData);
			}
			else
			{
				DestroyEntity(t0EntityData);
			}
		}
		base.IsFinish = true;
	}

	public void LoadEntity(T0EntityData entityData)
	{
		GameObject gameObject = Asset.Instantiate(entityData.loadResPath);
		gameObject.transform.SetParent(T0WorldScene.Scene.T0EntityContent);
		U3DUtil.Get<T0WorldBlackboard>(gameObject).EntityID = entityData.entityID;
		gameObject.GetComponent<T0WorldAgent>().Initialize();
	}

	public void DestroyEntity(T0EntityData entityData)
	{
		T0WorldAgent t0WorldAgent = T0WorldScene.Scene.agentManager.agents.Find((T0WorldAgent a) => a.Blackboard.EntityID == entityData.entityID);
		if (t0WorldAgent != null)
		{
			Asset.Unload(entityData.loadResPath);
			UnityEngine.Object.Destroy(t0WorldAgent.gameObject);
		}
	}
}
