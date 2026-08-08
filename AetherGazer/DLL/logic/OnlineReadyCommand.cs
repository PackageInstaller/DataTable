using System;
using Google.Protobuf;

public class OnlineReadyCommand : Command
{
	public bool isReady;

	public override int Opcode => 144;

	public OnlineReadyCommand()
	{
	}

	public OnlineReadyCommand(bool Skip)
	{
		isReady = Skip;
	}

	public override void ReleaseCommand()
	{
		isReady = false;
		FrameObjectPool<OnlineReadyCommand>.Release(this);
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityRemotePlayer || !entityWithEntityID.hasEntityBlackboard)
		{
			return false;
		}
		int num = ((!isReady) ? 1 : 2);
		AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2193, num, 0L, 0L);
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return true;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		isReady = reader.ReadBool();
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteBool(isReady);
	}

	public void SetData(int Owner, bool Skip)
	{
		mOwner = Owner;
		isReady = Skip;
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
		isReady = false;
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}
}
