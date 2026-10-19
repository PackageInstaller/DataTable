using System;

namespace Unity.VisualScripting;

[UnitOrder(0)]
[UnitCategory("Control")]
[RenamedFrom("Bolt.Branch")]
[RenamedFrom("Unity.VisualScripting.Branch")]
public sealed class If : Unit, IBranchUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput condition { get; private set; }

	[PortLabel("True")]
	[DoNotSerialize]
	public ControlOutput ifTrue { get; private set; }

	[DoNotSerialize]
	[PortLabel("False")]
	public ControlOutput ifFalse { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		condition = ValueInput<bool>("condition");
		ifTrue = ControlOutput("ifTrue");
		ifFalse = ControlOutput("ifFalse");
		Requirement(condition, enter);
		Succession(enter, ifTrue);
		Succession(enter, ifFalse);
	}

	public ControlOutput Enter(Flow flow)
	{
		if (!flow.GetValue<bool>(condition))
		{
			return ifFalse;
		}
		return ifTrue;
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
