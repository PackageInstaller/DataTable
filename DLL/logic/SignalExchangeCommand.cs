using Google.Protobuf;

public class SignalExchangeCommand : Command
{
	public int mSignalExchangeIndex;

	public override int Opcode => 143;

	public override void ReleaseCommand()
	{
		mSignalExchangeIndex = -1;
		FrameObjectPool<SignalExchangeCommand>.Release(this);
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityRemotePlayer || !entityWithEntityID.hasEntityBlackboard)
		{
			return false;
		}
		AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2192, mSignalExchangeIndex, 0L, 0L);
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return true;
	}

	public void SetData(int index)
	{
		mSignalExchangeIndex = index;
	}

	public void SetData(int entityID, int index)
	{
		mOwner = entityID;
		mSignalExchangeIndex = index;
	}

	protected override bool OnValidateAgainstFrame()
	{
		return true;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		mSignalExchangeIndex = reader.ReadInt32();
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(mSignalExchangeIndex);
	}
}
