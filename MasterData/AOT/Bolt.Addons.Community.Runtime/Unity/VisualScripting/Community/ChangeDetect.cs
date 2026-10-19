using System;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Logic.Units.ChangeDetect")]
[UnitCategory("Community\\Control")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.ChangeDetect")]
[TypeIcon(typeof(ISelectUnit))]
public sealed class ChangeDetect : Unit, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public sealed class Data : IGraphElementData
	{
		public object lastValue;
	}

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ValueInput input { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput lastValue { get; private set; }

	[DoNotSerialize]
	public ControlOutput onChange { get; private set; }

	public IGraphElementData CreateData()
	{
		return new Data();
	}

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		input = ValueInput<object>("input");
		lastValue = ValueOutput<object>("lastValue");
		onChange = ControlOutput("onChange");
		Succession(enter, onChange);
		Requirement(input, enter);
	}

	public ControlOutput Enter(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		object value = flow.GetValue<object>(input);
		if (!OperatorUtility.Equal(elementData.lastValue, value))
		{
			elementData.lastValue = value;
			flow.SetValue(lastValue, value);
			return onChange;
		}
		return null;
	}
}
