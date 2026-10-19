using System;
using UnityEngine;

namespace Unity.VisualScripting.Community.Deprecated;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.BranchGreater")]
[Obsolete("Use the Branch (Param) node instead!  It supersede this one!")]
[UnitOrder(1)]
[UnitCategory("Community\\Control")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.BranchGreater")]
public sealed class BranchGreater : ComparisonBranch
{
	[DoNotSerialize]
	public ValueInput AllowEquals { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<float>("a");
		b = ValueInput("b", 0f);
		AllowEquals = ValueInput("AllowEquals", @default: false);
		base.Definition();
		Requirement(AllowEquals, enter);
		Requirement(AllowEquals, enter);
	}

	public override bool Comparison(Flow flow)
	{
		return NumericComparison(flow.GetValue<float>(a), flow.GetValue<float>(b), flow.GetValue<bool>(AllowEquals));
	}

	private bool NumericComparison(float a, float b, bool allowEquals)
	{
		if (!(a > b))
		{
			if (allowEquals)
			{
				return Mathf.Approximately(a, b);
			}
			return false;
		}
		return true;
	}
}
