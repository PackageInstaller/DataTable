using System;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[TypeIcon(typeof(If))]
[UnitCategory("Community\\Control")]
[UnitShortTitle("Branch")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.BranchParams")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.BranchParams")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.BranchAnd")]
[UnitTitle("Branch (Params)")]
public sealed class BranchParams : LogicParamNode, IBranchUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[Inspectable]
	[Serialize]
	[InspectorLabel("Next Output")]
	private bool showNext;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	[PortLabel("True")]
	public ControlOutput exitTrue { get; private set; }

	[PortLabel("False")]
	[DoNotSerialize]
	public ControlOutput exitFalse { get; private set; }

	[PortLabel("Next")]
	[DoNotSerialize]
	public ControlOutput exitNext { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Branch);
		exitTrue = ControlOutput("exitTrue");
		exitFalse = ControlOutput("exitFalse");
		if (showNext)
		{
			exitNext = ControlOutput("exitNext");
			Succession(enter, exitNext);
		}
		base.Definition();
		Succession(enter, exitTrue);
		Succession(enter, exitFalse);
	}

	protected override void BuildRelations(ValueInput arg)
	{
		Requirement(arg, enter);
	}

	private bool GetValue(Flow flow)
	{
		switch (BranchingType)
		{
		case BranchType.And:
			foreach (ValueInput argument in arguments)
			{
				if (!flow.GetValue<bool>(argument))
				{
					return false;
				}
			}
			return true;
		case BranchType.Or:
			foreach (ValueInput argument2 in arguments)
			{
				if (flow.GetValue<bool>(argument2))
				{
					return true;
				}
			}
			return false;
		case BranchType.GreaterThan:
			return NumericComparison2(flow.GetValue<float>(arguments[0]), flow.GetValue<float>(arguments[1]), AllowEquals);
		case BranchType.LessThan:
			return NumericComparison(flow.GetValue<float>(arguments[0]), flow.GetValue<float>(arguments[1]), AllowEquals);
		case BranchType.Equal:
		{
			if (Numeric)
			{
				float value = flow.GetValue<float>(arguments[0]);
				for (int i = 1; i < arguments.Count; i++)
				{
					if (!Mathf.Approximately(value, flow.GetValue<float>(arguments[i])))
					{
						return false;
					}
				}
				return true;
			}
			object value2 = flow.GetValue<object>(arguments[0]);
			for (int j = 1; j < arguments.Count; j++)
			{
				if (!OperatorUtility.Equal(value2, flow.GetValue<object>(arguments[j])))
				{
					return false;
				}
			}
			return true;
		}
		default:
			return false;
		}
		static bool NumericComparison(float a, float b, bool allowEquals)
		{
			if (!(a < b))
			{
				if (allowEquals)
				{
					return Mathf.Approximately(a, b);
				}
				return false;
			}
			return true;
		}
		static bool NumericComparison2(float a, float b, bool allowEquals)
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

	private ControlOutput Branch(Flow flow)
	{
		if (showNext)
		{
			if (GetValue(flow))
			{
				flow.Invoke(exitTrue);
			}
			else
			{
				flow.Invoke(exitFalse);
			}
			return exitNext;
		}
		if (!GetValue(flow))
		{
			return exitFalse;
		}
		return exitTrue;
	}
}
