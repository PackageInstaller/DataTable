using System;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Time")]
[UnitOrder(7)]
public sealed class Timer : Unit, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable, IGraphEventListener
{
	public sealed class Data : IGraphElementData
	{
		public float elapsed;

		public float duration;

		public bool active;

		public bool paused;

		public bool unscaled;

		public Delegate update;

		public bool isListening;
	}

	[DoNotSerialize]
	public ControlInput start { get; private set; }

	[DoNotSerialize]
	public ControlInput pause { get; private set; }

	[DoNotSerialize]
	public ControlInput resume { get; private set; }

	[DoNotSerialize]
	public ControlInput toggle { get; private set; }

	[DoNotSerialize]
	public ValueInput duration { get; private set; }

	[PortLabel("Unscaled")]
	[DoNotSerialize]
	public ValueInput unscaledTime { get; private set; }

	[DoNotSerialize]
	public ControlOutput started { get; private set; }

	[DoNotSerialize]
	public ControlOutput tick { get; private set; }

	[DoNotSerialize]
	public ControlOutput completed { get; private set; }

	[PortLabel("Elapsed")]
	[DoNotSerialize]
	public ValueOutput elapsedSeconds { get; private set; }

	[DoNotSerialize]
	[PortLabel("Elapsed %")]
	public ValueOutput elapsedRatio { get; private set; }

	[PortLabel("Remaining")]
	[DoNotSerialize]
	public ValueOutput remainingSeconds { get; private set; }

	[PortLabel("Remaining %")]
	[DoNotSerialize]
	public ValueOutput remainingRatio { get; private set; }

	protected override void Definition()
	{
		isControlRoot = true;
		start = ControlInput("start", Start);
		pause = ControlInput("pause", Pause);
		resume = ControlInput("resume", Resume);
		toggle = ControlInput("toggle", Toggle);
		duration = ValueInput("duration", 1f);
		unscaledTime = ValueInput("unscaledTime", @default: false);
		started = ControlOutput("started");
		tick = ControlOutput("tick");
		completed = ControlOutput("completed");
		elapsedSeconds = ValueOutput<float>("elapsedSeconds");
		elapsedRatio = ValueOutput<float>("elapsedRatio");
		remainingSeconds = ValueOutput<float>("remainingSeconds");
		remainingRatio = ValueOutput<float>("remainingRatio");
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

	private ControlOutput Start(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		elementData.elapsed = 0f;
		elementData.duration = flow.GetValue<float>(duration);
		elementData.active = true;
		elementData.paused = false;
		elementData.unscaled = flow.GetValue<bool>(unscaledTime);
		AssignMetrics(flow, elementData);
		return started;
	}

	private ControlOutput Pause(Flow flow)
	{
		flow.stack.GetElementData<Data>(this).paused = true;
		return null;
	}

	private ControlOutput Resume(Flow flow)
	{
		flow.stack.GetElementData<Data>(this).paused = false;
		return null;
	}

	private ControlOutput Toggle(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (!elementData.active)
		{
			return Start(flow);
		}
		elementData.paused = !elementData.paused;
		return null;
	}

	private void AssignMetrics(Flow flow, Data data)
	{
		flow.SetValue(elapsedSeconds, data.elapsed);
		flow.SetValue(elapsedRatio, Mathf.Clamp01(data.elapsed / data.duration));
		flow.SetValue(remainingSeconds, Mathf.Max(0f, data.duration - data.elapsed));
		flow.SetValue(remainingRatio, Mathf.Clamp01((data.duration - data.elapsed) / data.duration));
	}

	public void Update(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (elementData.active && !elementData.paused)
		{
			elementData.elapsed += (elementData.unscaled ? Time.unscaledDeltaTime : Time.deltaTime);
			elementData.elapsed = Mathf.Min(elementData.elapsed, elementData.duration);
			AssignMetrics(flow, elementData);
			GraphStack stack = flow.PreserveStack();
			flow.Invoke(tick);
			if (elementData.elapsed >= elementData.duration)
			{
				elementData.active = false;
				flow.RestoreStack(stack);
				flow.Invoke(completed);
			}
			flow.DisposePreservedStack(stack);
		}
	}
}
