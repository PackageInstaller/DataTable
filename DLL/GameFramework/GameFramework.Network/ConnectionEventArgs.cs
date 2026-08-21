using System;

namespace GameFramework.Network;

public class ConnectionEventArgs : EventArgs
{
	public static readonly ConnectionEventArgs ConnectingEventArgs = new ConnectionEventArgs("Connecting");

	public static readonly ConnectionEventArgs ReconnectingEventArgs = new ConnectionEventArgs("Reconnecting");

	public static readonly ConnectionEventArgs ConnectedEventArgs = new ConnectionEventArgs("Connected");

	public static readonly ConnectionEventArgs FailedEventArgs = new ConnectionEventArgs("Failed");

	public static readonly ConnectionEventArgs ExceptionEventArgs = new ConnectionEventArgs("Exception");

	public static readonly ConnectionEventArgs ClosingEventArgs = new ConnectionEventArgs("Closing");

	public static readonly ConnectionEventArgs ClosedEventArgs = new ConnectionEventArgs("Closed");

	public string Name { get; }

	public ConnectionEventArgs(string name)
	{
		Name = name;
	}

	public override string ToString()
	{
		return "ConnectionEvent:[" + Name + "]";
	}
}
