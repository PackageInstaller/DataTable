using System;
using System.Linq;

namespace Unity.VisualScripting;

public sealed class InvalidConnection : UnitConnection<IUnitOutputPort, IUnitInputPort>, IUnitConnection, IConnection<IUnitOutputPort, IUnitInputPort>, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public override IUnitOutputPort source => sourceUnit.outputs.Single((IUnitOutputPort p) => p.key == sourceKey);

	public override IUnitInputPort destination => destinationUnit.inputs.Single((IUnitInputPort p) => p.key == destinationKey);

	public IUnitOutputPort validSource => sourceUnit.validOutputs.Single((IUnitOutputPort p) => p.key == sourceKey);

	public IUnitInputPort validDestination => destinationUnit.validInputs.Single((IUnitInputPort p) => p.key == destinationKey);

	public override bool sourceExists => sourceUnit.outputs.Any((IUnitOutputPort p) => p.key == sourceKey);

	public override bool destinationExists => destinationUnit.inputs.Any((IUnitInputPort p) => p.key == destinationKey);

	public bool validSourceExists => sourceUnit.validOutputs.Any((IUnitOutputPort p) => p.key == sourceKey);

	public bool validDestinationExists => destinationUnit.validInputs.Any((IUnitInputPort p) => p.key == destinationKey);

	[Obsolete("This parameterless constructor is only made public for serialization. Use another constructor instead.")]
	public InvalidConnection()
	{
	}

	public InvalidConnection(IUnitOutputPort source, IUnitInputPort destination)
		: base(source, destination)
	{
	}

	public override void AfterRemove()
	{
		base.AfterRemove();
		source.unit.RemoveUnconnectedInvalidPorts();
		destination.unit.RemoveUnconnectedInvalidPorts();
	}

	public override bool HandleDependencies()
	{
		if (validSourceExists && validDestinationExists && validSource.CanValidlyConnectTo(validDestination))
		{
			validSource.ValidlyConnectTo(validDestination);
			return false;
		}
		if (!sourceExists)
		{
			sourceUnit.invalidOutputs.Add(new InvalidOutput(sourceKey));
		}
		if (!destinationExists)
		{
			destinationUnit.invalidInputs.Add(new InvalidInput(destinationKey));
		}
		return true;
	}

	FlowGraph IUnitConnection.get_graph()
	{
		return graph;
	}
}
