using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Iterators")]
[Description("等于last不会执行，只会走到last - 1")]
[ContextDefinedInputs(new Type[] { typeof(int) })]
[ContextDefinedOutputs(new Type[] { typeof(int) })]
public class ForLoop : FlowControlNode
{
	private int current;

	private bool broken;

	private ValueInput<int> first;

	private ValueInput<int> last;

	private ValueInput<int> step;

	protected override void RegisterPorts()
	{
		first = AddValueInput<int>("First");
		last = AddValueInput<int>("Last", "Loops");
		step = AddValueInput<int>("Step").SetDefaultAndSerializedValue(1);
		AddValueOutput("Index", () => current);
		FlowOutput fCurrent = AddFlowOutput("Do");
		FlowOutput fFinish = AddFlowOutput("Done");
		AddFlowInput("In", delegate(Flow f)
		{
			current = 0;
			broken = false;
			f.breakCall = delegate
			{
				broken = true;
			};
			int num = Mathf.Max(step.value, 1);
			for (int num2 = first.value; num2 < last.value; num2 += num)
			{
				if (broken)
				{
					break;
				}
				current = num2;
				fCurrent.Call(f);
			}
			f.breakCall = null;
			fFinish.Call(f);
		});
		AddFlowInput("Break", delegate
		{
			broken = true;
		});
	}
}
