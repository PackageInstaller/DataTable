using System;

namespace Unity.VisualScripting;

[UnitSurtitle("Graph")]
public sealed class GetGraphVariable : GetVariableUnit, IGraphVariableUnit, IVariableUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public GetGraphVariable()
	{
	}

	public GetGraphVariable(string defaultName)
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
