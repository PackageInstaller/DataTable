using System;
using System.Collections.Generic;

namespace Unity.VisualScripting;

[UnitCategory("Control")]
[UnitOrder(7)]
[UnitSubtitle("On Enum")]
[TypeIcon(typeof(ISelectUnit))]
[UnitShortTitle("Select")]
[UnitTitle("Select On Enum")]
public sealed class SelectOnEnum : Unit, ISelectUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[DoNotSerialize]
	public Dictionary<object, ValueInput> branches { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput selector { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput selection { get; private set; }

	[Serialize]
	[Inspectable]
	[UnitHeaderInspectable]
	[TypeFilter(new Type[] { }, Enums = true, Classes = false, Interfaces = false, Structs = false, Primitives = false)]
	public Type enumType { get; set; }

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
		branches = new Dictionary<object, ValueInput>();
		selection = ValueOutput("selection", Branch).Predictable();
		selector = ValueInput(enumType, "selector");
		Requirement(selector, selection);
		foreach (KeyValuePair<string, Enum> item in EnumUtility.ValuesByNames(enumType))
		{
			Enum value = item.Value;
			if (!branches.ContainsKey(value))
			{
				ValueInput valueInput = ValueInput<object>("%" + item.Key).AllowsNull();
				branches.Add(value, valueInput);
				Requirement(valueInput, selection);
			}
		}
	}

	public object Branch(Flow flow)
	{
		object value = flow.GetValue(selector, enumType);
		return flow.GetValue(branches[value]);
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
