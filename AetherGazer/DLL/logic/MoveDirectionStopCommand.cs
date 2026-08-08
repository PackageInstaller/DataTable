using System;
using Google.Protobuf;

public class MoveDirectionStopCommand : Command
{
	public override int Opcode => 110;

	public override void ReleaseCommand()
	{
		FrameObjectPool<MoveDirectionStopCommand>.Release(this);
	}

	public MoveDirectionStopCommand()
	{
	}

	public MoveDirectionStopCommand(int entityID, int moveDegree)
		: base(entityID)
	{
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		return DoStopAbility(entityWithEntityID);
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null)
		{
			return false;
		}
		if (!entityWithEntityID.hasEntityRemotePlayer || !entityWithEntityID.entityRemotePlayer.mIsLocalPlayer)
		{
			return false;
		}
		SimEntity entityWithEntityID2 = mSimContext.GetEntityWithEntityID(entityWithEntityID.entityRemotePlayer.mLocalEntityID);
		return DoStopAbility(entityWithEntityID2);
	}

	private bool DoStopAbility(SimEntity simEntity)
	{
		if (simEntity != null && simEntity.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2010, out var baseValue, out var _, out var _);
			if (baseValue > 0)
			{
				return true;
			}
		}
		return MovementProcessor.DoStopAbility(simEntity);
	}

	public void SetData(int entityID)
	{
		mOwner = entityID;
	}

	protected override void OnRead(CodedInputStream stream)
	{
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
	}
}
