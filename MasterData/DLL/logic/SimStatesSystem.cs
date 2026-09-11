using System;
using System.Collections.Generic;
using Entitas;

public class SimStatesSystem : IExecuteSystem, ISystem
{
	private int mCurrentFrameArrayIndex;

	private uint mLastAppliedFrame;

	private SimStateFrame[] mSavedStateFrames;

	private object mStateFrameManagerMutex = new object();

	private List<SimPersistentState> mTransientEndOfFrameStateCollectionList = new List<SimPersistentState>();

	public int ringWindowSize = 32;

	private SimContext mSimContext;

	public bool CanApplyNewFrame
	{
		get
		{
			lock (mStateFrameManagerMutex)
			{
				int num = (mCurrentFrameArrayIndex + 1) % mSavedStateFrames.Length;
				return mSavedStateFrames[num]?.Released ?? true;
			}
		}
	}

	public uint MostRecentFrame
	{
		get
		{
			lock (mStateFrameManagerMutex)
			{
				return mLastAppliedFrame;
			}
		}
	}

	public event Action<SimStateFrame> NewFrame;

	public SimStatesSystem(SimContext sim)
	{
		mSimContext = sim;
		mSavedStateFrames = new SimStateFrame[ringWindowSize];
	}

	public void Execute()
	{
		uint mServerFrame = mSimContext.simStatus.mServerFrame;
		Checksum mMostRecentChecksum = mSimContext.simStatus.mMostRecentChecksum;
		SimStateFrame simStateFrame = SimStateFrame.Claim();
		simStateFrame.Checksum = mMostRecentChecksum;
		simStateFrame.FrameNumber = mServerFrame;
		mTransientEndOfFrameStateCollectionList.Clear();
		WorldState worldState = WorldState.Claim() as WorldState;
		simStateFrame.AllEntityStates.Add(worldState);
		SEntityWorldState sEntityWorldState = mSimContext.sEntityWorldState;
		UnitStatesSampler.SampleServerEntity(mSimContext, simStateFrame);
		if (sEntityWorldState.status.mThrowns.Count > 0)
		{
			if (worldState.mThrownStateArray == null)
			{
				worldState.mThrownStateArray = new List<ThrownFrameState>(sEntityWorldState.status.mThrowns.Count);
			}
			else
			{
				worldState.mThrownStateArray.Clear();
			}
		}
		List<ThrownState>.Enumerator enumerator = sEntityWorldState.status.mThrowns.GetEnumerator();
		while (enumerator.MoveNext())
		{
			ThrownFrameState item = new ThrownFrameState
			{
				mCreationIndex = enumerator.Current.mCreationIndex,
				mAbilityID = enumerator.Current.mAbilityID,
				mCurFrame = (uint)(enumerator.Current.mLogicTime / CommonProcessor.GetConfigInterval()),
				mHitIndex = enumerator.Current.mHitIndex,
				mCasterID = enumerator.Current.mCasterID,
				mProducerID = enumerator.Current.mProducerID,
				mProduceTimelineID = enumerator.Current.mProduceTimelineID,
				mProduceIndexOfTimeline = enumerator.Current.mProduceIndexOfTimeline,
				mLastPosition = enumerator.Current.mLastPosition,
				mPosition = enumerator.Current.mPosition,
				mForward = enumerator.Current.mForward,
				mTargetID = enumerator.Current.mTargetID,
				mCurLockIndex = enumerator.Current.mCurLockIndex,
				mIsInLock = enumerator.Current.mIsInLock,
				mTargetPosition = enumerator.Current.mTargetPosition,
				mFrameFreezeTime = (sEntityWorldState.status.mFreezeThrownLogic ? int.MaxValue : enumerator.Current.mFrameFreezeTime),
				mRuntime = (uint)enumerator.Current.mLogicTime,
				mStep = enumerator.Current.mTimeStep,
				mCanBeParry = enumerator.Current.mCanBeParry
			};
			worldState.mThrownStateArray.Add(item);
		}
		worldState.mSourceSpaceKeepTime = mSimContext.entitySourceSpace.SourceSpaceKeepTime;
		worldState.mBreakEntityID = mSimContext.entitySourceSpace.BreakEntityID;
		worldState.mWorldTimeScale = ClientSimulator.Instance.SimTimeScale * sEntityWorldState.status.commonWorldTimeScaleValue / sEntityWorldState.status.commonWorldTimeScaleBaseValue;
		worldState.mIsGameOver = mSimContext.hasSEntityGameOver;
		worldState.mChallengedNumber = sEntityWorldState.status.mChallengedNumbe;
		worldState.mCooperateUniqueSkillIsActive = sEntityWorldState.status.m_cooperateUniqueSkillIsActive;
		worldState.mCooperateUniqueSkillEnergyValue = sEntityWorldState.status.m_cooperateUniqueSkillEnergyValue;
		worldState.mCooperateUniqueSkillEnergyMaxValue = sEntityWorldState.status.m_cooperateUniqueSkillEnergyMaxValue;
		worldState.mCooperateUniqueSkillCD = sEntityWorldState.status.m_cooperateUniqueSkillCD;
		worldState.mCooperateUniqueSkillMaxCD = sEntityWorldState.status.m_cooperateUniqueSkillMaxCD;
		worldState.mCooperateUniqueSkillVaild = sEntityWorldState.status.m_cooperateUniqueSkillVaild;
		worldState.mLogicTimerPauseFlag = sEntityWorldState.status.mLogicTimerPauseFlag;
		worldState.mOfflineMember = (sEntityWorldState.status.m_hasOffline ? sEntityWorldState.status.m_offlineMember : 0);
		sEntityWorldState.status.m_hasOffline = false;
		List<NEventBase> bufferedEvents = mSimContext.SimToPresentationEventSystem.GetBufferedEvents();
		simStateFrame.Events = bufferedEvents;
		mTransientEndOfFrameStateCollectionList.Clear();
		ApplyStateFrame(simStateFrame);
	}

