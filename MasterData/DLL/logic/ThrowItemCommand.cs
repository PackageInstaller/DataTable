using System;
using Google.Protobuf;

public class ThrowItemCommand : Command
{
	public Int3 mPosition;

	public Int3 mForward;

	public int mTimelineID;

	public bool mUseCommon;

	public int mSpawnTimelineID;

	public override int Opcode => 119;

	public override void ReleaseCommand()
	{
		mPosition = Int3.zero;
		mForward = Int3.forward;
		mTimelineID = 0;
		mUseCommon = true;
		mSpawnTimelineID = 0;
		FrameObjectPool<ThrowItemCommand>.Release(this);
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null)
		{
			return false;
		}
		entityWithEntityID.entityBlackboard.var.mBeaconPosition = mPosition;
		entityWithEntityID.entityBlackboard.var.mBeaconForward = mForward;
		if (entityWithEntityID.hasEntityActionSubJoystick)
		{
			entityWithEntityID.RemoveEntityActionSubJoystick();
		}
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return false;
	}

	public void SetData(int entityID, Int3 position, Int3 forward, int timelineID, bool useCommon, int spawnTimelineID)
	{
		mOwner = entityID;
		mPosition = position;
		mForward = forward;
		mTimelineID = timelineID;
		mUseCommon = useCommon;
		mSpawnTimelineID = spawnTimelineID;
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
		stream.WriteInt32(mPosition.x);
		stream.WriteInt32(mPosition.y);
		stream.WriteInt32(mPosition.z);
		stream.WriteInt32(mForward.x);
		stream.WriteInt32(mForward.z);
		stream.WriteInt32(mTimelineID);
		stream.WriteBool(mUseCommon);
		stream.WriteInt32(mSpawnTimelineID);
	}

	protected override void OnRead(CodedInputStream stream)
	{
		mPosition = new Int3(stream.ReadInt32(), stream.ReadInt32(), stream.ReadInt32());
		mForward = new Int3(stream.ReadInt32(), 0, stream.ReadInt32());
		mTimelineID = stream.ReadInt32();
		mUseCommon = stream.ReadBool();
		mSpawnTimelineID = stream.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}
}
