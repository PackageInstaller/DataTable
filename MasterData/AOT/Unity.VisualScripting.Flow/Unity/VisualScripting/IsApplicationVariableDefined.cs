using System;

namespace Unity.VisualScripting;

[UnitSurtitle("Application")]
public sealed class IsApplicationVariableDefined : IsVariableDefinedUnit, IApplicationVariableUnit, IVariableUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public IsApplicationVariableDefined()
	{
	}

	public IsApplicationVariableDefined(string defaultName)
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
