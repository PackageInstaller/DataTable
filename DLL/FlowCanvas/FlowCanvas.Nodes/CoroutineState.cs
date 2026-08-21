using System.Collections;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Coroutine", 0)]
[Category("Flow Controllers/Iterators")]
[Description("Start a Coroutine that will repeat until Break is signaled")]
public class CoroutineState : FlowControlNode
{
	private bool active;

	private Coroutine coroutine;

	public override void OnGraphStoped()
	{
		if (coroutine != null)
		{
			StopCoroutine(coroutine);
			active = false;
		}
	}

	protected override void RegisterPorts()
	{
		FlowOutput fStart = AddFlowOutput("Start");
		FlowOutput fUpdate = AddFlowOutput("Update");
		FlowOutput fFinish = AddFlowOutput("Finish");
		AddFlowInput("Start", delegate(Flow f)
		{
			if (!active)
			{
				active = true;
				coroutine = StartCoroutine(DoRepeat(fStart, fUpdate, fFinish, f));
			}
		});
		AddFlowInput("Break", delegate
		{
			active = false;
		});
	}

	private IEnumerator DoRepeat(FlowOutput fStart, FlowOutput fUpdate, FlowOutput fFinish, Flow f)
	{
		f.breakCall = delegate
		{
			active = false;
		};
		fStart.Call(f);
		while (active)
		{
			while (base.graph.isPaused)
			{
				yield return null;
			}
			fUpdate.Call(f);
			yield return null;
		}
		f.breakCall = null;
		fFinish.Call(f);
	}
}
