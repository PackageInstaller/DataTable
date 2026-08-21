using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationConditionData : T0InterationConditionBaseData
{
	public float condition_valut_float;

	public int condition_valut_int;

	public OpEnum op;

	public int judgeEntityID;

	private Transform judgeAgentTrs;

	public string judgeName;

	private Transform GetJudgeAgentTransform()
	{
		if (judgeAgentTrs == null)
		{
			judgeAgentTrs = T0WorldHelper.GetTrsByEntityID(judgeEntityID);
		}
		return judgeAgentTrs;
	}

	public override bool CheckIsArriveCondition()
	{
		if (condition_type == T0InterationContitionTypeEnum.Distance)
		{
			Transform judgeAgentTransform = GetJudgeAgentTransform();
			T0WorldAgent agent = T0WorldScene.Scene.agentManager.GetAgent(entityID);
			if (judgeAgentTransform != null)
			{
				float num = Vector3.Distance(judgeAgentTransform.position, agent.transform.position);
				if (op == OpEnum.Equal)
				{
					return num == condition_valut_float;
				}
				if (op == OpEnum.Greater)
				{
					return num > condition_valut_float;
				}
				if (op == OpEnum.Less)
				{
					return num < condition_valut_float;
				}
			}
		}
		else if (condition_type == T0InterationContitionTypeEnum.AnimatorTimes)
		{
			return CheckAnimatorTimesFinish();
		}
		return false;
	}

	public bool CheckAnimatorTimesFinish()
	{
		int recordCount = T0WorldScene.Scene.dataContext.GetRecordCount(judgeName);
		if (op == OpEnum.Equal)
		{
			if (recordCount % condition_valut_int == 0)
			{
				return recordCount > 0;
			}
			return false;
		}
		if (op == OpEnum.Greater)
		{
			return recordCount > condition_valut_int;
		}
		if (op == OpEnum.Less)
		{
			return recordCount < condition_valut_int;
		}
		return false;
	}
}
