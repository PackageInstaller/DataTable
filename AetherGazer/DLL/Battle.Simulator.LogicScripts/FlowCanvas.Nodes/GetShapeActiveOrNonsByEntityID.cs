using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体碰撞盒开关状态", 0)]
[Category("Logic/Attribute")]
[Description("根据实体ID获取碰撞盒开关状态(103类buff或Timeline对碰撞盒的开关)")]
public class GetShapeActiveOrNonsByEntityID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput TrueOutput = AddFlowOutput("True");
		FlowOutput FalseOutput = AddFlowOutput("False");
		FlowOutput ErrorOutput = AddFlowOutput("Error");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityIDInput.value);
			if (simEntityByMultiColliders == null || !simEntityByMultiColliders.hasEntityShape)
			{
				ErrorOutput.Call(f);
			}
			else
			{
				List<EntityShape> list = new List<EntityShape>();
				SimShapeProcessor.GetAllShape(simEntityByMultiColliders, list);
				if (list.Count != 0)
				{
					TrueOutput.Call(f);
				}
				else
				{
					FalseOutput.Call(f);
				}
			}
		});
	}
}
