using Google.Protobuf;

public class ChangeTriggerStateCommand : Command
{
	public int triggerID;

	public int targetTriggerID;

	public bool enable;

	public override int Opcode => 114;

	public override void ReleaseCommand()
	{
		triggerID = 0;
		targetTriggerID = 0;
		enable = false;
		FrameObjectPool<ChangeTriggerStateCommand>.Release(this);
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
		triggerID = 0;
		targetTriggerID = 0;
		enable = false;
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(targetTriggerID);
		if (simEntityByTriggerID == null)
		{
			return false;
		}
		if (simEntityByTriggerID.entityTrigger.mEnabled == enable)
		{
			return true;
		}
		simEntityByTriggerID.entityTrigger.mEnabled = enable;
		mSimContext.PostEvent(TriggerEnableEvent.Claim(targetTriggerID, enable));
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return true;
	}

	public void SetData(int ownerID, int triggerID, int targetTriggerID, bool enable)
	{
		mOwner = ownerID;
		this.triggerID = triggerID;
		this.targetTriggerID = targetTriggerID;
		this.enable = enable;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		triggerID = reader.ReadInt32();
		targetTriggerID = reader.ReadInt32();
		enable = reader.ReadBool();
	}

	protected override bool OnValidateAgainstFrame()
	{
		return true;
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(triggerID);
		writer.WriteInt32(targetTriggerID);
		writer.WriteBool(enable);
	}
}
