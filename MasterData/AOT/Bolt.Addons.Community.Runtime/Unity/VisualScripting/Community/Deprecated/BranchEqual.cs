using System;
using UnityEngine;

namespace Unity.VisualScripting.Community.Deprecated;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.BranchEqual")]
[UnitCategory("Community\\Control")]
[UnitOrder(0)]
[Obsolete("Use the Branch (Param) node instead!  It supersede this one!")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.BranchEqual")]
public sealed class BranchEqual : ComparisonBranch
{
	[Serialize]
	[InspectorToggleLeft]
	[Inspectable]
	public bool numeric { get; set; } = true;

	protected override void Definition()
	{
		if (numeric)
		{
			a = ValueInput<float>("a");
			b = ValueInput("b", 0f);
		}
		else
		{
			a = ValueInput<object>("a").AllowsNull();
			b = ValueInput<object>("b").AllowsNull();
		}
		base.Definition();
	}

	public override bool Comparison(Flow flow)
	{
		if (numeric)
		{
			return NumericComparison(flow.GetValue<float>(a), flow.GetValue<float>(b));
		}
		return GenericComparison(flow.GetValue<object>(a), flow.GetValue<object>(b));
	}

	private bool NumericComparison(float a, float b)
	{
		return Mathf.Approximately(a, b);
	}

	private bool GenericComparison(object a, object b)
	{
		return OperatorUtility.Equal(a, b);
	}
}
