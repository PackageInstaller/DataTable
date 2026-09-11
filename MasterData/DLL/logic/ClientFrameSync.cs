using System;
using UnityEngine;
using XServer.Util;

public class ClientFrameSync
{
	public int maxEndBlockWaitNum;

	public int jitterDelay;

	private bool isRunning;

	private int curPkgDelay;

	public int nDriftFactor = 4;

	public uint svrFrameDelta = 33u;

	public uint frameDelta = 33u;

	private uint KeyFrameRate = 1u;

	public int tryCount;

	private uint mCurrentServerFrame;

	public int maxExcuteFrameOnce;

	public uint newCommandId;

	public long mClientStartTime;

	private bool _bActive;

	private byte frameSpeed = 1;

	private uint SvrFrameIndex;

	private NetPipeline<Command> mCommandQueue;

	private Action<uint, bool> mTickHandler;

	public bool bActive
	{
		get
		{
			return _bActive;
		}
		set
		{
			if (_bActive != value)
			{
				_bActive = value;
			}
		}
	}

	public byte FrameSpeed
	{
		get
		{
			return frameSpeed;
		}
		set
		{
			frameSpeed = (byte)IntMath.Clamp(value, 1, 8);
			if (_bActive)
			{
				ResetStartTime();
			}
		}
	}

	public bool isCmdExecuting { get; private set; }

	public long nMultiFrameDelta { get; private set; }

	public uint CurFrameNum { get; private set; }

	public long mClientFrameTime { get; private set; }

	public long mServerFrameTime { get; private set; }

	public uint SvrLogicFrameNum => SvrFrameIndex;

	public void ResetStartTime()
	{
	}

	public void Init(Action<uint, bool> callback)
	{
		bActive = true;
		isRunning = false;
		SvrFrameIndex = 0u;
		frameDelta = svrFrameDelta / KeyFrameRate;
		CurFrameNum = 0u;
		frameSpeed = 1;
		curPkgDelay = 0;
		jitterDelay = 0;
		mCommandQueue = new NetPipeline<Command>();
		newCommandId = 0u;
		mClientFrameTime = 0L;
		mCurrentServerFrame = 0u;
		mTickHandler = callback;
	}

	public void Start(bool bRun)
	{
		isRunning = bRun;
	}

	public bool SetServerFrame(uint svrNum, int ping)
	{
		SvrFrameIndex = svrNum;
		if (ping != 0)
		{
			curPkgDelay = ping;
		}
		CalcBackstepTimeSinceStart(svrNum);
		return true;
	}

	public void CalcBackstepTimeSinceStart(uint inSvrNum)
	{
		if (mCurrentServerFrame == inSvrNum)
		{
			return;
		}
		if (!isRunning || mCurrentServerFrame <= inSvrNum)
		{
			if (inSvrNum - mCurrentServerFrame >= 2)
			{
				Debug.LogError((object)$"服务器发生跳帧！！！！{inSvrNum - mCurrentServerFrame}");
			}
			isRunning = true;
		}
		mCurrentServerFrame = inSvrNum;
		mClientStartTime = TimeHelper.Now() - inSvrNum * svrFrameDelta - curPkgDelay * 2 - 33;
	}

	public void PushFrameCommand(Command command)
	{
		mCommandQueue.Enqueue(command);
	}

	public void Rollback(uint frameNum)
	{
		if (frameNum != CurFrameNum)
		{
			CurFrameNum = frameNum;
			UpdateClientFrame(isRollback: true);
		}
	}

	public void PopFrameCommand(uint serverFrame)
	{
		Command obj = null;
		while (mCommandQueue.Count > 0 && mCommandQueue.Peek().mFrameCount <= serverFrame && mCommandQueue.Peek().mFrameCount != 0)
		{
			mCommandQueue.TryDequeue(out obj);
			obj.ReleaseCommand();
		}
	}

	public void UpdateClientFrame(bool isRollback = false)
	{
		if (!isRunning)
		{
			return;
		}
		if (!isRollback)
		{
			mClientFrameTime = TimeHelper.Now() - mClientStartTime;
		}
		long clientFrameNum = mClientFrameTime / frameDelta;
		long num = clientFrameNum - CurFrameNum;
		num = ((num > 15) ? 15 : num);
		if (num > 0 && !isRollback)
		{
			mCommandQueue.ProcessCommand(CurFrameNum, delegate(uint curFrameNum, Command frameCommand)
			{
				if (frameCommand.mFrameCount == 0)
				{
					ClientSimulator.Instance.SendNetCommand(frameCommand, (uint)clientFrameNum);
				}
			});
		}
		while (num > 0)
		{
			CurFrameNum++;
			isCmdExecuting = true;
			mCommandQueue.ProcessCommand(CurFrameNum, delegate(uint curFrameNum, Command frameCommand)
			{
				if (frameCommand.mFrameCount == curFrameNum)
				{
					frameCommand.RunPredictionCommand(curFrameNum);
				}
			});
			isCmdExecuting = false;
			UpdateClientLogic((int)frameDelta, isRollback);
			num--;
		}
	}

	public void ResetSynchr()
	{
		bActive = false;
		isRunning = true;
		frameDelta = 33u;
		CurFrameNum = 0u;
		svrFrameDelta = frameDelta;
		SvrFrameIndex = 0u;
		KeyFrameRate = 1u;
		frameSpeed = 1;
		curPkgDelay = 0;
		mCurrentServerFrame = 0u;
		mCommandQueue = new NetPipeline<Command>();
		maxEndBlockWaitNum = 0;
		maxExcuteFrameOnce = 0;
	}

	private void UpdateClientLogic(int nDelta, bool isRollback)
	{
		if (mTickHandler != null)
		{
			mTickHandler(CurFrameNum, isRollback);
		}
	}
}
