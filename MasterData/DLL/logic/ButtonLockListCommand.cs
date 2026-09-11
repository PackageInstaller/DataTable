using System.Collections.Generic;
using Google.Protobuf;

public class ButtonLockListCommand : Command
{
	public List<int> mTargetID;

	public override int Opcode => 148;

	public override void ReleaseCommand()
	{
		mTargetID = null;
		FrameObjectPool<ButtonLockListCommand>.Release(this);
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID != null)
		{
			if (!entityWithEntityID.hasEntityActionManualInput)
			{
				entityWithEntityID.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, 30, TimeHelper.Now(), newMCanDestroy: true, newMIsPressing: false);
			}
			else
			{
				entityWithEntityID.ReplaceEntityActionManualInput(EntityActionStatus.E_ACTIVE, 30, TimeHelper.Now(), newMCanDestroy: true, newMIsPressing: false);
			}
			mSimContext.sEntityWorldState.status.mButtonLockList.Clear();
			mSimContext.sEntityWorldState.status.mButtonLockList.AddRange(mTargetID);
			return true;
		}
		return false;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return true;
	}

	public void SetData(List<int> targetID)
	{
		mTargetID = targetID;
	}

	public void SetData(int ownerID, List<int> targetID)
	{
		mOwner = ownerID;
		mTargetID = targetID;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		int num = reader.ReadInt32();
		mTargetID = new List<int>();
		for (int i = 0; i < num; i++)
		{
			mTargetID.Add(reader.ReadInt32());
		}
	}

	protected override bool OnValidateAgainstFrame()
	{
		return true;
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(mTargetID.Count);
		for (int i = 0; i < mTargetID.Count; i++)
		{
			writer.WriteInt32(mTargetID[i]);
		}
	}
}
