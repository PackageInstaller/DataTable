using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Logic.Units.OnEveryXSeconds")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.OnEveryXSeconds")]
[UnitCategory("Events/Community/Time")]
public sealed class OnEveryXSeconds : MachineEventUnit<EmptyEventArgs>
{
	public new class Data : EventUnit<EmptyEventArgs>.Data
	{
		public float time;
	}

	protected override string hookName => "Update";

	[DoNotSerialize]
	[PortLabel("Delay")]
	public ValueInput seconds { get; private set; }

	[PortLabel("Unscaled")]
	[DoNotSerialize]
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
		stack.GetElementData<Data>(this);
	}

	protected override bool ShouldTrigger(Flow flow, EmptyEventArgs args)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (!elementData.isListening)
		{
			return false;
		}
		float num = (flow.GetValue<bool>(unscaledTime) ? Time.unscaledDeltaTime : Time.deltaTime);
		float value = flow.GetValue<float>(seconds);
		elementData.time += num;
		if (elementData.time >= value)
		{
			elementData.time = 0f;
			return true;
		}
		return false;
	}
}
