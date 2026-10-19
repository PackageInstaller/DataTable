using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Control")]
[UnitTitle("Select On Flow")]
[UnitOrder(8)]
[TypeIcon(typeof(ISelectUnit))]
[UnitSubtitle("On Flow")]
[UnitShortTitle("Select")]
public sealed class SelectOnFlow : Unit, ISelectUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[SerializeAs("branchCount")]
	private int _branchCount = 2;

	[UnitHeaderInspectable("Branches")]
	[DoNotSerialize]
	[Inspectable]
	public int branchCount
	{
		get
		{
			return _branchCount;
		}
		set
		{
			_branchCount = Mathf.Clamp(value, 2, 10);
		}
	}

	[DoNotSerialize]
	public Dictionary<ControlInput, ValueInput> branches { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput selection { get; private set; }

	protected override void Definition()
	{
		branches = new Dictionary<ControlInput, ValueInput>();
		selection = ValueOutput<object>("selection");
		exit = ControlOutput("exit");
		for (int i = 0; i < branchCount; i++)
		{
			ValueInput branchValue = ValueInput<object>("value_" + i);
			ControlInput controlInput = ControlInput("enter_" + i, (Flow flow) => Select(flow, branchValue));
			Requirement(branchValue, controlInput);
			Assignment(controlInput, selection);
			Succession(controlInput, exit);
			branches.Add(controlInput, branchValue);
		}
	}

	public ControlOutput Select(Flow flow, ValueInput branchValue)
	{
		flow.SetValue(selection, flow.GetValue(branchValue));
		return exit;
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
