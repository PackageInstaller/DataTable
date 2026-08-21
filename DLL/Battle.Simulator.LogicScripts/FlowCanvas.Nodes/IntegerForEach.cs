using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("整型迭代器", 0)]
[Description("Enumerate a value (usualy a list or array) for each of it's elements")]
[Category("Common/Control")]
public class IntegerForEach : FlowControlNode
{
	private int currentObject;

	private int currentIndex;

	private bool broken;

	protected override void RegisterPorts()
	{
		ValueInput<List<int>> list = AddValueInput<List<int>>("Value");
		AddValueOutput("Current", () => currentObject);
		AddValueOutput("Index", () => currentIndex);
		FlowOutput fCurrent = AddFlowOutput("Do");
		FlowOutput fFinish = AddFlowOutput("Done");
		AddFlowInput("In", delegate(Flow f)
		{
			currentIndex = -1;
			List<int> value = list.value;
			if (value == null)
			{
				fFinish.Call(f);
			}
			else
			{
				broken = false;
				for (int i = 0; i < value.Count; i++)
				{
					if (broken)
					{
						break;
					}
					currentObject = value[i];
					currentIndex++;
					fCurrent.Call(f);
				}
				fFinish.Call(f);
			}
		});
		AddFlowInput("Break", delegate
		{
			broken = true;
		});
	}
}
