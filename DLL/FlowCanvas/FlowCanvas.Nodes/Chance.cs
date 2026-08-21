using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Filters")]
[Description("Filter the Flow based on a percentage between min and max.\nFor example: With Min = 0, Max = 1 and Percentage = 0.5, the chance is 50%.")]
[ContextDefinedInputs(new Type[] { typeof(float) })]
public class Chance : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput success = AddFlowOutput("Success", "Out");
		FlowOutput failure = AddFlowOutput("Failure");
		ValueInput<float> chance = AddValueInput<float>("Percentage");
		ValueInput<float> min = AddValueInput<float>("Min");
		ValueInput<float> max = AddValueInput<float>("Max").SetDefaultAndSerializedValue(1f);
		AddFlowInput("In", delegate(Flow f)
		{
			f.Call((UnityEngine.Random.Range(min.value, max.value) <= chance.value) ? success : failure);
		});
	}
}
