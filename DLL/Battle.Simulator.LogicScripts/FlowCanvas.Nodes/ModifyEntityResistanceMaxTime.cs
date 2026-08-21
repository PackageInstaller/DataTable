using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改控制抗性时长上限", 0)]
[Category("Logic/Attribute")]
[Description("修改控制抗性时长上限")]
public class ModifyEntityResistanceMaxTime : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> valueInput = AddValueInput<int>("目标值(毫秒)", "目标值");
		ValueInput<int> reasonInput = AddValueInput<int>("结束原因", "原因");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("实体为空");
				errorOutput.Call(f);
			}
			else if (!entityWithEntityID.hasEntityResistance)
			{
				errorOutput.Call(f);
			}
			else
			{
				entityWithEntityID.entityResistance.maxTime = (uint)valueInput.value;
				entityWithEntityID.entityResistance.exitReason = reasonInput.value;
				output.Call(f);
			}
		});
	}
}
