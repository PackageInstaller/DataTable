using System;
using System.Collections.Generic;
using Entitas;

public class SimPredictionStatesSystem : IExecuteSystem, ISystem
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

	public SimPredictionStatesSystem(SimContext sim)
	{
		mSimContext = sim;
		mSavedStateFrames = new SimStateFrame[ringWindowSize];
	}

	public void Execute()
	{
		if (!mSimContext.simStatus.mIsRollback)
		{
			uint mClientPredictionFrame = mSimContext.simStatus.mClientPredictionFrame;
			Checksum mMostRecentChecksum = mSimContext.simStatus.mMostRecentChecksum;
			SimStateFrame simStateFrame = SimStateFrame.Claim();
			simStateFrame.Checksum = mMostRecentChecksum;
			simStateFrame.FrameNumber = mClientPredictionFrame;
			UnitStatesSampler.SampleLocalEntity(mSimContext, simStateFrame);
			List<NEventBase> bufferedEvents = mSimContext.SimToPresentationEventSystem.GetBufferedEvents();
			simStateFrame.Events = bufferedEvents;
			simStateFrame.IsPrediction = true;
			mTransientEndOfFrameStateCollectionList.Clear();
			ApplyStateFrame(simStateFrame);
		}
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
				XLogger.Assert(condition: false, string.Format("[YK] uh-oh, SimPredictionStatesSystem overwriting state from frame {0} that has not been released! dropped {2} events!!!({1})", simStateFrame.FrameNumber, mSavedStateFrames.Length, num));
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
				if (simStateFrame.FrameNumber == atFrameNumber)
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
		if (eventsForFrame != null && eventsForFrame.Count > 0)
		{
			string text = "";
			for (int i = 0; i < eventsForFrame.Count; i++)
			{
				text = text + eventsForFrame[i].GetType()?.ToString() + "  ";
			}
			XLogger.Debug(eventsForFrame.Count + " events ready!" + text);
		}
		return new SimStateFrame(frameNumber, frameStates, eventsForFrame, frameChecksum)
		{
			Released = false
		};
	}

	public void Shutdown()
	{
		mSavedStateFrames = null;
		NewFrame = null;
		mCurrentFrameArrayIndex = 0;
	}
}
