using System;
using Google.Protobuf;

public class ChooseTargetCommand : Command
{
	public int lastTargetID;

	public int cameraAngle;

	public override int Opcode => 118;

	public void SetData(int owner, int lastTargetID, int cameraAngle)
	{
		mOwner = owner;
		this.lastTargetID = lastTargetID;
		this.cameraAngle = cameraAngle;
	}

	public override void ReleaseCommand()
	{
		FrameObjectPool<ChooseTargetCommand>.Release(this);
	}

	public override bool RunCommand(long frameNum)
	{
		SetTarget();
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityRemotePlayer || !entityWithEntityID.entityRemotePlayer.mIsLocalPlayer)
		{
			return false;
		}
		SetTarget(isPrediction: true);
		return true;
	}

	public void SetTarget(bool isPrediction = false)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null)
		{
			return;
		}
		if (isPrediction)
		{
			entityWithEntityID = mSimContext.GetEntityWithEntityID(entityWithEntityID.entityRemotePlayer.mLocalEntityID);
			if (entityWithEntityID == null)
			{
				return;
			}
		}
		if (cameraAngle == -2)
		{
			entityWithEntityID.entityBlackboard.var.lockType = (LockType)lastTargetID;
			return;
		}
		entityWithEntityID.entityBlackboard.var.mLastTarget = lastTargetID;
		if (cameraAngle == -1)
		{
			mSimContext.GetSimInterface().mChooseTargetEvent?.Invoke(entityWithEntityID.entityBlackboard.var.mAimTarget, lastTargetID);
			entityWithEntityID.entityBlackboard.var.mAimTarget = lastTargetID;
			entityWithEntityID.entityBlackboard.var.hasManualLock = true;
		}
		else
		{
			entityWithEntityID.entityBlackboard.var.hasManualLock = false;
			entityWithEntityID.entityBlackboard.var.mCameraAngle = cameraAngle;
		}
	}

	protected override void OnRead(CodedInputStream reader)
	{
		lastTargetID = reader.ReadInt32();
		cameraAngle = reader.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(lastTargetID);
		writer.WriteInt32(cameraAngle);
	}
}
