using System;

public struct SimResult : IEquatable<SimResult>
{
	public static readonly SimResult None;

	public SimResultType TickResult;

	public PlayerFrameStatus[] MostRecentRemotePlayerFrames;

	public SimFrameNumber CurrentSimFrame;

	public SimFrameNumber ScheduleHorizon;

	public SimResult(SimResultType type, PlayerFrameStatus[] playerStatuses, SimFrameNumber currentSimFrame, SimFrameNumber scheduleHorizon)
	{
		TickResult = type;
		if (playerStatuses != null)
		{
			MostRecentRemotePlayerFrames = new PlayerFrameStatus[playerStatuses.Length];
			Array.Copy(playerStatuses, MostRecentRemotePlayerFrames, playerStatuses.Length);
		}
		else
		{
			MostRecentRemotePlayerFrames = null;
		}
		CurrentSimFrame = currentSimFrame;
		ScheduleHorizon = scheduleHorizon;
	}

	public bool Equals(SimResult other)
	{
		return this == other;
	}

	public override bool Equals(object obj)
	{
		if (obj is SimResult)
		{
			return this == (SimResult)obj;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (int)((uint)TickResult ^ (uint)CurrentSimFrame.GetHashCode()) ^ ScheduleHorizon.GetHashCode();
	}

	public static bool operator ==(SimResult x, SimResult y)
	{
		bool flag = true;
		if (x.MostRecentRemotePlayerFrames.Length != y.MostRecentRemotePlayerFrames.Length)
		{
			flag = false;
		}
		else
		{
			for (int i = 0; i < x.MostRecentRemotePlayerFrames.Length; i++)
			{
				if (x.MostRecentRemotePlayerFrames[i] != y.MostRecentRemotePlayerFrames[i])
				{
					flag = false;
					break;
				}
			}
		}
		if (flag && x.TickResult == y.TickResult && x.ScheduleHorizon == y.ScheduleHorizon)
		{
			return x.CurrentSimFrame == y.CurrentSimFrame;
		}
		return false;
	}

	public static bool operator !=(SimResult x, SimResult y)
	{
		return !(x == y);
	}

	static SimResult()
	{
		None = new SimResult(SimResultType.NoTick, null, SimFrameNumber.Invalid, SimFrameNumber.Invalid);
	}
}
