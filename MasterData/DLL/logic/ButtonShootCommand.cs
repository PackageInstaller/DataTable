using Google.Protobuf;

public class ButtonShootCommand : Command
{
	public int mTargetID;

	public override int Opcode => 142;

	public override void ReleaseCommand()
	{
		mTargetID = -1;
		FrameObjectPool<ButtonShootCommand>.Release(this);
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mTargetID);
		if (entityWithEntityID != null)
		{
			mSimContext.entitySourceSpaceEntity.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, 30, TimeHelper.Now(), newMCanDestroy: true, newMIsPressing: false);
			mSimContext.entitySourceSpaceEntity.entityBlackboard.var.mAimTarget = mTargetID;
			return true;
		}
		return false;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return true;
	}

	public void SetData(int targetID)
	{
		mTargetID = targetID;
	}

	public void SetData(int ownerID, int targetID)
	{
		mOwner = ownerID;
		mTargetID = targetID;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		mTargetID = reader.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		return true;
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(mTargetID);
	}
}
