using System.Collections.Generic;
using UnityEngine;

public class AICommandSet : AICommand
{
	public int mCurrent;

	public List<AICommand> mCommands;

	private int jumpStep;

	public override void OnEnter(SimContext simContext, SimEntity entity)
	{
		mCurrent = 0;
		for (int i = 0; i < mCommands.Count; i++)
		{
			mCommands[i].Reset();
		}
	}

	public override void OnExit(SimContext simContext, SimEntity entity)
	{
		if (mCurrent < 0 || mCurrent >= mCommands.Count)
		{
			Debug.LogError((object)(entity.ENTITY_CONFIG_ID.ToString() + " " + mID + " " + mCurrent));
		}
		if (mCommands[mCurrent].mStatus == AIProcessor.AICommandStatus.Running)
		{
			mCommands[mCurrent].Exit(simContext, entity);
		}
	}

	public void JumpStep(int step)
	{
		if (mStatus != AIProcessor.AICommandStatus.Running)
		{
			Debug.LogError((object)$"指令集{mID}合不在运行，当前状态{mStatus}，不要尝试调整");
			return;
		}
		mCommands[mCurrent].mStatus = AIProcessor.AICommandStatus.Success;
		mCommands[mCurrent].mForceInterruptSelf = true;
		jumpStep = step;
	}

	public override AIProcessor.AICommandStatus Running(SimContext simContext, SimEntity entity)
	{
		if (mStatus == AIProcessor.AICommandStatus.Failed || mStatus == AIProcessor.AICommandStatus.Success)
		{
			return mStatus;
		}
		AICommand aICommand = mCommands[mCurrent];
		AIProcessor.AICommandStatus aICommandStatus = aICommand.Run(simContext, entity);
		if (aICommandStatus == AIProcessor.AICommandStatus.Success || aICommandStatus == AIProcessor.AICommandStatus.Failed)
		{
			aICommand.Exit(simContext, entity);
			if (!aICommand.mForceInterruptSelf)
			{
				mCurrent++;
			}
			else
			{
				mCurrent = jumpStep;
				jumpStep = 0;
			}
			aICommand.Reset();
		}
		AIProcessor.AICommandStatus aICommandStatus2 = mStatus;
		if (mCurrent >= mCommands.Count)
		{
			mCurrent = mCommands.Count - 1;
			mStatus = AIProcessor.AICommandStatus.Success;
		}
		else if (aICommandStatus == AIProcessor.AICommandStatus.Failed)
		{
			mStatus = AIProcessor.AICommandStatus.Failed;
		}
		else
		{
			mStatus = AIProcessor.AICommandStatus.Running;
		}
		if (mForceInterruptSelf)
		{
			mStatus = aICommandStatus2;
			return mStatus;
		}
		return mStatus;
	}

	internal override void Reset()
	{
		base.Reset();
		mCurrent = 0;
		for (int i = 0; i < mCommands.Count; i++)
		{
			mCommands[i].Reset();
		}
		jumpStep = 0;
	}
}
