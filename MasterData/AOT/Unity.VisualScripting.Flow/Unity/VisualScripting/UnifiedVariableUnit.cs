using System;
using UnityEngine;

namespace Unity.VisualScripting;

[SpecialUnit]
public abstract class UnifiedVariableUnit : Unit, IUnifiedVariableUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[UnitHeaderInspectable]
	[Inspectable]
	[Serialize]
	public VariableKind kind { get; set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput name { get; private set; }

	[NullMeansSelf]
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput @object { get; private set; }

	protected override void Definition()
	{
		name = ValueInput("name", string.Empty);
		if (kind == VariableKind.Object)
		{
			@object = ValueInput<GameObject>("object", null).NullMeansSelf();
		}
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
