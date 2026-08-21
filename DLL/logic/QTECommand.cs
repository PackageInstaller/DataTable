using System;
using Google.Protobuf;

public class QTECommand : Command
{
	public QTEStatusType mStatus;

	public override int Opcode => 147;

	public override void ReleaseCommand()
	{
		FrameObjectPool<QTECommand>.Release(this);
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityQTE || entityWithEntityID.entityQTE.mStatus == mStatus)
		{
			return false;
		}
		if (mStatus != QTEStatusType.Success && mStatus != QTEStatusType.Failed)
		{
			return false;
		}
		entityWithEntityID.entityQTE.mStatus = mStatus;
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return true;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		mStatus = (QTEStatusType)reader.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteUInt32((uint)mStatus);
	}

	public void SetData(int ownerID, QTEStatusType mStatus)
	{
		mOwner = ownerID;
		this.mStatus = mStatus;
	}
}
