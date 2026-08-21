using System;
using Google.Protobuf;

public class ChangeRoleCommand : Command
{
	public int mRoleId;

	public int mAppear;

	public override int Opcode => 112;

	public override void ReleaseCommand()
	{
		FrameObjectPool<ChangeRoleCommand>.Release(this);
	}

	public ChangeRoleCommand()
	{
	}

	public ChangeRoleCommand(int entityID, int roleId)
		: base(entityID)
	{
		mRoleId = roleId;
	}

	public override bool RunCommand(long frameNum)
	{
		ChangeRole();
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		ChangeRole();
		return true;
	}

	public void ChangeRole()
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID != null && mRoleId != entityWithEntityID.entityConfig.mId)
		{
			entityWithEntityID.AddEntityActionTransfiguration(mRoleId, mAppear);
		}
	}

	public void SetData(int entityID, int roleID, int appear)
	{
		mOwner = entityID;
		mRoleId = roleID;
		mAppear = appear;
	}

	protected override void OnRead(CodedInputStream stream)
	{
		mRoleId = stream.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
		stream.WriteInt32(mRoleId);
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
		mRoleId = 0;
	}
}
