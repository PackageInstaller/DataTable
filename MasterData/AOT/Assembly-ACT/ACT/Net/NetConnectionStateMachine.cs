using System;
using UnityEngine;

namespace ACT.Net;

internal sealed class NetConnectionStateMachine
{
	public NetConnectionState Current { get; private set; }

	public event Action<NetConnectionState, NetConnectionState> StateChanged;

	public bool Fire(NetConnectionTrigger trigger, NetConnectionState next)
	{
		if (Current == next)
		{
			return false;
		}
		if (!CanTransition(Current, next))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Invalid net connection transition: {Current} --{trigger}--> {next}");
			}
			return false;
		}
		NetConnectionState current = Current;
		Current = next;
		StateChanged?.Invoke(current, next);
		return true;
	}

	private static bool CanTransition(NetConnectionState current, NetConnectionState next)
	{
		if (next == NetConnectionState.Idle)
		{
			return true;
		}
		return current switch
		{
			NetConnectionState.Idle => next == NetConnectionState.Connecting, 
			NetConnectionState.Connecting => next == NetConnectionState.TransportConnected || next == NetConnectionState.Disconnected || next == NetConnectionState.Reconnecting, 
			NetConnectionState.TransportConnected => next == NetConnectionState.Authenticating || next == NetConnectionState.Reconnecting || next == NetConnectionState.Disconnected, 
			NetConnectionState.Authenticating => next == NetConnectionState.Synchronizing || next == NetConnectionState.Online || next == NetConnectionState.Reconnecting || next == NetConnectionState.Disconnected, 
			NetConnectionState.Synchronizing => next == NetConnectionState.Online || next == NetConnectionState.Reconnecting || next == NetConnectionState.Disconnected, 
			NetConnectionState.Online => next == NetConnectionState.Degraded || next == NetConnectionState.Reconnecting || next == NetConnectionState.Closing || next == NetConnectionState.Disconnected, 
			NetConnectionState.Degraded => next == NetConnectionState.Online || next == NetConnectionState.Reconnecting || next == NetConnectionState.Closing || next == NetConnectionState.Disconnected, 
			NetConnectionState.Reconnecting => next == NetConnectionState.Authenticating || next == NetConnectionState.Online || next == NetConnectionState.Disconnected, 
			NetConnectionState.Closing => next == NetConnectionState.Disconnected, 
			NetConnectionState.Disconnected => next == NetConnectionState.Connecting || next == NetConnectionState.Reconnecting, 
			_ => false, 
		};
	}
}
