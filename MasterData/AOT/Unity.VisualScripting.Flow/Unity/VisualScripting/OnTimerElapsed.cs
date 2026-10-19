using System;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Time")]
[Obsolete("Use Wait For Seconds or Timer instead.")]
public sealed class OnTimerElapsed : MachineEventUnit<EmptyEventArgs>
{
	public new class Data : EventUnit<EmptyEventArgs>.Data
	{
		public float time;

		public bool triggered;
	}

	protected override string hookName => "Update";

	[PortLabel("Delay")]
	[DoNotSerialize]
	public ValueInput seconds { get; private set; }

	[DoNotSerialize]
	[PortLabel("Unscaled")]
	public ValueInput unscaledTime { get; private set; }

	public override IGraphElementData CreateData()
	{
		return new Data();
	}

	protected override void Definition()
	{
		base.Definition();
		seconds = ValueInput("seconds", 0f);
		unscaledTime = ValueInput("unscaledTime", @default: false);
	}

	public override void StartListening(GraphStack stack)
	{
		base.StartListening(stack);
		Data elementData = stack.GetElementData<Data>(this);
		elementData.triggered = false;
		elementData.time = 0f;
	}

	protected override bool ShouldTrigger(Flow flow, EmptyEventArgs args)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (elementData.triggered)
		{
			return false;
		}
		float num = (flow.GetValue<bool>(unscaledTime) ? Time.unscaledDeltaTime : Time.deltaTime);
		float value = flow.GetValue<float>(seconds);
		elementData.time += num;
		if (elementData.time >= value)
		{
			elementData.triggered = true;
			return true;
		}
		return false;
	}
}
