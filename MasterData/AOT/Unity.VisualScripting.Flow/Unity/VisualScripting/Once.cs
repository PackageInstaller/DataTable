using System;

namespace Unity.VisualScripting;

[UnitCategory("Control")]
[UnitOrder(14)]
public sealed class Once : Unit, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public sealed class Data : IGraphElementData
	{
		public bool executed;
	}

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ControlInput reset { get; private set; }

	[DoNotSerialize]
	public ControlOutput once { get; private set; }

	[DoNotSerialize]
	public ControlOutput after { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		reset = ControlInput("reset", Reset);
		once = ControlOutput("once");
		after = ControlOutput("after");
		Succession(enter, once);
		Succession(enter, after);
	}

	public IGraphElementData CreateData()
	{
		return new Data();
	}

	public ControlOutput Enter(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (!elementData.executed)
		{
			elementData.executed = true;
			return once;
		}
		return after;
	}

	public ControlOutput Reset(Flow flow)
	{
		flow.stack.GetElementData<Data>(this).executed = false;
		return null;
	}
}
