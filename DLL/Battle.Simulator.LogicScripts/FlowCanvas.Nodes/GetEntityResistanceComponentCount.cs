using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取当前控制抗性点数", 0)]
[Category("Logic/Attribute")]
[Description("获取当前控制抗性点数")]
public class GetEntityResistanceComponentCount : FlowNode
{
	private int count;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddValueOutput("控制抗性点数", "Count", () => count);
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			count = 0;
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
				count = entityWithEntityID.entityResistance.curValue;
				output.Call(f);
			}
		});
	}
}
