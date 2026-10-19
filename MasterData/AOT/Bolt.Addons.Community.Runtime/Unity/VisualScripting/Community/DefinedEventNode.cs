using System;
using System.Collections.Generic;
using System.Reflection;
using Unity.VisualScripting.Community.Utility;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.DefinedEvents.Units.DefinedEventUnit")]
[UnitTitle("Defined Event")]
[UnitCategory("Events/Community")]
[RenamedFrom("Bolt.Addons.Community.DefinedEvents.Units.DefinedEvent")]
public class DefinedEventNode : GameObjectEventUnit<DefinedEventArgs>, IDefinedEventNode
{
	private const string EventName = "OnDefinedEvent";

	[SerializeAs("eventType")]
	private Type _eventType;

	[SerializeAs("NeweventType")]
	private IDefinedEventType New_eventType;

	[DoNotSerialize]
	private ReflectedInfo Info;

	[DoNotSerialize]
	public Type eventType
	{
		get
		{
			return _eventType;
		}
		set
		{
			_eventType = value;
		}
	}

	[DoNotSerialize]
	public Type restrictedEventType
	{
		get
		{
			return _eventType;
		}
		set
		{
			_eventType = value;
		}
	}

	[DoNotSerialize]
	public IDefinedEventType NeweventType
	{
		get
		{
			return New_eventType;
		}
		set
		{
			New_eventType = value;
		}
	}

	[InspectableIf("IsRestricted")]
	[UnitHeaderInspectable]
	[DoNotSerialize]
	public IDefinedEventType NewrestrictedEventType
	{
		get
		{
			return New_eventType;
		}
		set
		{
			New_eventType = value;
		}
	}

	public bool IsRestricted => CommunityOptionFetcher.DefinedEvent_RestrictEventTypes;

	public bool IsNotRestricted => !IsRestricted;

	[DoNotSerialize]
	public List<ValueOutput> outputPorts { get; } = new List<ValueOutput>();

	public override Type MessageListenerType => null;

	protected override string hookName => "OnDefinedEvent";

	protected override bool ShouldTrigger(Flow flow, DefinedEventArgs args)
	{
		return args.eventData.GetType() == NeweventType.type;
	}

	protected override void Definition()
	{
		base.Definition();
		if (restrictedEventType != null)
		{
			NewrestrictedEventType = new IDefinedEventType(restrictedEventType);
			restrictedEventType = null;
		}
		if (NewrestrictedEventType == null)
		{
			NewrestrictedEventType = new IDefinedEventType();
		}
		BuildFromInfo();
	}

	private void BuildFromInfo()
	{
		outputPorts.Clear();
		if (NeweventType.type == null)
		{
			return;
		}
		Info = ReflectedInfo.For(NeweventType.type);
		foreach (KeyValuePair<string, FieldInfo> reflectedField in Info.reflectedFields)
		{
			outputPorts.Add(ValueOutput(reflectedField.Value.FieldType, reflectedField.Value.Name));
		}
		foreach (KeyValuePair<string, PropertyInfo> reflectedProperty in Info.reflectedProperties)
		{
			outputPorts.Add(ValueOutput(reflectedProperty.Value.PropertyType, reflectedProperty.Value.Name));
		}
	}

	protected override void AssignArguments(Flow flow, DefinedEventArgs args)
	{
		for (int i = 0; i < outputPorts.Count; i++)
		{
			ValueOutput valueOutput = outputPorts[i];
			string key = valueOutput.key;
			if (Info.reflectedFields.ContainsKey(key))
			{
				FieldInfo fieldInfo = Info.reflectedFields[key];
				flow.SetValue(valueOutput, fieldInfo.GetValue(args.eventData));
			}
			else if (Info.reflectedProperties.ContainsKey(key))
			{
				PropertyInfo propertyInfo = Info.reflectedProperties[key];
				flow.SetValue(valueOutput, propertyInfo.GetValue(args.eventData));
			}
		}
	}

	public override EventHook GetHook(GraphReference reference)
	{
		return ConstructHook(reference.GetElementData<Data>(this).target, _eventType);
	}

	private static EventHook ConstructHook(GameObject target, Type eventType)
	{
		return (!DefinedEventSupport.IsOptimized()) ? new EventHook("OnDefinedEvent", target) : new EventHook("OnDefinedEvent", target, eventType.GetTypeInfo().FullName);
	}

	public static void Trigger(GameObject target, object eventData)
	{
		EventBus.Trigger(ConstructHook(target, eventData.GetType()), new DefinedEventArgs(eventData));
	}

	public static IDisposable RegisterListener<T>(GameObject target, Action<T> onEvent)
	{
		EventHook eventHook = ConstructHook(target, typeof(T));
		Action<DefinedEventArgs> action = (DefinedEventArgs x) =>
		{
			if (x.eventData.GetType() == typeof(T))
			{
				onEvent((T)x.eventData);
			}
		};
		EventBus.Register(eventHook, action);
		return Disposable.Create(() =>
		{
			EventBus.Unregister(eventHook, action);
		});
	}
}
