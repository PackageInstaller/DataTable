using Google.Protobuf;

public class PlayerOfflineCommand : Command
{
	public int offlineMember;

	public override int Opcode => 146;

	public override void ReleaseCommand()
	{
		offlineMember = 0;
		FrameObjectPool<PlayerOfflineCommand>.Release(this);
	}

	public PlayerOfflineCommand()
	{
	}

	public PlayerOfflineCommand(int offline)
	{
		offlineMember = offline;
	}

	public void SetData(int offline)
	{
		offlineMember = offline;
	}

	public void SetData(int entityID, int offline)
	{
		mOwner = entityID;
		offlineMember = offline;
	}

	public override bool RunCommand(long frameNum)
	{
		if (mSimContext.hasSEntityWorldState)
		{
			mSimContext.sEntityWorldState.status.m_sendOfflineMember = offlineMember;
			mSimContext.sEntityWorldState.status.m_sendOffline = true;
		}
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return true;
	}

	protected override bool OnValidateAgainstFrame()
	{
		return true;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		offlineMember = reader.ReadInt32();
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(offlineMember);
	}
}
