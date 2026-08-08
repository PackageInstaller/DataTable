using UnityEngine;

namespace FlowCanvas.Nodes;

public static class SpawnPendant
{
	public static GameObject Create<T>(int agent, string path, bool isAttach = false, string attachName = "") where T : MonoBehaviour, IPendant
	{
		NAgent agent2 = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(agent);
		if (null != agent2)
		{
			GameObject gameObject = agent2.gameObject.GetComponent<ComponentPendant>().CreatePendant<T>(path);
			if (gameObject != null)
			{
				if (isAttach)
				{
					Transform parent = agent2.transform;
					if (!string.IsNullOrEmpty(attachName))
					{
						AttachPointSetup component = agent2.GetComponent<AttachPointSetup>();
						if (component != null)
						{
							parent = component.GetAttachPoint(attachName);
						}
					}
					gameObject.transform.parent = parent;
					gameObject.transform.localPosition = Vector3.zero;
				}
				else
				{
					gameObject.transform.position = agent2.Position;
				}
				gameObject.transform.forward = agent2.Forward;
			}
			return gameObject;
		}
		return null;
	}
}
