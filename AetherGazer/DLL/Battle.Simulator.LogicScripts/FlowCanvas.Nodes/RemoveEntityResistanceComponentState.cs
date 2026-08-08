using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("移除控制抗性状态", 0)]
[Category("Logic/Attribute")]
[Description("移除控制抗性状态, 修改控制抗性组件, 如果没有抗性组件, 也不会报错")]
public class RemoveEntityResistanceComponentState : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> reasonInput = AddValueInput<int>("结束原因", "原因");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("清除获得的抗性点数, 实体为空");
			}
			else
			{
				if (entityWithEntityID.hasEntityResistance && entityWithEntityID.entityResistance.reState)
				{
					entityWithEntityID.entityResistance.curTime = entityWithEntityID.entityResistance.maxTime;
					entityWithEntityID.entityResistance.exitReason = reasonInput.value;
				}
				f.Call(output);
			}
		});
	}
}
