using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到当前控制抗性属性", 0)]
[Category("Logic/Attribute")]
[Description("得到当前控制抗性属性")]
public class GetCurEntityResistanceEle : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int element = 0;
		AddValueOutput("属性", () => element);
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOutput = AddFlowOutput("error");
		FlowOutput stateOutput = AddFlowOutput("非抗性状态中");
		AddFlowInput("", delegate(Flow f)
		{
			element = 0;
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
			else if (!entityWithEntityID.entityResistance.reState)
			{
				stateOutput.Call(f);
			}
			else
			{
				element = entityWithEntityID.entityResistance.reStateEle;
				output.Call(f);
			}
		});
	}
}
