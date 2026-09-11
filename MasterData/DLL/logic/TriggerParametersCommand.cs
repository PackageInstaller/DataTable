using Google.Protobuf;

public class TriggerParametersCommand : Command
{
	public int triggerID;

	public int param1;

	public int param2;

	public int param3;

	public int param4;

	public override int Opcode => 140;

	public override void ReleaseCommand()
	{
		triggerID = 0;
		param1 = 0;
		param2 = 0;
		param3 = 0;
		param4 = 0;
		FrameObjectPool<TriggerParametersCommand>.Release(this);
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
		triggerID = 0;
		param1 = 0;
		param2 = 0;
		param3 = 0;
		param4 = 0;
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerID);
		if (simEntityByTriggerID == null)
		{
			return false;
		}
		mSimContext.PostEvent(TriggerParametersEvent.Claim(triggerID, param1, param2, param3, param4));
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return true;
	}

	public void SetData(int ownerID, int triggerID, int param1, int param2, int param3, int param4)
	{
		mOwner = ownerID;
		this.triggerID = triggerID;
		this.param1 = param1;
		this.param2 = param2;
		this.param3 = param3;
		this.param4 = param4;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		triggerID = reader.ReadInt32();
		param1 = reader.ReadInt32();
		param2 = reader.ReadInt32();
		param3 = reader.ReadInt32();
		param4 = reader.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		return true;
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(triggerID);
		writer.WriteInt32(param1);
		writer.WriteInt32(param2);
		writer.WriteInt32(param3);
		writer.WriteInt32(param4);
	}
}
