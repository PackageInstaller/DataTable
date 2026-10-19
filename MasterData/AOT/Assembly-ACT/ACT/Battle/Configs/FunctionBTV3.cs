using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取行为树向量3", "Function", new string[] { "btv3", "value", "float", "int" })]
public class FunctionBTV3 : ConfigFunction<Vector3>
{
	[Tooltip("BT中 SharedV3的变量名")]
	public string key;

	[Tooltip("如果没有获取到 变量名执行一个搜索的逻辑")]
	public ConfigFunction<Vector3> fallback;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		ActBehaviorTree actBehaviorTree = memory.owner.GetCompAI().ActBehaviorTree;
		if ((object)actBehaviorTree != null)
		{
			SharedVariable variable = actBehaviorTree.GetVariable(key);
			if (variable == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("key[" + key + "] not found");
				}
				return fallback.Return(memory);
			}
			return (variable as SharedVector3).Value;
		}
		return fallback.Return(memory);
	}
}
