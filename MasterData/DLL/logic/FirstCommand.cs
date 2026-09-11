using System;
using Google.Protobuf;

public class FirstCommand : Command
{
	public int mClientTime;

	public int mCameraViewDistance;

	public override int Opcode => 0;

	public override void ReleaseCommand()
	{
		FrameObjectPool<FirstCommand>.Release(this);
	}

	public FirstCommand()
	{
	}

	public FirstCommand(int entityID, int cameraDegree, int cameraViewDistance)
		: base(entityID)
	{
		mClientTime = cameraDegree;
		mCameraViewDistance = cameraViewDistance;
	}

	public override bool RunCommand(long frameNum)
	{
		return false;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return false;
	}

	public void SetData(int entityID, int cameraDegree, int cameraViewDistance)
	{
		mOwner = entityID;
		mClientTime = cameraDegree;
		mCameraViewDistance = cameraViewDistance;
	}

	protected override void OnRead(CodedInputStream stream)
	{
		mClientTime = stream.ReadInt32();
		mCameraViewDistance = stream.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
		stream.WriteInt32(mClientTime);
		stream.WriteInt32(mCameraViewDistance);
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
	}
}
