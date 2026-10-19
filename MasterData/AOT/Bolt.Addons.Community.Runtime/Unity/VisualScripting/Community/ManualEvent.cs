using System;
using Unity.VisualScripting.Community.Utility;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitCategory("Events/Community/Editor")]
[UnitShortTitle("Manual Event")]
[UnitTitle("Manual Event")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.FlowEvents.ManualEvent")]
public class ManualEvent : MachineEventUnit<EmptyEventArgs>, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public new class Data : EventUnit<EmptyEventArgs>.Data
	{
		public int LastObservedUpdateTicker;
	}

	[DoNotSerialize]
	[UnitHeaderInspectable]
	[NodeButton("TriggerButton")]
	public NodeButton triggerButton;

	[DoNotSerialize]
	public int shouldTriggerNextUpdateTicker;

	protected override string hookName => "Update";

	public override IGraphElementData CreateData()
	{
		return new Data();
	}

	public void TriggerButton(GraphReference reference)
	{
		bool flag = true;
		if (Application.isEditor && Application.isPlaying)
		{
			flag = !coroutine && EditorState.IsEditorPaused();
		}
		if (flag)
		{
			if (coroutine)
			{
				Debug.LogWarning("This manual event is marked as a coroutine, but Unity coroutines are only valid during Play mode.  Attempting non-coroutine activation!");
			}
			Flow.New(reference).Run(trigger);
		}
		else
		{
			shouldTriggerNextUpdateTicker++;
		}
	}

	protected override bool ShouldTrigger(Flow flow, EmptyEventArgs args)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (!elementData.isListening)
		{
			return false;
		}
		if (shouldTriggerNextUpdateTicker > elementData.LastObservedUpdateTicker)
		{
			elementData.LastObservedUpdateTicker = shouldTriggerNextUpdateTicker;
			return true;
		}
		return false;
	}
}
