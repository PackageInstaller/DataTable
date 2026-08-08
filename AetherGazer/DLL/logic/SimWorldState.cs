using System.Collections.Generic;
using Config;

public class SimWorldState
{
	public long mLocalPlayerNetID;

	public int mLocalPlayerID;

	public Dictionary<MemberPosition, RemoteMember> mRoomMembers = new Dictionary<MemberPosition, RemoteMember>();

	public int mRoleID;

	public SceneMap mSceneMap;

	public List<GlobalAffix> mGlobalAffixes = new List<GlobalAffix>();

	public int mChallengeFactor = 1;

	public int mChallengedNumbe;

	public int mMissionClearTimes;

	public bool mBattleStart;

	public int mCurrentAliveHeroCount;

	public int mCurrentAliveMonsterCount;

	public List<int> mEnemys = new List<int>();

	public int mThrownCreationIndex = -1;

	public int mBuffCreationIndex = 1000;

	public List<ThrownState> mThrowns = new List<ThrownState>();

	public List<int> mDestoryThrowns = new List<int>();

	public bool mFreezeThrownLogic;

	public int m_InQTERoleCount;

	public Dictionary<int, List<ISimulatorInferface>> mTriggerScripts = new Dictionary<int, List<ISimulatorInferface>>();

	public List<int> mRunningTriggerScripts = new List<int>();

	internal AstarPath mMapGraph;

	public ProtoMapdata mMapTrigger;

	internal int SimTimeScale = 100;

	public Int3 centerPosition = Int3.zero;

	public Int currentEnemyHPAttributeFactor = 1000;

	public Int currentEnemyATKAttributeFactor = 1000;

	public Int currentEnemyDEFAttributeFactor = 1000;

	public int difficulty = 1;

	public int leftTimeAtStart;

	public int adaptiveEnemyLevel;

	public int targetEnemyType;

	public int commonWorldTimeScaleBaseValue = 100;

	public Dictionary<int, short> commonWorldTimeScaleFactor = new Dictionary<int, short>(new IntComparer());

	public int commonWorldTimeScaleValue = 100;

	public bool waitingResurrect;

	public bool needResurrect;

	public long coinNumber;

	public long coinConsume;

	public int resurrectTimes;

	public int resurrectHP;

	public long onlinemaxWaitingResurrectTime = 5000L;

	public Dictionary<int, List<int>> mHitHistory = new Dictionary<int, List<int>>(new IntComparer());

	public Dictionary<int, List<int>> mPredictionHitHistory = new Dictionary<int, List<int>>(new IntComparer());

	public Dictionary<int, List<int>> mEntityIDsInCurrentThrownRange = new Dictionary<int, List<int>>();

	public Dictionary<int, int> triggerIDToEntityID = new Dictionary<int, int>(new IntComparer());

	public Dictionary<int, List<int>> whoAttackRoles = new Dictionary<int, List<int>>(new IntComparer());

	public int m_CooperateUniqueSkillID;

	public int m_CooperateUniqueSkillLevel;

	public int m_cooperateUniqueSkillIsActive;

	public int m_cooperateUniqueSkillEnergyValue;

	public int m_cooperateUniqueSkillEnergyMaxValue;

	public int m_cooperateUniqueSkillCD;

	public int m_cooperateUniqueSkillMaxCD;

	public bool m_cooperateUniqueSkillVaild;

	public uint m_cooperateUniqueSkillDisableFlag;

	public int m_indexOfMaxCountRace;

	public int m_numOfMaxCountRace;

	public long mBattleID;

	public uint mLogicTimerPauseFlag;

	public List<int>[] m_tower_gacha_List;

	public bool m_sendOffline;

	public int m_sendOfflineMember;

	public bool m_hasOffline;

	public int m_offlineMember;

	public int mVHLResult;

	public List<int> mVHLSkill = new List<int>();

	public List<int> mButtonLockList = new List<int>();

	public int mMasterSkillEntityID;

	public Dictionary<int, long> attribute;

	[VarBinding(EntityVarName.WORLDSTATE_ALIVEMONSTER_COUNT, false, true, true, "存活怪物数量")]
	public int mExsitAliveEnemiesCount => mCurrentAliveMonsterCount;

	[VarBinding(EntityVarName.WORLDSTATE_ALIVEHERO_COUNT, false, true, true, "存活英雄数量")]
	public int mExsitAliveHerosCount => mCurrentAliveHeroCount;

	public void UpdateCommonWorldTimeScaleValue()
	{
		commonWorldTimeScaleValue = commonWorldTimeScaleBaseValue;
		Dictionary<int, short>.Enumerator enumerator = commonWorldTimeScaleFactor.GetEnumerator();
		while (enumerator.MoveNext())
		{
			commonWorldTimeScaleValue *= enumerator.Current.Value;
			commonWorldTimeScaleValue /= commonWorldTimeScaleBaseValue;
		}
	}

	public void RemoveHitHistory(int throwID)
	{
		if (mHitHistory.TryGetValue(throwID, out var value))
		{
			if (value != null)
			{
				FrameListPool<int>.Release(value);
				value = null;
			}
			mHitHistory.Remove(throwID);
		}
	}

