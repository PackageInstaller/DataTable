using System;
using Unity.VisualScripting;
using UnityEngine;

namespace Bolt.Addons.Community.Fundamentals;

[TypeIcon(typeof(CustomEvent))]
[UnitTitle("TriggerChannelEvent")]
[UnitCategory("Events\\Community")]
public class TriggerChannelEvent : Unit
{
	[DoNotSerialize]
	public ValueInput channel;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput InputTrigger { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput OutputTrigger { get; private set; }

	protected override void Definition()
	{
		InputTrigger = ControlInput("InputTrigger", Trigger);
		channel = ValueInput("channel", Channel.Channel1);
		OutputTrigger = ControlOutput("OutputTrigger");
		Succession(InputTrigger, OutputTrigger);
	}

	private ControlOutput Trigger(Flow flow)
	{
		try
		{
			Channel value = flow.GetValue<Channel>(channel);
			switch (value)
			{
			case Channel.Channel1:
				EventBus.Trigger(CommunityEvents.ChannelEvent1);
				break;
			case Channel.Channel2:
				EventBus.Trigger(CommunityEvents.ChannelEvent2);
				break;
			case Channel.Channel3:
				EventBus.Trigger(CommunityEvents.ChannelEvent3);
				break;
			case Channel.Channel4:
				EventBus.Trigger(CommunityEvents.ChannelEvent4);
				break;
			case Channel.Channel5:
				EventBus.Trigger(CommunityEvents.ChannelEvent5);
				break;
			case Channel.Channel6:
				EventBus.Trigger(CommunityEvents.ChannelEvent6);
				break;
			case Channel.Channel7:
				EventBus.Trigger(CommunityEvents.ChannelEvent7);
				break;
			case Channel.Channel8:
				EventBus.Trigger(CommunityEvents.ChannelEvent8);
				break;
			case Channel.Channel9:
				EventBus.Trigger(CommunityEvents.ChannelEvent9);
				break;
			case Channel.Channel10:
				EventBus.Trigger(CommunityEvents.ChannelEvent10);
				break;
			default:
				Debug.LogWarning("Unknown channel value: " + value);
				break;
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		return OutputTrigger;
	}
}
