using System;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

public sealed class ValueOutput : UnitPort<ValueInput, IUnitInputPort, ValueConnection>, IUnitValuePort, IUnitPort, IGraphItem, IUnitOutputPort
{
	internal readonly Func<Flow, object> getValue;

	internal Func<Flow, bool> canPredictValue;

	public bool supportsPrediction => canPredictValue != null;

	public bool supportsFetch => getValue != null;

	public Type type { get; }

	public override IEnumerable<ValueConnection> validConnections => unit?.graph?.valueConnections.WithSource(this) ?? Enumerable.Empty<ValueConnection>();

	public override IEnumerable<InvalidConnection> invalidConnections => unit?.graph?.invalidConnections.WithSource(this) ?? Enumerable.Empty<InvalidConnection>();

	public override IEnumerable<ValueInput> validConnectedPorts => validConnections.Select((ValueConnection c) => c.destination);

	public override IEnumerable<IUnitInputPort> invalidConnectedPorts => invalidConnections.Select((InvalidConnection c) => c.destination);

	public ValueOutput(string key, Type type, Func<Flow, object> getValue)
		: base(key)
	{
		Ensure.That("type").IsNotNull(type);
		Ensure.That("getValue").IsNotNull(getValue);
		this.type = type;
		this.getValue = getValue;
	}

	public ValueOutput(string key, Type type)
		: base(key)
	{
		Ensure.That("type").IsNotNull(type);
		this.type = type;
	}

	public override bool CanConnectToValid(ValueInput port)
	{
		return type.IsConvertibleTo(port.type, guaranteed: false);
	}

	public override void ConnectToValid(ValueInput port)
	{
		port.Disconnect();
		unit.graph.valueConnections.Add(new ValueConnection(this, port));
	}

	public override void ConnectToInvalid(IUnitInputPort port)
	{
		ConnectInvalid(this, port);
	}

	public override void DisconnectFromValid(ValueInput port)
	{
		ValueConnection valueConnection = validConnections.SingleOrDefault((ValueConnection c) => c.destination == port);
		if (valueConnection != null)
		{
			unit.graph.valueConnections.Remove(valueConnection);
		}
	}

	public override void DisconnectFromInvalid(IUnitInputPort port)
	{
		DisconnectInvalid(this, port);
	}

	public ValueOutput PredictableIf(Func<Flow, bool> condition)
	{
		Ensure.That("condition").IsNotNull(condition);
		canPredictValue = condition;
		return this;
	}

	public ValueOutput Predictable()
	{
		canPredictValue = (Flow flow) => true;
		return this;
	}

	public override IUnitPort CompatiblePort(IUnit unit)
	{
		if (unit == base.unit)
		{
			return null;
		}
		return unit.CompatibleValueInput(type);
	}
}
