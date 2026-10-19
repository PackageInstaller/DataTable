using System;
using UnityEngine;

namespace Unity.VisualScripting;

public abstract class UnitConnection<TSourcePort, TDestinationPort> : GraphElement<FlowGraph>, IConnection<TSourcePort, TDestinationPort> where TSourcePort : class, IUnitOutputPort where TDestinationPort : class, IUnitInputPort
{
	[Serialize]
	protected IUnit sourceUnit { get; private set; }

	[Serialize]
	protected string sourceKey { get; private set; }

	[Serialize]
	protected IUnit destinationUnit { get; private set; }

	[Serialize]
	protected string destinationKey { get; private set; }

	[DoNotSerialize]
	public abstract TSourcePort source { get; }

	[DoNotSerialize]
	public abstract TDestinationPort destination { get; }

	public override int dependencyOrder => 1;

	public abstract bool sourceExists { get; }

	public abstract bool destinationExists { get; }

	[Obsolete("This parameterless constructor is only made public for serialization. Use another constructor instead.")]
	protected UnitConnection()
	{
	}

	protected UnitConnection(TSourcePort source, TDestinationPort destination)
	{
		Ensure.That("source").IsNotNull(source);
		Ensure.That("destination").IsNotNull(destination);
		if (source.unit.graph != destination.unit.graph)
		{
			throw new NotSupportedException("Cannot create connections across graphs.");
		}
		if (source.unit == destination.unit)
		{
			throw new InvalidConnectionException("Cannot create connections on the same unit.");
		}
		sourceUnit = source.unit;
		sourceKey = source.key;
		destinationUnit = destination.unit;
		destinationKey = destination.key;
	}

	public virtual IGraphElementDebugData CreateDebugData()
	{
		return new UnitConnectionDebugData();
	}

	protected void CopyFrom(UnitConnection<TSourcePort, TDestinationPort> source)
	{
		CopyFrom((GraphElement<FlowGraph>)source);
	}

	public override bool HandleDependencies()
	{
		bool flag = true;
		IUnitOutputPort unitOutputPort;
		if (!sourceExists)
		{
			if (!sourceUnit.invalidOutputs.Contains(sourceKey))
			{
				sourceUnit.invalidOutputs.Add(new InvalidOutput(sourceKey));
			}
			unitOutputPort = sourceUnit.invalidOutputs[sourceKey];
			flag = false;
		}
		else
		{
			unitOutputPort = source;
		}
		IUnitInputPort unitInputPort;
		if (!destinationExists)
		{
			if (!destinationUnit.invalidInputs.Contains(destinationKey))
			{
				destinationUnit.invalidInputs.Add(new InvalidInput(destinationKey));
			}
			unitInputPort = destinationUnit.invalidInputs[destinationKey];
			flag = false;
		}
		else
		{
			unitInputPort = destination;
		}
		if (!unitOutputPort.CanValidlyConnectTo(unitInputPort))
		{
			flag = false;
		}
		if (!flag && unitOutputPort.CanInvalidlyConnectTo(unitInputPort))
		{
			unitOutputPort.InvalidlyConnectTo(unitInputPort);
			if (unitOutputPort.unit.GetType() != typeof(MissingType) && unitInputPort.unit.GetType() != typeof(MissingType))
			{
				Debug.LogWarning($"Could not load connection between '{unitOutputPort.key}' of '{sourceUnit}' and '{unitInputPort.key}' of '{destinationUnit}'.");
			}
		}
		return flag;
	}

	public override AnalyticsIdentifier GetAnalyticsIdentifier()
	{
		return null;
	}
}
