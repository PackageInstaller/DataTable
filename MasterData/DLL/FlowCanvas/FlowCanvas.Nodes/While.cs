using System;
using System.Collections;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("While True", 0)]
[Category("Flow Controllers/Iterators")]
[Description("Once called, will continuously call 'Do' while the input boolean condition is true. Once condition becomes or is false, 'Done' is called")]
[ContextDefinedInputs(new Type[] { typeof(bool) })]
public class While : FlowControlNode
{
	private Coroutine coroutine;

	public override void OnGraphStarted()
	{
		coroutine = null;
	}

	public override void OnGraphStoped()
	{
		if (coroutine != null)
		{
			StopCoroutine(coroutine);
			coroutine = null;
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<bool> c = AddValueInput<bool>("Condition");
		FlowOutput fUpdate = AddFlowOutput("Do");
		FlowOutput fFinish = AddFlowOutput("Done");
		AddFlowInput("In", delegate(Flow f)
		{
			if (coroutine == null)
			{
				coroutine = StartCoroutine(DoWhile(fUpdate, fFinish, f, c));
			}
		});
	}

	private IEnumerator DoWhile(FlowOutput fUpdate, FlowOutput fFinish, Flow f, ValueInput<bool> condition)
	{
		bool active = true;
		f.breakCall = delegate
		{
			active = false;
		};
		while (active && condition.value)
		{
			while (base.graph.isPaused)
			{
				yield return null;
			}
			fUpdate.Call(f);
			yield return null;
		}
		coroutine = null;
		f.breakCall = null;
		fFinish.Call(f);
	}
}
