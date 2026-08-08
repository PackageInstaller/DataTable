using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("拷贝技能可用性(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("拷贝技能可用性")]
public class CopySkillEnable : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<List<int>> oldabilityList = AddValueInput<List<int>>("旧的技能列表");
		ValueInput<List<int>> newabilityList = AddValueInput<List<int>>("新的技能列表");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				Debug.LogError("拷贝技能可用性, 实体为空");
			}
			else
			{
				List<int> value = oldabilityList.value;
				List<int> value2 = newabilityList.value;
				if (value == null || value2 == null || value.Count > value2.Count)
				{
					Debug.LogError("拷贝技能可用性, list参数有问题");
				}
				else
				{
					for (int i = 0; i < value.Count; i++)
					{
						int value3 = 0;
						entityWithEntityID.entityBlackboard.var.mAbilityEnable.TryGetValue(value[i], out value3);
						entityWithEntityID.entityBlackboard.var.mAbilityEnable[value2[i]] = value3;
					}
					output.Call(f);
				}
			}
		});
	}
}
