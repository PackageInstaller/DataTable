using System;

namespace Unity.VisualScripting;

public sealed class ControlConnection : UnitConnection<ControlOutput, ControlInput>, IUnitConnection, IConnection<IUnitOutputPort, IUnitInputPort>, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public override ControlOutput source => sourceUnit.controlOutputs[sourceKey];

	public override ControlInput destination => destinationUnit.controlInputs[destinationKey];

	IUnitOutputPort IConnection<IUnitOutputPort, IUnitInputPort>.source => source;

	IUnitInputPort IConnection<IUnitOutputPort, IUnitInputPort>.destination => destination;

	public override bool sourceExists => sourceUnit.controlOutputs.Contains(sourceKey);

	public override bool destinationExists => destinationUnit.controlInputs.Contains(destinationKey);

	[Obsolete("This parameterless constructor is only made public for serialization. Use another constructor instead.")]
	public ControlConnection()
	{
	}

	public ControlConnection(ControlOutput source, ControlInput destination)
		: base(source, destination)
	{
		if (source.hasValidConnection)
		{
			throw new InvalidConnectionException("Control output ports do not support multiple connections.");
		}
	}

	FlowGraph IUnitConnection.get_graph()
	{
		return graph;
	}
}
