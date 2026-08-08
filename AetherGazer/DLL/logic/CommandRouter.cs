using System;
using System.Collections.Generic;
using Entitas;

public class CommandRouter : ISystem
{
	public enum UpdateStatus
	{
		NetworkDisconnect,
		SyncError,
		PlayerDropSynchronizing,
		StalledOnInput,
		AbleToAdvance
	}

	private readonly object mLockObject = new object();

	private uint mCurrentSchedulingDelay = 1u;

	private GameMode mGameMode = GameMode.SinglePlayer;

	private uint mSinglePlayerFrameCount;

	private long mLastFrameTime;

	private long mLeft = 1000L;

	private ServerFrameSync mServerFrameSync;

	private ClientFrameSync mClientFrameSync;

	private Func<uint, SimResultType> mServerFrameCallback;

	private Func<uint, bool, SimResultType> mClientFrameCallback;

	public SimContext mSimContext;

	public bool IsInitialized { get; private set; }

	internal long CommandNetworkLatency => 1L;

	public CommandRouter(SimContext simContext)
	{
		mSimContext = simContext;
	}

	internal void Initialize(GameMode gameMode, Func<uint, SimResultType> serverFrameCallback, Func<uint, bool, SimResultType> clientFrameCallback)
	{
		lock (mLockObject)
		{
			mGameMode = gameMode;
			if (CommonProcessor.IsMultiplePlayerGameMode(gameMode))
			{
				mCurrentSchedulingDelay = 3u;
			}
			if (CommonProcessor.IsSinglePlayerGameMode(gameMode))
			{
				mCurrentSchedulingDelay = 1u;
			}
			mServerFrameCallback = serverFrameCallback;
			mClientFrameCallback = clientFrameCallback;
			if (CommonProcessor.IsMultiplePlayerGameMode(gameMode))
			{
				mServerFrameSync = new ServerFrameSync();
				mServerFrameSync.Init(UpdateServerLogic);
				mClientFrameSync = new ClientFrameSync();
				mClientFrameSync.Init(UpdateClientLogic);
			}
			IsInitialized = true;
		}
	}

	internal void SetServerFrame(uint serverFrame, int ping)
	{
		if (mServerFrameSync != null)
		{
			mServerFrameSync.Start(bRun: true);
			mServerFrameSync.SetServerFrame(serverFrame, ping);
		}
		if (mClientFrameSync != null)
		{
			mClientFrameSync.SetServerFrame(serverFrame, ping);
		}
	}

	internal void InputServerCommand(uint serverFrame, Command cmd)
	{
		cmd.BindContext(mSimContext);
		if (mServerFrameSync != null)
		{
			mServerFrameSync.PushFrameCommand(cmd, serverFrame);
		}
	}

	public UpdateStatus Tick()
	{
		if (CommonProcessor.IsMultiplePlayerGameMode(mGameMode) && !CommonProcessor.IsReplayGameMode(mGameMode))
		{
			if (mServerFrameSync != null)
			{
				mServerFrameSync.UpdateServerFrame();
			}
			if (mClientFrameSync != null)
			{
				mSimContext.simStatus.mIsRollback = false;
				mClientFrameSync.UpdateClientFrame();
			}
		}
		else if (CommonProcessor.IsSinglePlayerGameMode(mGameMode) || CommonProcessor.IsReplayGameMode(mGameMode))
		{
			uint num = 1u;
			long num2 = 0L;
			int num3 = 10 * ClientSimulator.Instance.mTimerIntervalMS;
			long num4 = TimeHelper.ClientNow();
			if (mLastFrameTime != 0L)
			{
				num2 = (num4 - mLastFrameTime) * 100 + mLeft;
				if (num2 > num3)
				{
					num2 = num3;
				}
				if (num2 < 0)
				{
					num2 = ClientSimulator.Instance.mTimerIntervalMS;
				}
				num = (uint)(num2 / ClientSimulator.Instance.mTimerIntervalMS);
			}
			while (num-- != 0 && ClientSimulator.Instance.SimTimeScale != 0)
			{
				mLastFrameTime = num4;
				mLeft = num2 % ClientSimulator.Instance.mTimerIntervalMS;
				UpdateServerLogic(++mSinglePlayerFrameCount);
			}
		}
		return UpdateStatus.AbleToAdvance;
	}

	public void UpdateLastFrameTimeOnPause()
	{
		mLastFrameTime = TimeHelper.ClientNow();
	}

	public void UpdateServerLogic(uint curSeverFrame)
	{
		if (mClientFrameSync != null)
		{
			mClientFrameSync.PopFrameCommand(curSeverFrame);
		}
		if (mServerFrameCallback != null)
		{
			mServerFrameCallback(curSeverFrame);
		}
		if (CommonProcessor.IsMultiplePlayerGameMode(mGameMode))
		{
			UpdateRollback(curSeverFrame);
		}
	}

	private void UpdateRollback(uint historyFrameNum)
	{
		List<SimEntity> list = FrameListPool<SimEntity>.Claim();
		HashSet<SimEntity>.Enumerator enumerator = mSimContext.GetGroup(SimMatcher.EntityLocalPlayer).GetEnumerator();
		while (enumerator.MoveNext())
		{
			list.Add(enumerator.Current);
		}
		for (int num = list.Count - 1; num >= 0; num--)
		{
			SimEntity simEntity = list[num];
			SimEntity simEntity2 = null;
			int mRemoteEntityID = simEntity.entityLocalPlayer.mRemoteEntityID;
			simEntity2 = mSimContext.GetEntityWithEntityID(mRemoteEntityID);
			int[] componentIndices = simEntity.GetComponentIndices();
			for (int i = 0; i < componentIndices.Length; i++)
			{
				if (componentIndices[i] != 41)
				{
					simEntity.RemoveComponent(componentIndices[i]);
				}
			}
			if (simEntity2 != null)
			{
				if (simEntity.hasEntityLocalPlayer)
				{
					simEntity.entityLocalPlayer.mNetID = 0;
					simEntity.entityLocalPlayer.mRemoteEntityID = simEntity2.creationIndex;
				}
				else
				{
					simEntity.AddEntityLocalPlayer(0, simEntity2.creationIndex);
				}
				componentIndices = simEntity2.GetComponentIndices();
				for (int j = 0; j < componentIndices.Length; j++)
				{
					if (componentIndices[j] != 52 && componentIndices[j] != 55 && componentIndices[j] != 41)
					{
						simEntity2.CloneTo(simEntity, componentIndices[j]);
					}
				}
				if (mClientFrameSync != null)
				{
					mSimContext.simStatus.mIsRollback = true;
					mClientFrameSync.Rollback(historyFrameNum);
				}
			}
		}
		FrameListPool<SimEntity>.Release(list);
	}

	private void UpdateClientLogic(uint currentFrame, bool isRollback)
	{
		if (mClientFrameCallback != null)
		{
			mClientFrameCallback(currentFrame, isRollback);
		}
	}

	public void Shutdown()
	{
	}

	internal uint GetClientCurrentFrame()
	{
		if (mClientFrameSync != null)
		{
			return mClientFrameSync.CurFrameNum;
		}
		return 0u;
	}

	internal void InputClientCommand(Command command)
	{
		if (mClientFrameSync != null)
		{
			mClientFrameSync.PushFrameCommand(command);
		}
	}
}
