using System;
using Google.Protobuf;

public class ReloadGunCommand : Command, IFramePooledObject
{
	public int mEntityID;

	public Int3 mTargetPos;

	public override int Opcode => 0;

	public ReloadGunCommand()
	{
	}

	public ReloadGunCommand(int entityID, Int3 targetPos)
		: base(entityID)
	{
		mEntityID = entityID;
		mTargetPos = targetPos;
	}

	public override bool RunCommand(long frameNum)
	{
		mSimContext.PostEvent(new EntityMoveToEvent(mEntityID, mTargetPos));
		return false;
	}

	public override void ReleaseCommand()
	{
	}

	protected override void OnRead(CodedInputStream stream)
	{
		throw new NotImplementedException();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
		throw new NotImplementedException();
	}

	public override void OnEnterPool()
	{
		mEntityID = -1;
	}

	public void OnLeavePool()
	{
		CreateID();
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		throw new NotImplementedException();
	}
}
