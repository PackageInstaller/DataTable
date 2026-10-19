using System;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

public sealed class ControlOutput : UnitPort<ControlInput, IUnitInputPort, ControlConnection>, IUnitControlPort, IUnitPort, IGraphItem, IUnitOutputPort
{
	public override IEnumerable<ControlConnection> validConnections => unit?.graph?.controlConnections.WithSource(this) ?? Enumerable.Empty<ControlConnection>();

	public override IEnumerable<InvalidConnection> invalidConnections => unit?.graph?.invalidConnections.WithSource(this) ?? Enumerable.Empty<InvalidConnection>();

	public override IEnumerable<ControlInput> validConnectedPorts => validConnections.Select((ControlConnection c) => c.destination);

	public override IEnumerable<IUnitInputPort> invalidConnectedPorts => invalidConnections.Select((InvalidConnection c) => c.destination);

	public bool isPredictable
	{
		get
		{
			using Recursion recursion = Recursion.New(1);
			return IsPredictable(recursion);
		}
	}

	public bool couldBeEntered
	{
		get
		{
			if (!isPredictable)
			{
				throw new NotSupportedException();
			}
			if (unit.isControlRoot)
			{
				return true;
			}
			return (from r in unit.relations.WithDestination(this)
				where r.source is ControlInput
				select r).Any((IUnitRelation r) => ((ControlInput)r.source).couldBeEntered);
		}
	}

	public ControlConnection connection => unit.graph?.controlConnections.SingleOrDefaultWithSource(this);

	public override bool hasValidConnection => connection != null;

	public ControlOutput(string key)
		: base(key)
	{
	}

	public bool IsPredictable(Recursion recursion)
	{
		if (unit.isControlRoot)
		{
			return true;
		}
		Recursion recursion2 = recursion;
		if (recursion2 != null && !recursion2.TryEnter(this))
		{
			return false;
		}
		bool result = (from r in unit.relations.WithDestination(this)
			where r.source is ControlInput
			select r).All((IUnitRelation r) => ((ControlInput)r.source).IsPredictable(recursion));
		Recursion recursion3 = recursion;
		if (recursion3 != null)
		{
			recursion3.Exit(this);
			return result;
		}
		return result;
	}

	public override bool CanConnectToValid(ControlInput port)
	{
		return true;
	}

	public override void ConnectToValid(ControlInput port)
	{
		Disconnect();
		unit.graph.controlConnections.Add(new ControlConnection(this, port));
	}

	public override void ConnectToInvalid(IUnitInputPort port)
	{
		ConnectInvalid(this, port);
	}

	public override void DisconnectFromValid(ControlInput port)
	{
		ControlConnection controlConnection = validConnections.SingleOrDefault((ControlConnection c) => c.destination == port);
		if (controlConnection != null)
		{
			unit.graph.controlConnections.Remove(controlConnection);
		}
	}

	public override void DisconnectFromInvalid(IUnitInputPort port)
	{
		DisconnectInvalid(this, port);
	}

	public override IUnitPort CompatiblePort(IUnit unit)
	{
		if (unit == base.unit)
		{
			return null;
		}
		return unit.controlInputs.FirstOrDefault();
	}
}
