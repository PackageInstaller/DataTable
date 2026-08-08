using System;
using UnityEngine;
using XServer.Util;

public class ServerFrameSync
{
	public int maxEndBlockWaitNum;

	private bool isRunning;

	private int curPkgDelay;

	public int nDriftFactor = 4;

	public uint svrFrameDelta = 33u;

	public uint frameDelta = 33u;

	private uint KeyFrameRate = 1u;

	public uint svrFrameLater;

	public int tryCount;

	private uint backstepFrameCounter;

	private uint lastFrameCount;

	private uint endBlockWaitNum;

	public int maxExcuteFrameOnce;

	public uint newCommandId;

	private bool _bActive;

	private byte frameSpeed = 1;

	private NetPipeline<Command> commandQueue;

	private Action<uint> mTickHandler;

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

	public uint EndFrameNum { get; private set; }

	public uint CurFrameNum { get; private set; }

	public long StartFrameTime { get; private set; }

	public void ResetStartTime()
	{
	}

	public void Init(Action<uint> callback)
	{
		bActive = true;
		isRunning = false;
		frameDelta = svrFrameDelta / KeyFrameRate;
		CurFrameNum = 0u;
		EndFrameNum = 0u;
		endBlockWaitNum = 0u;
		frameSpeed = 1;
		curPkgDelay = 0;
		commandQueue = new NetPipeline<Command>();
		newCommandId = 0u;
		StartFrameTime = 0L;
		backstepFrameCounter = 0u;
		mTickHandler = callback;
	}

	public void Start(bool bRun)
	{
		isRunning = bRun;
	}

	public bool SetServerFrame(uint svrNum, int ping)
	{
		EndFrameNum = svrNum;
		if (ping != 0)
		{
			curPkgDelay = ping;
		}
		CalcBackstepTimeSinceStart(svrNum);
		return true;
	}

	public void PushFrameCommand(Command command, uint serverFrame)
	{
		if (command != null)
		{
			if (command.mFrameCount < serverFrame)
			{
				command.mFrameCount = serverFrame;
			}
			_ = command.mFrameCount;
			if (commandQueue.Count > 0 && lastFrameCount > command.mFrameCount)
			{
				command.mFrameCount = lastFrameCount;
			}
			commandQueue.Enqueue(command);
			lastFrameCount = command.mFrameCount;
		}
	}

	public void CalcBackstepTimeSinceStart(uint inSvrNum)
	{
		if (backstepFrameCounter != inSvrNum)
		{
			long num = inSvrNum * svrFrameDelta;
			StartFrameTime = TimeHelper.Now() - num - curPkgDelay - svrFrameLater;
			backstepFrameCounter = inSvrNum;
		}
	}

	public void UpdateServerFrame()
	{
		if (!isRunning)
		{
			return;
		}
		int a = (int)(EndFrameNum - CurFrameNum);
		tryCount = IntMath.Clamp(a, 0, 15);
		int num = tryCount;
		long num2 = (TimeHelper.Now() - StartFrameTime) * frameSpeed;
		int num3 = 0;
		while (num > 0)
		{
			long num4 = (long)CurFrameNum * (long)frameDelta;
			nMultiFrameDelta = num2 - num4;
			if (nMultiFrameDelta <= frameDelta + curPkgDelay)
			{
				break;
			}
			if (CurFrameNum >= EndFrameNum)
			{
				endBlockWaitNum++;
				maxEndBlockWaitNum = IntMath.Max(maxEndBlockWaitNum, (int)endBlockWaitNum);
				break;
			}
			endBlockWaitNum = 0u;
			CurFrameNum++;
			num3++;
			isCmdExecuting = true;
			while (commandQueue.Count > 0)
			{
				Command obj = commandQueue.Peek();
				uint mFrameCount = obj.mFrameCount;
				if (mFrameCount > CurFrameNum)
				{
					break;
				}
				if (mFrameCount < CurFrameNum)
				{
					Debug.LogError((object)("server lag frame:" + mFrameCount + " curFrame: " + CurFrameNum + " => " + EndFrameNum + " net delay: " + curPkgDelay + "," + curPkgDelay));
				}
				if (commandQueue.TryDequeue(out obj))
				{
					obj.RunCommand(mFrameCount);
					obj.ReleaseCommand();
				}
			}
			isCmdExecuting = false;
			UpdateLogic();
			num--;
		}
		maxExcuteFrameOnce = IntMath.Max(maxExcuteFrameOnce, num3);
	}

	public void ResetSynchr()
	{
		bActive = false;
		isRunning = true;
		frameDelta = 33u;
		CurFrameNum = 0u;
		EndFrameNum = 0u;
		endBlockWaitNum = 0u;
		svrFrameDelta = frameDelta;
		svrFrameLater = 0u;
		KeyFrameRate = 1u;
		frameSpeed = 1;
		curPkgDelay = 0;
		backstepFrameCounter = 0u;
		commandQueue = new NetPipeline<Command>();
		maxEndBlockWaitNum = 0;
		maxExcuteFrameOnce = 0;
	}

	private void UpdateLogic()
	{
		if (mTickHandler != null)
		{
			mTickHandler(CurFrameNum);
		}
	}
}
