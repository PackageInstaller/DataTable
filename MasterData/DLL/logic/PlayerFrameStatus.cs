using System;

public struct PlayerFrameStatus(NetworkPlayerID playerID, SimFrameNumber mostRecentSimFrame) : IEquatable<PlayerFrameStatus>
{
	public NetworkPlayerID NetworkPlayerID = playerID;

	public SimFrameNumber MostRecentCommandSimFrame = mostRecentSimFrame;

	public bool Equals(PlayerFrameStatus other)
	{
		return this == other;
	}

	public override bool Equals(object obj)
	{
		if (obj is PlayerFrameStatus)
		{
			return this == (PlayerFrameStatus)obj;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return NetworkPlayerID.GetHashCode() ^ MostRecentCommandSimFrame.GetHashCode();
	}

	public static bool operator ==(PlayerFrameStatus x, PlayerFrameStatus y)
	{
		if (x.NetworkPlayerID == y.NetworkPlayerID)
		{
			return x.MostRecentCommandSimFrame == y.MostRecentCommandSimFrame;
		}
		return false;
	}

	public static bool operator !=(PlayerFrameStatus x, PlayerFrameStatus y)
	{
		return !(x == y);
	}
}
