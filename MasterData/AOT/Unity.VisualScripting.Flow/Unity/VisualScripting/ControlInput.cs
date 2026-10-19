using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

public sealed class ControlInput : UnitPort<ControlOutput, IUnitOutputPort, ControlConnection>, IUnitControlPort, IUnitPort, IGraphItem, IUnitInputPort
{
	internal readonly Func<Flow, ControlOutput> action;

	internal readonly Func<Flow, IEnumerator> coroutineAction;

	public bool supportsCoroutine => coroutineAction != null;

	public bool requiresCoroutine => action == null;

	public override IEnumerable<ControlConnection> validConnections => unit?.graph?.controlConnections.WithDestination(this) ?? Enumerable.Empty<ControlConnection>();

	public override IEnumerable<InvalidConnection> invalidConnections => unit?.graph?.invalidConnections.WithDestination(this) ?? Enumerable.Empty<InvalidConnection>();

	public override IEnumerable<ControlOutput> validConnectedPorts => validConnections.Select((ControlConnection c) => c.source);

	public override IEnumerable<IUnitOutputPort> invalidConnectedPorts => invalidConnections.Select((InvalidConnection c) => c.source);

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
			if (!hasValidConnection)
			{
				return false;
			}
			return validConnectedPorts.Any((ControlOutput cop) => cop.couldBeEntered);
		}
	}

	public ControlInput(string key, Func<Flow, ControlOutput> action)
		: base(key)
	{
		Ensure.That("action").IsNotNull(action);
		this.action = action;
	}

	public ControlInput(string key, Func<Flow, IEnumerator> coroutineAction)
		: base(key)
	{
		Ensure.That("coroutineAction").IsNotNull(coroutineAction);
		this.coroutineAction = coroutineAction;
	}

	public ControlInput(string key, Func<Flow, ControlOutput> action, Func<Flow, IEnumerator> coroutineAction)
		: base(key)
	{
		Ensure.That("action").IsNotNull(action);
		Ensure.That("coroutineAction").IsNotNull(coroutineAction);
		this.action = action;
		this.coroutineAction = coroutineAction;
	}

	public bool IsPredictable(Recursion recursion)
	{
		if (!hasValidConnection)
		{
			return true;
		}
		Recursion recursion2 = recursion;
		if (recursion2 != null && !recursion2.TryEnter(this))
		{
			return false;
		}
		bool result = validConnectedPorts.All((ControlOutput cop) => cop.IsPredictable(recursion));
		Recursion recursion3 = recursion;
		if (recursion3 != null)
		{
			recursion3.Exit(this);
			return result;
		}
		return result;
	}

	public override bool CanConnectToValid(ControlOutput port)
	{
		return true;
	}

	public override void ConnectToValid(ControlOutput port)
	{
		port.Disconnect();
		unit.graph.controlConnections.Add(new ControlConnection(port, this));
	}

	public override void ConnectToInvalid(IUnitOutputPort port)
	{
		ConnectInvalid(port, this);
	}

	public override void DisconnectFromValid(ControlOutput port)
	{
		ControlConnection controlConnection = validConnections.SingleOrDefault((ControlConnection c) => c.source == port);
		if (controlConnection != null)
		{
			unit.graph.controlConnections.Remove(controlConnection);
		}
	}

	public override void DisconnectFromInvalid(IUnitOutputPort port)
	{
		DisconnectInvalid(port, this);
	}

	public override IUnitPort CompatiblePort(IUnit unit)
	{
		if (unit == base.unit)
		{
			return null;
		}
		return unit.controlOutputs.FirstOrDefault();
	}
}
