using System;

namespace ACT.MultiPlayer;

public struct MPMissionState(bool mReady, bool mFinished, int mId, int mSubMissionId) : IEquatable<MPMissionState>
{
	public bool ready = mReady;

	public bool finished = mFinished;

	public int id = mId;

	public int subMissionId = mSubMissionId;

	public bool Equals(MPMissionState other)
	{
		if (id == other.id && ready == other.ready && finished == other.finished)
		{
			return subMissionId == other.subMissionId;
		}
		return false;
	}
}
