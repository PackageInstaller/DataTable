using System;

namespace T0World;

[Serializable]
public class T0InterationIfElseData : T0InterationLogicBaseData
{
	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.IsFinish = true;
	}

	public override void AddChildEvent()
	{
		for (int i = 0; i < child.Count; i++)
		{
			T0InterationBaseData t0InterationBaseData = child[i];
			if (t0InterationBaseData != null && (!(t0InterationBaseData is T0InterationConditionBaseData) || (t0InterationBaseData as T0InterationConditionBaseData).CheckIsArriveCondition()))
			{
				t0InterationBaseData.InitData();
				T0WorldScene.Scene.agentManager.GetAgent(t0InterationBaseData.entityID).Blackboard.EventContext.AddEvent(t0InterationBaseData);
				if (t0InterationBaseData.isFoces)
				{
					T0WorldScene.Scene.interactionManager.InteractContext.RegisterFocusEVent(t0InterationBaseData);
				}
				break;
			}
		}
	}
}
