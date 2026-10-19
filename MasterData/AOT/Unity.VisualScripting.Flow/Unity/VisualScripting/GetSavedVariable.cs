using System;

namespace Unity.VisualScripting;

[UnitSurtitle("Save")]
public sealed class GetSavedVariable : GetVariableUnit, ISavedVariableUnit, IVariableUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public GetSavedVariable()
	{
	}

	public GetSavedVariable(string defaultName)
		: base(defaultName)
	{
	}

	protected override VariableDeclarations GetDeclarations(Flow flow)
	{
		return Variables.Saved;
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