	public void RemovePredictionHitHistory(int throwID)
	{
		if (mPredictionHitHistory.TryGetValue(throwID, out var value))
		{
			if (value != null)
			{
				FrameListPool<int>.Release(value);
				value = null;
			}
			mPredictionHitHistory.Remove(throwID);
		}
	}

	public bool TryGetHitHistroy(int throwID, out List<int> history)
	{
		return mHitHistory.TryGetValue(throwID, out history);
	}

	public bool TryGetPredictionHitHistroy(int throwID, out List<int> history)
	{
		return mPredictionHitHistory.TryGetValue(throwID, out history);
	}

	public bool HasHitHistoryTarget(int throwID, int hitTargetID)
	{
		if (mHitHistory.TryGetValue(throwID, out var value) && value != null)
		{
			List<int>.Enumerator enumerator = value.GetEnumerator();
			while (enumerator.MoveNext())
			{
				if (hitTargetID == enumerator.Current)
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool HasPredictionHitHistoryTarget(int throwID, int hitTargetID)
	{
		if (mPredictionHitHistory.TryGetValue(throwID, out var value) && value != null)
		{
			List<int>.Enumerator enumerator = value.GetEnumerator();
			while (enumerator.MoveNext())
			{
				if (hitTargetID == enumerator.Current)
				{
					return true;
				}
			}
		}
		return false;
	}

	public void AddHitHistory(int throwID, List<int> hitTargetID)
	{
		if (!mHitHistory.TryGetValue(throwID, out var value))
		{
			if (value == null)
			{
				value = FrameListPool<int>.Claim();
			}
			for (int i = 0; i < hitTargetID.Count; i++)
			{
				value.Add(hitTargetID[i]);
			}
			mHitHistory.Add(throwID, value);
			return;
		}
		for (int j = 0; j < hitTargetID.Count; j++)
		{
			if (!value.Contains(hitTargetID[j]))
			{
				value.Add(hitTargetID[j]);
			}
		}
	}

	public void AddPredictionHitHistory(int throwID, List<int> hitTargetID)
	{
		if (!mPredictionHitHistory.TryGetValue(throwID, out var value))
		{
			if (value == null)
			{
				value = FrameListPool<int>.Claim();
			}
			for (int i = 0; i < hitTargetID.Count; i++)
			{
				value.Add(hitTargetID[i]);
			}
			mPredictionHitHistory.Add(throwID, value);
			return;
		}
		for (int j = 0; j < hitTargetID.Count; j++)
		{
			if (!value.Contains(hitTargetID[j]))
			{
				value.Add(hitTargetID[j]);
			}
		}
	}

	public void AddEntityIDToEntityIDsInCurrentThrownRange(int throwID, int hitTargetID)
	{
		if (!mEntityIDsInCurrentThrownRange.TryGetValue(throwID, out var value))
		{
			if (value == null)
			{
				value = FrameListPool<int>.Claim();
			}
			mEntityIDsInCurrentThrownRange.Add(throwID, value);
		}
		value.Add(hitTargetID);
	}

	public bool EntityIDsInCurrentThrownRangeContainsEntityID(int throwID, int hitTargetID)
	{
		if (mEntityIDsInCurrentThrownRange.TryGetValue(throwID, out var value) && value != null)
		{
			return value.Contains(hitTargetID);
		}
		return false;
	}

	public bool RemoveEntityIDFromEntityIDsInCurrentThrownRange(int throwID, int hitTargetID)
	{
		if (mEntityIDsInCurrentThrownRange.TryGetValue(throwID, out var value) && value != null)
		{
			return value.Remove(hitTargetID);
		}
		return false;
	}

	public List<int> GetListFromEntityIDsInCurrentThrownRange(int throwID)
	{
		List<int> value = null;
		mEntityIDsInCurrentThrownRange.TryGetValue(throwID, out value);
		return value;
	}

	public void RemoveThrowIDFromEntityIDsInCurrentThrownRange(SimContext context, int throwID, int timelineID)
	{
		if (!mEntityIDsInCurrentThrownRange.TryGetValue(throwID, out var value))
		{
			return;
		}
		if (value != null)
		{
			for (int i = 0; i < value.Count; i++)
			{
				context.PostEvent(ThrownOverlapEvent.Claim(throwID, value[i], timelineID, 0, 0, -1, ThrownOverlapEventState.leave));
			}
			FrameListPool<int>.Release(value);
			value = null;
		}
		mEntityIDsInCurrentThrownRange.Remove(throwID);
	}

	public void SetLogicTimerPauseFlag(bool isPause, LogicTimerPauseReason reason)
	{
		if (isPause)
		{
			mLogicTimerPauseFlag |= (uint)reason;
		}
		else
		{
			mLogicTimerPauseFlag &= (uint)(~reason);
		}
	}

	public void InitTowerGachaList(int count)
	{
		m_tower_gacha_List = new List<int>[count];
		for (int i = 0; i < count; i++)
		{
			m_tower_gacha_List[i] = new List<int>();
		}
	}
}
