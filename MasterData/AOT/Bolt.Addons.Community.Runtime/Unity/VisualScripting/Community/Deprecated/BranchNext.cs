using System;

namespace Unity.VisualScripting.Community.Deprecated;

[UnitCategory("Community\\Control")]
[RenamedFrom("Bolt.Addons.Community.Variables.Units.BranchNext")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.BranchNext")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.BranchNext")]
[Obsolete("Use the Branch (Param) node instead!  It supersede this one!")]
[UnitOrder(0)]
public sealed class BranchNext : Unit, IBranchUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput condition { get; private set; }

	[DoNotSerialize]
	[PortLabel("True")]
	public ControlOutput ifTrue { get; private set; }

	[DoNotSerialize]
	[PortLabel("False")]
	public ControlOutput ifFalse { get; private set; }

	[DoNotSerialize]
	[PortLabel("Next")]
	public ControlOutput onNext { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		condition = ValueInput<bool>("condition");
		ifTrue = ControlOutput("ifTrue");
		ifFalse = ControlOutput("ifFalse");
		onNext = ControlOutput("onNext");
		Succession(enter, ifTrue);
		Succession(enter, ifFalse);
		Succession(enter, onNext);
		Requirement(condition, enter);
	}

	public ControlOutput Enter(Flow flow)
	{
		if (flow.GetValue<bool>(condition))
		{
			flow.Invoke(ifTrue);
		}
		else
		{
			flow.Invoke(ifFalse);
		}
		return onNext;
	}
}