	internal void ApplyStateFrame(SimStateFrame newStateFrame)
	{
		if (mSavedStateFrames == null || mSavedStateFrames.Length == 0)
		{
			XLogger.Warn("GamePlay:", "没有帧状态输出！, 写点逻辑输出点状态吧");
			return;
		}
		lock (mStateFrameManagerMutex)
		{
			mCurrentFrameArrayIndex = (mCurrentFrameArrayIndex + 1) % mSavedStateFrames.Length;
			SimStateFrame simStateFrame = mSavedStateFrames[mCurrentFrameArrayIndex];
			if (simStateFrame != null && !simStateFrame.Released)
			{
				int num = ((simStateFrame.Events != null) ? simStateFrame.Events.Count : 0);
			}
			if (simStateFrame != null && simStateFrame.Released)
			{
				simStateFrame.Release();
				mSimContext.SimToPresentationEventSystem.ReleaseBufferedEvents(simStateFrame.Events);
				simStateFrame.Events = null;
			}
			mSavedStateFrames[mCurrentFrameArrayIndex] = newStateFrame;
			mLastAppliedFrame = newStateFrame.FrameNumber;
		}
		if (NewFrame != null)
		{
			NewFrame(newStateFrame);
		}
	}

	public SimStateFrame GetStateForFrame(uint atFrameNumber)
	{
		lock (mStateFrameManagerMutex)
		{
			int num = mSavedStateFrames.Length;
			for (int i = 0; i < num; i++)
			{
				SimStateFrame simStateFrame = mSavedStateFrames[i];
				if (simStateFrame != null && simStateFrame.FrameNumber == atFrameNumber)
				{
					return simStateFrame;
				}
			}
		}
		return null;
	}

	internal SimStateFrame GetStateForMostRecentFrame()
	{
		lock (mStateFrameManagerMutex)
		{
			return mSavedStateFrames[mCurrentFrameArrayIndex];
		}
	}

	internal void Initialize(int stateFrameSaveWindow, Action<SimStateFrame> newFrameHandler = null)
	{
		mSavedStateFrames = new SimStateFrame[stateFrameSaveWindow];
		mCurrentFrameArrayIndex = 0;
		if (newFrameHandler != null)
		{
			NewFrame += newFrameHandler;
		}
	}

	public void Release(SimStateFrame frame)
	{
		if (frame != null)
		{
			frame.Released = true;
		}
	}

	internal SimStateFrame Reserve(uint frameNumber, IList<SimPersistentState> frameStates, List<NEventBase> eventsForFrame, Checksum frameChecksum)
	{
		return new SimStateFrame(frameNumber, frameStates, eventsForFrame, frameChecksum);
	}

	public void Shutdown()
	{
		mSavedStateFrames = null;
		NewFrame = null;
		mCurrentFrameArrayIndex = 0;
	}
}
