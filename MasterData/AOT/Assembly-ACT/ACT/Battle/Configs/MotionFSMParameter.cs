using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取动作状态机参数", "Function", new string[] { "motion", "fsm", "parameter", "state", "status", "tag" })]
public class MotionFSMParameter : ConfigFunction<float>
{
	public string parameter;

	public ConfigAnimParameterType type = ConfigAnimParameterType.Int;

	protected override float Evaluate(ActionMemory memory)
	{
		if (type == ConfigAnimParameterType.Float)
		{
			return memory.target.entity.GetMotionFloat(parameter);
		}
		if (type == ConfigAnimParameterType.Int)
		{
			return memory.target.entity.GetMotionInt(parameter);
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"{memory.target.entity}的{memory.ability}的MotionFSMParameter 用到了type为Float和Int之外的类型，检查下");
		}
		return 0f;
	}
}
