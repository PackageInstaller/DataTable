using System.Collections.Generic;
using Entitas;
using Entitas.CodeGeneration.Attributes;

[Sim]
[Unique]
public class SimStateFrameBuffer : IComponent
{
	public delegate void FrameAdded(SimStateFrameBuffer manager, SimStateFrame newFrame);

	public int mCurrentFrameArrayIndex;

	public uint mLastAppliedFrame;

	private SimStateFrame[] mSavedStateFrames;

	private object mStateFrameManagerMutex = new object();

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

	public event FrameAdded NewFrame;

	internal void ApplyStateFrame(SimStateFrame newStateFrame)
	{
		lock (mStateFrameManagerMutex)
		{
			mCurrentFrameArrayIndex = (mCurrentFrameArrayIndex + 1) % mSavedStateFrames.Length;
			SimStateFrame simStateFrame = mSavedStateFrames[mCurrentFrameArrayIndex];
			if (simStateFrame != null && !simStateFrame.Released)
			{
				int num = ((simStateFrame.Events != null) ? simStateFrame.Events.Count : 0);
				XLogger.Assert(condition: false, string.Format("[YK] uh-oh, overwriting state from frame {0} that has not been released! dropped {} events!!!", simStateFrame.FrameNumber, num));
			}
			mSavedStateFrames[mCurrentFrameArrayIndex] = newStateFrame;
			mLastAppliedFrame = newStateFrame.FrameNumber;
		}
		if (NewFrame != null)
		{
			NewFrame(this, newStateFrame);
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

	internal void Initialize(int stateFrameSaveWindow, FrameAdded newFrameHandler = null)
	{
		mSavedStateFrames = new SimStateFrame[stateFrameSaveWindow];
		mCurrentFrameArrayIndex = 0;
		if (newFrameHandler != null)
		{
			NewFrame += newFrameHandler;
		}
	}

	internal SimStateFrame Reserve(uint frameNumber, IList<SimPersistentState> frameStates, List<NEventBase> eventsForFrame, Checksum frameChecksum)
	{
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
