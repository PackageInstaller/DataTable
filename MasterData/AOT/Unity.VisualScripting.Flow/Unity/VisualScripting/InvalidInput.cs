using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

public sealed class InvalidInput : UnitPort<IUnitOutputPort, IUnitOutputPort, InvalidConnection>, IUnitInvalidPort, IUnitPort, IGraphItem, IUnitInputPort
{
	public override IEnumerable<InvalidConnection> validConnections => unit?.graph?.invalidConnections.WithDestination(this) ?? Enumerable.Empty<InvalidConnection>();

	public override IEnumerable<InvalidConnection> invalidConnections => Enumerable.Empty<InvalidConnection>();

	public override IEnumerable<IUnitOutputPort> validConnectedPorts => validConnections.Select((InvalidConnection c) => c.source);

	public override IEnumerable<IUnitOutputPort> invalidConnectedPorts => invalidConnections.Select((InvalidConnection c) => c.source);

	public InvalidInput(string key)
		: base(key)
	{
	}

	public override bool CanConnectToValid(IUnitOutputPort port)
	{
		return false;
	}

	public override void ConnectToValid(IUnitOutputPort port)
	{
		ConnectInvalid(port, this);
	}

	public override void ConnectToInvalid(IUnitOutputPort port)
	{
		ConnectInvalid(port, this);
	}

	public override void DisconnectFromValid(IUnitOutputPort port)
	{
		DisconnectInvalid(port, this);
	}

	public override void DisconnectFromInvalid(IUnitOutputPort port)
	{
		DisconnectInvalid(port, this);
	}

	public override IUnitPort CompatiblePort(IUnit unit)
	{
		return null;
	}
}
