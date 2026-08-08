using System.Collections.Generic;
using Pathfinding.RVO;

public class WorldState : SimPersistentState
{
	public ObstacleVertex mObstacleRoot;

	public List<ThrownFrameState> mThrownStateArray;

	public bool mIsGameOver;

	public int mChallengedNumber;

	public int mSourceSpaceKeepTime;

	public int mBreakEntityID;

	public int mWorldTimeScale;

	public int mCooperateUniqueSkillIsActive;

	public int mCooperateUniqueSkillEnergyValue;

	public int mCooperateUniqueSkillEnergyMaxValue;

	public int mCooperateUniqueSkillCD;

	public int mCooperateUniqueSkillMaxCD;

	public bool mCooperateUniqueSkillVaild;

	public uint mLogicTimerPauseFlag;

	public int mOfflineMember;

	public static SimPersistentState Claim()
	{
		return FrameObjectPool<WorldState>.Claim();
	}

	public override void OnEnterPool()
	{
		if (mThrownStateArray != null)
		{
			mThrownStateArray.Clear();
		}
	}

	public override void Release()
	{
		FrameObjectPool<WorldState>.Release(this);
	}
}
