using System;
using System.Collections;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Filters")]
[Description("Filters the flow exeuction so that it can't be called very frequently")]
[ContextDefinedInputs(new Type[] { typeof(float) })]
[ContextDefinedOutputs(new Type[] { typeof(float) })]
public class Cooldown : FlowControlNode
{
	private Coroutine coroutine;

	private float remaining;

	private float remainingNormalized;

	private FlowOutput start;

	private FlowOutput finish;

	private FlowOutput update;

	private ValueInput<float> time;

	public override string name => base.name + string.Format(" [{0}]", remaining.ToString("0.0"));

	public override void OnGraphStarted()
	{
		remaining = 0f;
		remainingNormalized = 0f;
		coroutine = null;
	}

	public override void OnGraphStoped()
	{
		if (coroutine != null)
		{
			StopCoroutine(coroutine);
			coroutine = null;
			remaining = 0f;
			remainingNormalized = 0f;
		}
	}

	protected override void RegisterPorts()
	{
		start = AddFlowOutput("Start", "Out");
		update = AddFlowOutput("Update");
		finish = AddFlowOutput("Finish", "Ready");
		time = AddValueInput<float>("Time").SetDefaultAndSerializedValue(1f);
		AddValueOutput("Time Left", "Current", () => Mathf.Max(remaining, 0f));
		AddValueOutput("Normalized", () => Mathf.Clamp01(remainingNormalized));
		AddFlowInput("In", Begin);
		AddFlowInput("Cancel", Cancel);
	}

	private void Begin(Flow f)
	{
		if (remaining <= 0f && coroutine == null)
		{
			coroutine = StartCoroutine(CountDown(f));
		}
	}

	private void Cancel(Flow f)
	{
		if (coroutine != null)
		{
			StopCoroutine(coroutine);
			coroutine = null;
			remaining = 0f;
			remainingNormalized = 0f;
		}
	}

	private IEnumerator CountDown(Flow f)
	{
		float total = (remaining = time.value);
		start.Call(f);
		while (remaining > 0f)
		{
			while (base.graph.isPaused)
			{
				yield return null;
			}
			remaining -= Time.deltaTime;
			remainingNormalized = remaining / total;
			update.Call(f);
			yield return null;
		}
		coroutine = null;
		finish.Call(f);
	}
}
