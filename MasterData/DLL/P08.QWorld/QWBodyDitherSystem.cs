using System;
using System.Collections.Generic;
using UnityEngine;

public class QWBodyDitherSystem
{
	public static QWBodyDitherSystem Instance;

	public HashSet<QWBodyDitherComponent> entity;

	public void Init()
	{
		entity = new HashSet<QWBodyDitherComponent>();
		Instance = this;
	}

	public void Tick()
	{
		Vector3 position = QWorldCameraManager.Instance.MainCamera.transform.position;
		foreach (QWBodyDitherComponent item in entity)
		{
			QWAgent agent = item.GetAgent();
			if (!agent || !agent.Blackboard.isInStage || agent.Blackboard.isInHide)
			{
				continue;
			}
			float ratio = 1f;
			float num = 0f;
			QWAgentLayer agentLayer = agent.GetAgentLayer();
			if ((uint)(agentLayer - 1) <= 1u)
			{
				if (agent.GetAgentLayer() == QWAgentLayer.Player)
				{
					QWCharacterBlackboard qWCharacterBlackboard = agent.Blackboard as QWCharacterBlackboard;
					if (qWCharacterBlackboard.playerHide)
					{
						ratio = 0f;
						qWCharacterBlackboard.curProxy.EnableShadow(enable: false);
						goto IL_0111;
					}
					qWCharacterBlackboard.curProxy.EnableShadow(enable: true);
				}
				num = Vector3.Distance(position, agent.Center);
				if (num <= agent.Blackboard.ditherMax)
				{
					ratio = MathF.Max((num - agent.Blackboard.ditherMin) / (agent.Blackboard.ditherMax - agent.Blackboard.ditherMin), 0f);
				}
			}
			goto IL_0111;
			IL_0111:
			item.DispatchDitherChange(ratio);
		}
	}

	public void RegisterEntity(QWBodyDitherComponent comp)
	{
		entity.Add(comp);
	}

	public void RemoveEntity(QWBodyDitherComponent comp)
	{
		entity.Remove(comp);
	}

	public void Dispose()
	{
		entity.Clear();
		Instance = null;
	}
}
