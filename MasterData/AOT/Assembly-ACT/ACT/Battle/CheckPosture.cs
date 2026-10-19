using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("架势值判定，自身架势值> Percent返还success，否则返还failure")]
public class CheckPosture : Conditional
{
	public enum CheckPostureType
	{
		curValuePercentCompare,
		curStageCompare
	}

	public CheckPostureType checkPostureType;

	public SharedFloat posturePercent;

	public SharedInt stageCompare;

	public Condition condition;

	public override TaskStatus OnUpdate()
	{
		Entity entity = ((ActBehaviorTree)Owner).Entity;
		CompAbility compAbility = entity.GetCompAbility();
		bool flag = false;
		int num = compAbility.posture / compAbility.maxPosture;
		flag = (float)num > posturePercent.Value;
		switch (checkPostureType)
		{
		case CheckPostureType.curValuePercentCompare:
			switch (condition)
			{
			case Condition.Greater:
			case Condition.GreaterAndEqual:
				flag = (float)num >= posturePercent.Value;
				break;
			case Condition.Less:
			case Condition.LessAndEqual:
				flag = (float)num <= posturePercent.Value;
				break;
			case Condition.Equal:
				flag = Mathf.Abs((float)num - posturePercent.Value) < 0.02f;
				break;
			}
			break;
		case CheckPostureType.curStageCompare:
		{
			flag = false;
			int num2 = -1;
			ConfigCharacter config = entity.GetConfig();
			float num3 = config.posturePercent[0];
			for (int i = 0; i < config.posturePercent.Length; i++)
			{
				if ((float)num < num3)
				{
					num2 = i + 1;
					break;
				}
			}
			if (num2 == -1)
			{
				return TaskStatus.Failure;
			}
			switch (condition)
			{
			case Condition.Greater:
			case Condition.GreaterAndEqual:
				flag = num2 >= stageCompare.Value;
				break;
			case Condition.Less:
			case Condition.LessAndEqual:
				flag = num2 <= stageCompare.Value;
				break;
			case Condition.Equal:
				flag = num2 == stageCompare.Value;
				break;
			}
			break;
		}
		}
		if (flag)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
