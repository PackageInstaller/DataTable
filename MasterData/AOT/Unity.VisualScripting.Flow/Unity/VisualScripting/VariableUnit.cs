using System;

namespace Unity.VisualScripting;

[Obsolete("Use the new unified variable nodes instead.")]
[SpecialUnit]
public abstract class VariableUnit : Unit, IVariableUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[DoNotSerialize]
	public string defaultName { get; } = string.Empty;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput name { get; private set; }

	protected VariableUnit()
	{
	}

	protected VariableUnit(string defaultName)
	{
		Ensure.That("defaultName").IsNotNull(defaultName);
		this.defaultName = defaultName;
	}

	protected abstract VariableDeclarations GetDeclarations(Flow flow);

	protected override void Definition()
	{
		name = ValueInput("name", defaultName);
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
