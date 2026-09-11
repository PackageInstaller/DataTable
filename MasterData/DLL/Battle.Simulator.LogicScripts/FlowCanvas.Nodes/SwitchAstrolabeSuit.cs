using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历星盘(套装ID)", 0)]
[Category("Logic/星盘")]
[Description("")]
[ContextDefinedInputs(new Type[] { typeof(int) })]
[HasRefreshButton]
public class SwitchAstrolabeSuit : FlowControlNode
{
	[Name("星盘ID", 0)]
	public List<int> comparisonOutputs = new List<int>();

	private string portID = string.Empty;

	private bool[] enableArr;

	private bool suitEableState;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("EntityID", "entityIDVar");
		FlowOutput[] cases = new FlowOutput[comparisonOutputs.Count];
		for (int i = 0; i < comparisonOutputs.Count; i++)
		{
			portID = $"{comparisonOutputs[i]}";
			cases[i] = AddFlowOutput(portID, portID);
		}
		FlowOutput defaultCase = AddFlowOutput("Default");
		enableArr = new bool[comparisonOutputs.Count];
		AddFlowInput("In", delegate(Flow f)
		{
			int value = entityIDVar.GetValue();
			int varName = 2023;
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(value);
			for (int j = 0; j < 27; j++)
			{
				AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, varName, out var baseValue, out var _, out var _);
				if (baseValue == 0L)
				{
					break;
				}
				for (int k = 0; k < comparisonOutputs.Count; k++)
				{
					if (comparisonOutputs[k] == baseValue)
					{
						enableArr[k] = true;
						break;
					}
				}
			}
			for (int l = 0; l < comparisonOutputs.Count; l++)
			{
				suitEableState = enableArr[l];
				cases[l].Call(f);
			}
			defaultCase.Call(f);
		});
		AddValueOutput("激活状态", "suitEableState", () => suitEableState);
	}
}
