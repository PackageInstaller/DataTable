using System;

namespace Unity.VisualScripting;

[UnitSurtitle("Graph")]
public sealed class IsGraphVariableDefined : IsVariableDefinedUnit, IGraphVariableUnit, IVariableUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public IsGraphVariableDefined()
	{
	}

	public IsGraphVariableDefined(string defaultName)
		: base(defaultName)
	{
	}

	protected override VariableDeclarations GetDeclarations(Flow flow)
	{
		return Variables.Graph(flow.stack);
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
