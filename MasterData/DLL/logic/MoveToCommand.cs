using System;
using Google.Protobuf;

public class MoveToCommand : Command
{
	public int mTargetID;

	public Int3 mTargetPos;

	public int mForwardAngle;

	public override int Opcode => 141;

	public void SetData(int ownerID, int targetID, Int3 targetPos, int forwardAngle)
	{
		mOwner = ownerID;
		mTargetID = targetID;
		mTargetPos = targetPos;
		mForwardAngle = forwardAngle;
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mTargetID);
		return Move(entityWithEntityID);
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mTargetID);
		return Move(entityWithEntityID);
	}

	public bool Move(SimEntity simEntity)
	{
		if (simEntity == null)
		{
			return false;
		}
		if (!simEntity.hasEntityPositon)
		{
			return false;
		}
		Int3 forward = IntMath.VectorOfAngle(mForwardAngle);
		MovementProcessor.Teleport(simEntity, mTargetPos, forward);
		return true;
	}

	public override void ReleaseCommand()
	{
		mTargetID = 0;
		mTargetPos = Int3.zero;
		mForwardAngle = 0;
		FrameObjectPool<MoveToCommand>.Release(this);
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(mTargetID);
		writer.WriteInt32(mTargetPos.x);
		writer.WriteInt32(mTargetPos.y);
		writer.WriteInt32(mTargetPos.z);
		writer.WriteInt32(mForwardAngle);
	}

	protected override void OnRead(CodedInputStream reader)
	{
		mTargetID = reader.ReadInt32();
		mTargetPos = new Int3(reader.ReadInt32(), reader.ReadInt32(), reader.ReadInt32());
		mForwardAngle = reader.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}
}
