using System;
using System.ComponentModel;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Description("一个降序循环(Z,A]")]
[Category("Flow Controllers/Iterators")]
[ContextDefinedInputs(new Type[] { typeof(int) })]
[ContextDefinedOutputs(new Type[] { typeof(int) })]
public class ForLoopDesc : FlowControlNode
{
	protected override void RegisterPorts()
	{
		int current = 0;
		ValueInput<int> first = AddValueInput<int>("第一个值(不包含)");
		ValueInput<int> last = AddValueInput<int>("最后一个值(包含)", "Loops");
		ValueInput<int> step = AddValueInput<int>("步长(负数有效)").SetDefaultAndSerializedValue(-1);
		AddValueOutput("Index", () => current);
		FlowOutput fCurrent = AddFlowOutput("Do");
		FlowOutput fFinish = AddFlowOutput("Done");
		bool broken;
		AddFlowInput("In", delegate(Flow f)
		{
			current = first.value - 1;
			broken = false;
			int num = Mathf.Min(step.value, -1);
			for (int i = first.value - 1; i >= last.value; i += num)
			{
				if (broken)
				{
					break;
				}
				current = i;
				fCurrent.Call(f);
			}
			fFinish.Call(f);
		});
		AddFlowInput("Break", delegate
		{
			broken = true;
		});
	}
}
