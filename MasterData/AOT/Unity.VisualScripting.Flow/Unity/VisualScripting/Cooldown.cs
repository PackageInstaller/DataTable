using System;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Time")]
[TypeIcon(typeof(Timer))]
[UnitOrder(8)]
public sealed class Cooldown : Unit, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable, IGraphEventListener
{
	public sealed class Data : IGraphElementData
	{
		public float remaining;

		public float duration;

		public bool unscaled;

		public Delegate update;

		public bool isListening;

		public bool isReady => remaining <= 0f;
	}

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ControlInput reset { get; private set; }

	[DoNotSerialize]
	public ValueInput duration { get; private set; }

	[DoNotSerialize]
	[PortLabel("Unscaled")]
	public ValueInput unscaledTime { get; private set; }

	[PortLabel("Ready")]
	[DoNotSerialize]
	public ControlOutput exitReady { get; private set; }

	[PortLabel("Not Ready")]
	[DoNotSerialize]
	public ControlOutput exitNotReady { get; private set; }

	[DoNotSerialize]
	public ControlOutput tick { get; private set; }

	[DoNotSerialize]
	[PortLabel("Completed")]
	public ControlOutput becameReady { get; private set; }

	[PortLabel("Remaining")]
	[DoNotSerialize]
	public ValueOutput remainingSeconds { get; private set; }

	[DoNotSerialize]
	[PortLabel("Remaining %")]
	public ValueOutput remainingRatio { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		reset = ControlInput("reset", Reset);
		duration = ValueInput("duration", 1f);
		unscaledTime = ValueInput("unscaledTime", @default: false);
		exitReady = ControlOutput("exitReady");
		exitNotReady = ControlOutput("exitNotReady");
		tick = ControlOutput("tick");
		becameReady = ControlOutput("becameReady");
		remainingSeconds = ValueOutput<float>("remainingSeconds");
		remainingRatio = ValueOutput<float>("remainingRatio");
		Requirement(duration, enter);
		Requirement(unscaledTime, enter);
		Succession(enter, exitReady);
		Succession(enter, exitNotReady);
		Succession(enter, tick);
		Succession(enter, becameReady);
		Assignment(enter, remainingSeconds);
		Assignment(enter, remainingRatio);
	}

	public IGraphElementData CreateData()
	{
		return new Data();
	}

	public void StartListening(GraphStack stack)
	{
		Data elementData = stack.GetElementData<Data>(this);
		if (!elementData.isListening)
		{
			GraphReference reference = stack.ToReference();
			EventHook hook = new EventHook("Update", stack.machine);
			Action<EmptyEventArgs> action = (EmptyEventArgs args) =>
			{
				TriggerUpdate(reference);
			};
			EventBus.Register(hook, action);
			elementData.update = action;
			elementData.isListening = true;
		}
	}

	public void StopListening(GraphStack stack)
	{
		Data elementData = stack.GetElementData<Data>(this);
		if (elementData.isListening)
		{
			EventBus.Unregister(new EventHook("Update", stack.machine), elementData.update);
			stack.ClearReference();
			elementData.update = null;
			elementData.isListening = false;
		}
	}

	public bool IsListening(GraphPointer pointer)
	{
		return pointer.GetElementData<Data>(this).isListening;
	}

	private void TriggerUpdate(GraphReference reference)
	{
		using Flow flow = Flow.New(reference);
		Update(flow);
	}

	private ControlOutput Enter(Flow flow)
	{
		if (flow.stack.GetElementData<Data>(this).isReady)
		{
			return Reset(flow);
		}
		return exitNotReady;
	}

	private ControlOutput Reset(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		elementData.duration = flow.GetValue<float>(duration);
		elementData.remaining = elementData.duration;
		elementData.unscaled = flow.GetValue<bool>(unscaledTime);
		return exitReady;
	}

	private void AssignMetrics(Flow flow, Data data)
	{
		flow.SetValue(remainingSeconds, data.remaining);
		flow.SetValue(remainingRatio, Mathf.Clamp01(data.remaining / data.duration));
	}

	public void Update(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (!elementData.isReady)
		{
			elementData.remaining -= (elementData.unscaled ? Time.unscaledDeltaTime : Time.deltaTime);
			elementData.remaining = Mathf.Max(0f, elementData.remaining);
			AssignMetrics(flow, elementData);
			GraphStack stack = flow.PreserveStack();
			flow.Invoke(tick);
			if (elementData.isReady)
			{
				flow.RestoreStack(stack);
				flow.Invoke(becameReady);
			}
			flow.DisposePreservedStack(stack);
		}
	}
}
