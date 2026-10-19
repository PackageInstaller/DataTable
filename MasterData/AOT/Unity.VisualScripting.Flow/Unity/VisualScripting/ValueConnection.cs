using System;

namespace Unity.VisualScripting;

public sealed class ValueConnection : UnitConnection<ValueOutput, ValueInput>, IUnitConnection, IConnection<IUnitOutputPort, IUnitInputPort>, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public class DebugData : UnitConnectionDebugData
	{
		public object lastValue { get; set; }

		public bool assignedLastValue { get; set; }
	}

	public override ValueOutput source => sourceUnit.valueOutputs[sourceKey];

	public override ValueInput destination => destinationUnit.valueInputs[destinationKey];

	IUnitOutputPort IConnection<IUnitOutputPort, IUnitInputPort>.source => source;

	IUnitInputPort IConnection<IUnitOutputPort, IUnitInputPort>.destination => destination;

	public override bool sourceExists => sourceUnit.valueOutputs.Contains(sourceKey);

	public override bool destinationExists => destinationUnit.valueInputs.Contains(destinationKey);

	public override IGraphElementDebugData CreateDebugData()
	{
		return new DebugData();
	}

	[Obsolete("This parameterless constructor is only made public for serialization. Use another constructor instead.")]
	public ValueConnection()
	{
	}

	public ValueConnection(ValueOutput source, ValueInput destination)
		: base(source, destination)
	{
		if (destination.hasValidConnection)
		{
			throw new InvalidConnectionException("Value input ports do not support multiple connections.");
		}
		if (!source.type.IsConvertibleTo(destination.type, guaranteed: false))
		{
			throw new InvalidConnectionException($"Cannot convert from '{source.type}' to '{destination.type}'.");
		}
	}

	FlowGraph IUnitConnection.get_graph()
	{
		return graph;
	}
}
