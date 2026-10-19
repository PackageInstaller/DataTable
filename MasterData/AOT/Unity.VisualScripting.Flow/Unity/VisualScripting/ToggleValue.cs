using System;

namespace Unity.VisualScripting;

[UnitFooterPorts(ControlInputs = true, ControlOutputs = true)]
[UnitCategory("Control")]
[UnitOrder(19)]
public sealed class ToggleValue : Unit, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public class Data : IGraphElementData
	{
		public bool isOn;
	}

	[InspectorToggleLeft]
	[UnitHeaderInspectable("Start On")]
	[Inspectable]
	[Serialize]
	public bool startOn { get; set; } = true;

	[DoNotSerialize]
	[PortLabel("On")]
	public ControlInput turnOn { get; private set; }

	[DoNotSerialize]
	[PortLabel("Off")]
	public ControlInput turnOff { get; private set; }

	[DoNotSerialize]
	public ControlInput toggle { get; private set; }

	[DoNotSerialize]
	public ValueInput onValue { get; private set; }

	[DoNotSerialize]
	public ValueInput offValue { get; private set; }

	[DoNotSerialize]
	public ControlOutput turnedOn { get; private set; }

	[DoNotSerialize]
	public ControlOutput turnedOff { get; private set; }

	[DoNotSerialize]
	public ValueOutput isOn { get; private set; }

	[DoNotSerialize]
	public ValueOutput value { get; private set; }

	protected override void Definition()
	{
		turnOn = ControlInput("turnOn", TurnOn);
		turnOff = ControlInput("turnOff", TurnOff);
		toggle = ControlInput("toggle", Toggle);
		onValue = ValueInput<object>("onValue");
		offValue = ValueInput<object>("offValue");
		turnedOn = ControlOutput("turnedOn");
		turnedOff = ControlOutput("turnedOff");
		isOn = ValueOutput("isOn", IsOn);
		value = ValueOutput("value", Value);
		Requirement(onValue, value);
		Requirement(offValue, value);
		Succession(turnOn, turnedOn);
		Succession(turnOff, turnedOff);
		Succession(toggle, turnedOn);
		Succession(toggle, turnedOff);
	}

	public IGraphElementData CreateData()
	{
		return new Data
		{
			isOn = startOn
		};
	}

	private bool IsOn(Flow flow)
	{
		return flow.stack.GetElementData<Data>(this).isOn;
	}

	private ControlOutput TurnOn(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (elementData.isOn)
		{
			return null;
		}
		elementData.isOn = true;
		return turnedOn;
	}

	private ControlOutput TurnOff(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (!elementData.isOn)
		{
			return null;
		}
		elementData.isOn = false;
		return turnedOff;
	}

	private ControlOutput Toggle(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		elementData.isOn = !elementData.isOn;
		if (!elementData.isOn)
		{
			return turnedOff;
		}
		return turnedOn;
	}

	private object Value(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		return flow.GetValue(elementData.isOn ? onValue : offValue);
	}
}
