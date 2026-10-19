using System;

namespace Unity.VisualScripting;

[UnitCategory("Control")]
[UnitFooterPorts(ControlInputs = true, ControlOutputs = true)]
[UnitOrder(18)]
public sealed class ToggleFlow : Unit, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public class Data : IGraphElementData
	{
		public bool isOn;
	}

	[Serialize]
	[UnitHeaderInspectable("Start On")]
	[InspectorToggleLeft]
	[Inspectable]
	public bool startOn { get; set; } = true;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[PortLabel("On")]
	[DoNotSerialize]
	public ControlInput turnOn { get; private set; }

	[DoNotSerialize]
	[PortLabel("Off")]
	public ControlInput turnOff { get; private set; }

	[DoNotSerialize]
	public ControlInput toggle { get; private set; }

	[PortLabel("On")]
	[DoNotSerialize]
	public ControlOutput exitOn { get; private set; }

	[PortLabel("Off")]
	[DoNotSerialize]
	public ControlOutput exitOff { get; private set; }

	[DoNotSerialize]
	public ControlOutput turnedOn { get; private set; }

	[DoNotSerialize]
	public ControlOutput turnedOff { get; private set; }

	[DoNotSerialize]
	public ValueOutput isOn { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		turnOn = ControlInput("turnOn", TurnOn);
		turnOff = ControlInput("turnOff", TurnOff);
		toggle = ControlInput("toggle", Toggle);
		exitOn = ControlOutput("exitOn");
		exitOff = ControlOutput("exitOff");
		turnedOn = ControlOutput("turnedOn");
		turnedOff = ControlOutput("turnedOff");
		isOn = ValueOutput("isOn", IsOn);
		Succession(enter, exitOn);
		Succession(enter, exitOff);
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

	private ControlOutput Enter(Flow flow)
	{
		if (!IsOn(flow))
		{
			return exitOff;
		}
		return exitOn;
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
}
