using System;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.ComparisonBranch")]
public abstract class ComparisonBranch : Unit, IBranchUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ValueInput a { get; protected set; }

	[DoNotSerialize]
	public ValueInput b { get; protected set; }

	[DoNotSerialize]
	[PortLabel("True")]
	public ControlOutput ifTrue { get; private set; }

	[DoNotSerialize]
	[PortLabel("False")]
	public ControlOutput ifFalse { get; private set; }

	public ComparisonBranch()
	{
	}

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		ifTrue = ControlOutput("ifTrue");
		ifFalse = ControlOutput("ifFalse");
		Succession(enter, ifTrue);
		Succession(enter, ifFalse);
		Requirement(a, enter);
		Requirement(b, enter);
	}

	public abstract bool Comparison(Flow flow);

	public ControlOutput Enter(Flow flow)
	{
		if (Comparison(flow))
		{
			return ifTrue;
		}
		return ifFalse;
	}
}
