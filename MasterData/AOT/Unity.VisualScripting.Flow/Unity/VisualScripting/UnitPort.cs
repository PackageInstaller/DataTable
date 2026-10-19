using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

public abstract class UnitPort<TValidOther, TInvalidOther, TExternalConnection> : IUnitPort, IGraphItem where TValidOther : IUnitPort where TInvalidOther : IUnitPort where TExternalConnection : IUnitConnection
{
	public IUnit unit { get; set; }

	public string key { get; }

	public IGraph graph => unit?.graph;

	public IEnumerable<IUnitRelation> relations => LinqUtility.Concat<IUnitRelation>(new IEnumerable[2]
	{
		unit.relations.WithSource(this),
		unit.relations.WithDestination(this)
	}).Distinct();

	public abstract IEnumerable<TExternalConnection> validConnections { get; }

	public abstract IEnumerable<InvalidConnection> invalidConnections { get; }

	public abstract IEnumerable<TValidOther> validConnectedPorts { get; }

	public abstract IEnumerable<TInvalidOther> invalidConnectedPorts { get; }

	IEnumerable<IUnitConnection> IUnitPort.validConnections => validConnections.Cast<IUnitConnection>();

	public IEnumerable<IUnitConnection> connections => LinqUtility.Concat<IUnitConnection>(new IEnumerable[2] { validConnections, invalidConnections });

	public IEnumerable<IUnitPort> connectedPorts => LinqUtility.Concat<IUnitPort>(new IEnumerable[2] { validConnectedPorts, invalidConnectedPorts });

	public bool hasAnyConnection
	{
		get
		{
			if (!hasValidConnection)
			{
				return hasInvalidConnection;
			}
			return true;
		}
	}

	public virtual bool hasValidConnection => validConnections.Any();

	public virtual bool hasInvalidConnection => invalidConnections.Any();

	protected UnitPort(string key)
	{
		Ensure.That("key").IsNotNull(key);
		this.key = key;
	}

	private bool CanConnectTo(IUnitPort port)
	{
		Ensure.That("port").IsNotNull(port);
		if (unit != null && port.unit != null && port.unit != unit)
		{
			return port.unit.graph == unit.graph;
		}
		return false;
	}

	public bool CanValidlyConnectTo(IUnitPort port)
	{
		if (CanConnectTo(port) && port is TValidOther)
		{
			return CanConnectToValid((TValidOther)port);
		}
		return false;
	}

	public bool CanInvalidlyConnectTo(IUnitPort port)
	{
		if (CanConnectTo(port) && port is TInvalidOther)
		{
			return CanConnectToInvalid((TInvalidOther)port);
		}
		return false;
	}

	public void ValidlyConnectTo(IUnitPort port)
	{
		Ensure.That("port").IsNotNull(port);
		if (!(port is TValidOther))
		{
			throw new InvalidConnectionException();
		}
		ConnectToValid((TValidOther)port);
	}

	public void InvalidlyConnectTo(IUnitPort port)
	{
		Ensure.That("port").IsNotNull(port);
		if (!(port is TInvalidOther))
		{
			throw new InvalidConnectionException();
		}
		ConnectToInvalid((TInvalidOther)port);
	}

	public void Disconnect()
	{
		while (validConnectedPorts.Any())
		{
			DisconnectFromValid(validConnectedPorts.First());
		}
		while (invalidConnectedPorts.Any())
		{
			DisconnectFromInvalid(invalidConnectedPorts.First());
		}
	}

	public abstract bool CanConnectToValid(TValidOther port);

	public bool CanConnectToInvalid(TInvalidOther port)
	{
		return true;
	}

	public abstract void ConnectToValid(TValidOther port);

	public abstract void ConnectToInvalid(TInvalidOther port);

	public abstract void DisconnectFromValid(TValidOther port);

	public abstract void DisconnectFromInvalid(TInvalidOther port);

	public abstract IUnitPort CompatiblePort(IUnit unit);

	protected void ConnectInvalid(IUnitOutputPort source, IUnitInputPort destination)
	{
		if (unit.graph.invalidConnections.SingleOrDefault((InvalidConnection c) => c.source == source && c.destination == destination) == null)
		{
			unit.graph.invalidConnections.Add(new InvalidConnection(source, destination));
		}
	}

	protected void DisconnectInvalid(IUnitOutputPort source, IUnitInputPort destination)
	{
		InvalidConnection invalidConnection = unit.graph.invalidConnections.SingleOrDefault((InvalidConnection c) => c.source == source && c.destination == destination);
		if (invalidConnection != null)
		{
			unit.graph.invalidConnections.Remove(invalidConnection);
		}
	}
}
