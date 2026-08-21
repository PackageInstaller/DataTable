using System;
using System.Collections.Generic;
using Ase;

[Serializable]
public class TaskIndexStateCondition : ParadoxParamterConditionBase
{
	public bool invertCondition;

	public List<OpenCondition> TaskConditions = new List<OpenCondition>();

	public override bool SatisfyCondition(object data)
	{
		if (!(data is SceneSystem sceneSystem))
		{
			return false;
		}
		bool flag = false;
		if (invertCondition)
		{
			return !sceneSystem.GetSystem<TaskSystem>().CheckMapDataNodeActived(TaskConditions);
		}
		return sceneSystem.GetSystem<TaskSystem>().CheckMapDataNodeActived(TaskConditions);
	}
}
