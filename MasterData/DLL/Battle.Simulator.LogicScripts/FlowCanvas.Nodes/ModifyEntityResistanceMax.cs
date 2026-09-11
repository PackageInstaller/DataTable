using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改控制抗性点上限数量", 0)]
[Category("Logic/Attribute")]
[Description("修改控制抗性点上限数量")]
public class ModifyEntityResistanceMax : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> valueInput = AddValueInput<int>("目标值");
		ValueInput<int> reasonInput = AddValueInput<int>("开始原因", "原因");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOutput = AddFlowOutput("error");
		FlowOutput reStateOutput = AddFlowOutput("抗性状态中", "reState");
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
			else if (entityWithEntityID.entityResistance.reState)
			{
				reStateOutput.Call(f);
			}
			else
			{
				entityWithEntityID.entityResistance.enterReason = reasonInput.value;
				entityWithEntityID.entityResistance.maxValue = valueInput.value;
				output.Call(f);
			}
		});
	}
}
