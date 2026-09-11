using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("迭代器", 0)]
[Description("Enumerate a value (usualy a list or array) for each of it's elements")]
[Category("Common/Control")]
[ContextDefinedInputs(new Type[] { typeof(IEnumerable<>) })]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
public class ForEachWithoutBroken<T> : FlowControlNode
{
	private T currentObject;

	private int currentIndex;

	private bool broken;

	protected override void RegisterPorts()
	{
		ValueInput<IEnumerable<T>> list = AddValueInput<IEnumerable<T>>("Value");
		AddValueOutput("Current", () => currentObject);
		AddValueOutput("Index", () => currentIndex);
		FlowOutput fCurrent = AddFlowOutput("Do");
		FlowOutput fFinish = AddFlowOutput("Done");
		AddFlowInput("In", delegate(Flow f)
		{
			currentIndex = -1;
			IEnumerable<T> value = list.value;
			if (value == null)
			{
				fFinish.Call(f);
			}
			else
			{
				broken = false;
				foreach (T item in value)
				{
					if (broken)
					{
						break;
					}
					currentObject = item;
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
