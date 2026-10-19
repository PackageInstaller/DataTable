using System;

namespace Unity.VisualScripting;

[UnitSurtitle("Application")]
public sealed class GetApplicationVariable : GetVariableUnit, IApplicationVariableUnit, IVariableUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public GetApplicationVariable()
	{
	}

	public GetApplicationVariable(string defaultName)
		: base(defaultName)
	{
	}

	protected override VariableDeclarations GetDeclarations(Flow flow)
	{
		return Variables.Application;
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
