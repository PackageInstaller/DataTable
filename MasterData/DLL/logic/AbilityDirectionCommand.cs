using Google.Protobuf;

public class AbilityDirectionCommand : Command
{
	public Int3 mDirection;

	public int mMoveDegree;

	public override int Opcode => 117;

	public AbilityDirectionCommand()
	{
	}

	public AbilityDirectionCommand(int entityID, Int3 direction)
		: base(entityID)
	{
		mDirection = direction;
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null)
		{
			return false;
		}
		ProcessAbilityDirection(entityWithEntityID);
		return true;
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
		if (entityWithEntityID2 == null)
		{
			return false;
		}
		ProcessAbilityDirection(entityWithEntityID);
		return true;
	}

	private void ProcessAbilityDirection(SimEntity simEntity)
	{
		if (simEntity != null)
		{
			mDirection = IntMath.VectorOfAngle(mMoveDegree);
			if (!simEntity.hasEntityActionAbilityDirection)
			{
				simEntity.AddEntityActionAbilityDirection(EntityActionStatus.E_ACTIVE, mDirection);
			}
			else
			{
				simEntity.ReplaceEntityActionAbilityDirection(EntityActionStatus.E_ACTIVE, mDirection);
			}
		}
	}

	public override void ReleaseCommand()
	{
		FrameObjectPool<AbilityDirectionCommand>.Release(this);
	}

	public void SetData(int entityID, int moveDegree)
	{
		mOwner = entityID;
		mMoveDegree = moveDegree;
	}

	protected override void OnRead(CodedInputStream stream)
	{
		mMoveDegree = stream.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		return true;
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
		stream.WriteInt32(mMoveDegree);
	}
}
