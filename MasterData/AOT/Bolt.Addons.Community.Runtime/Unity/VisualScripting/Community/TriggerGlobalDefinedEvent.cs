using System;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitCategory("Events/Community")]
[UnitTitle("Trigger Global Defined Event")]
[TypeIcon(typeof(BoltUnityEvent))]
[RenamedFrom("Bolt.Addons.Community.DefinedEvents.Units.TriggerGlobalDefinedEvent")]
public class TriggerGlobalDefinedEvent : Unit
{
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
	public List<ValueInput> inputPorts { get; } = new List<ValueInput>();

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		if (restrictedEventType != null)
		{
			NewrestrictedEventType = new IDefinedEventType(restrictedEventType);
			restrictedEventType = null;
		}
		if (NewrestrictedEventType == null)
		{
			NewrestrictedEventType = new IDefinedEventType();
		}
		enter = ControlInput("enter", Trigger);
		exit = ControlOutput("exit");
		BuildFromInfo();
		Succession(enter, exit);
	}

	private void BuildFromInfo()
	{
		inputPorts.Clear();
		if (NeweventType.type == null)
		{
			return;
		}
		Info = ReflectedInfo.For(NeweventType.type);
		foreach (KeyValuePair<string, FieldInfo> reflectedField in Info.reflectedFields)
		{
			if (reflectedField.Value.FieldType == typeof(bool))
			{
				inputPorts.Add(ValueInput(reflectedField.Value.Name, @default: false));
			}
			else if (reflectedField.Value.FieldType == typeof(int))
			{
				inputPorts.Add(ValueInput(reflectedField.Value.Name, 0));
			}
			else if (reflectedField.Value.FieldType == typeof(float))
			{
				inputPorts.Add(ValueInput(reflectedField.Value.Name, 0f));
			}
			else if (reflectedField.Value.FieldType == typeof(string))
			{
				inputPorts.Add(ValueInput(reflectedField.Value.Name, ""));
			}
			else if (reflectedField.Value.FieldType == typeof(GameObject))
			{
				inputPorts.Add(ValueInput<GameObject>(reflectedField.Value.Name, null).NullMeansSelf());
			}
			else
			{
				inputPorts.Add(ValueInput(reflectedField.Value.FieldType, reflectedField.Value.Name));
			}
		}
		foreach (KeyValuePair<string, PropertyInfo> reflectedProperty in Info.reflectedProperties)
		{
			if (reflectedProperty.Value.PropertyType == typeof(bool))
			{
				inputPorts.Add(ValueInput(reflectedProperty.Value.Name, @default: false));
			}
			else if (reflectedProperty.Value.PropertyType == typeof(int))
			{
				inputPorts.Add(ValueInput(reflectedProperty.Value.Name, 0));
			}
			else if (reflectedProperty.Value.PropertyType == typeof(float))
			{
				inputPorts.Add(ValueInput(reflectedProperty.Value.Name, 0f));
			}
			else if (reflectedProperty.Value.PropertyType == typeof(string))
			{
				inputPorts.Add(ValueInput(reflectedProperty.Value.Name, ""));
			}
			else if (reflectedProperty.Value.PropertyType == typeof(GameObject))
			{
				inputPorts.Add(ValueInput<GameObject>(reflectedProperty.Value.Name, null).NullMeansSelf());
			}
			else
			{
				inputPorts.Add(ValueInput(reflectedProperty.Value.PropertyType, reflectedProperty.Value.Name));
			}
		}
	}

	private ControlOutput Trigger(Flow flow)
	{
		if (NeweventType.type == null)
		{
			return exit;
		}
		object obj = Activator.CreateInstance(NeweventType.type);
		for (int i = 0; i < inputPorts.Count; i++)
		{
			ValueInput valueInput = inputPorts[i];
			string key = valueInput.key;
			object value = flow.GetValue(valueInput);
			if (Info.reflectedFields.ContainsKey(key))
			{
				Info.reflectedFields[key].SetValue(obj, value);
			}
			else if (Info.reflectedProperties.ContainsKey(key))
			{
				Info.reflectedProperties[key].SetValue(obj, value);
			}
		}
		GlobalDefinedEventNode.Trigger(obj);
		return exit;
	}
}
