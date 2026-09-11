using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationQTEData : T0InterationBaseData
{
	public Vector3 UIShowPrefab;

	public Vector3 pos;

	public List<Vector3> pathList;

	public Vector3 center;

	public Vector3 size;

	public GameObject timelinePrafab;

	public GameObject uiPrefab;

	public Vector3 ui_pos;

	private T0InterationQteTips qteTips;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Qte;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0WorldAgent agent = T0WorldScene.Scene.agentManager.GetAgent(entityID);
		GameObject gameObject = new GameObject("QTETips");
		qteTips = gameObject.AddComponent<T0InterationQteTips>();
		qteTips.InitQTE(this);
		gameObject.transform.parent = agent.transform;
		gameObject.transform.localPosition = pos;
		if (timelinePrafab != null)
		{
			qteTips.InitTimeline(behaviour.brain, timelinePrafab);
		}
		if (uiPrefab != null)
		{
			qteTips.InitQTEUITips(uiPrefab, ui_pos);
		}
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void DisposeEvent()
	{
		qteTips.Dispose();
	}
}
