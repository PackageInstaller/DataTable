using UnityEngine;

namespace T0World;

public static class T0WorldHelper
{
	public static Transform GetTrsByEntityID(int entityID, bool ignoreMissing = false)
	{
		if (entityID == -1)
		{
			return T0WorldScene.Scene.player.transform;
		}
		T0WorldAgent agent = T0WorldScene.Scene.agentManager.GetAgent(entityID);
		if (agent != null)
		{
			return agent.transform;
		}
		if (!ignoreMissing)
		{
			Debug.LogError("没有找到目标对象：" + entityID);
		}
		return null;
	}
}
