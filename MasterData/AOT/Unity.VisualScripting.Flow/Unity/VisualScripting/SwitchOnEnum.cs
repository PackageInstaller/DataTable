using System;
using System.Collections.Generic;

namespace Unity.VisualScripting;

[UnitShortTitle("Switch")]
[UnitSubtitle("On Enum")]
[TypeIcon(typeof(IBranchUnit))]
[UnitCategory("Control")]
[UnitOrder(3)]
[UnitTitle("Switch On Enum")]
public sealed class SwitchOnEnum : Unit, IBranchUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[DoNotSerialize]
	public Dictionary<Enum, ControlOutput> branches { get; private set; }

	[Inspectable]
	[UnitHeaderInspectable]
	[TypeFilter(new Type[] { }, Enums = true, Classes = false, Interfaces = false, Structs = false, Primitives = false)]
	[Serialize]
	public Type enumType { get; set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput @enum { get; private set; }

	public override bool canDefine
	{
		get
		{
			if (enumType != null)
			{
				return enumType.IsEnum;
			}
			return false;
		}
	}

	protected override void Definition()
	{
		branches = new Dictionary<Enum, ControlOutput>();
		enter = ControlInput("enter", Enter);
		@enum = ValueInput(enumType, "enum");
		Requirement(@enum, enter);
		foreach (KeyValuePair<string, Enum> item in EnumUtility.ValuesByNames(enumType))
		{
			string key = item.Key;
			Enum value = item.Value;
			if (!branches.ContainsKey(value))
			{
				ControlOutput controlOutput = ControlOutput("%" + key);
				branches.Add(value, controlOutput);
				Succession(enter, controlOutput);
			}
		}
	}

	public ControlOutput Enter(Flow flow)
	{
		Enum key = (Enum)flow.GetValue(@enum, enumType);
		if (branches.ContainsKey(key))
		{
			return branches[key];
		}
		return null;
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
