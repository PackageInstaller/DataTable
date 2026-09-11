using System;
using Google.Protobuf;

public class MoveDirectionCommand : Command
{
	public Int3 mLookatDirection;

	public Int3 mMovementDirection;

	public int Angle;

	public EMoveDirectionMode mMode;

	public int mJoysickOffset;

	public override int Opcode => 109;

	public void ReadAngle(SimEntity simEntity)
	{
		switch (mMode)
		{
		case EMoveDirectionMode.Lookat:
			mLookatDirection = IntMath.VectorOfAngle(Angle);
			break;
		case EMoveDirectionMode.CustomMovementGlobal:
		case EMoveDirectionMode.CustomMovementLocal:
			mLookatDirection = simEntity.entityPositon.mForward;
			if (mJoysickOffset == 0)
			{
				mMovementDirection = Int3.zero;
			}
			else
			{
				mMovementDirection = IntMath.VectorOfAngle(Angle);
			}
			break;
		case EMoveDirectionMode.Pov:
			mLookatDirection = IntMath.VectorOfAngle(Angle);
			mMovementDirection = IntMath.VectorOfAngle(mJoysickOffset);
			break;
		}
	}

	public override void ReleaseCommand()
	{
		FrameObjectPool<MoveDirectionCommand>.Release(this);
	}

	public MoveDirectionCommand()
	{
	}

	public MoveDirectionCommand(int entityID, int moveDegree)
		: base(entityID)
	{
		Angle = moveDegree;
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null)
		{
			return false;
		}
		Move(entityWithEntityID);
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
		Move(entityWithEntityID2);
		return true;
	}

	public bool Move(SimEntity simEntity)
	{
		ReadAngle(simEntity);
		if (simEntity != null && simEntity.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2010, out var baseValue, out var _, out var _);
			if (baseValue > 0)
			{
				return true;
			}
		}
		if (simEntity != null)
		{
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2181, out var baseValue2, out var plusValue2, out var tempPlusValue2);
			if (baseValue2 >= 1)
			{
				mLookatDirection = Int3.zero - mLookatDirection;
			}
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2016, out var baseValue3, out plusValue2, out tempPlusValue2);
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2021, out var baseValue4, out plusValue2, out tempPlusValue2);
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2022, out var baseValue5, out plusValue2, out tempPlusValue2);
			if (baseValue3 > 0 || baseValue4 > 0 || baseValue5 > 0)
			{
				return false;
			}
			if (simEntity.hasEntityActionMelee)
			{
				return false;
			}
			if (simEntity.HasComponent(16))
			{
				simEntity.entityActionMoveDirection.mLastDirection = simEntity.entityActionMoveDirection.mDirection;
				simEntity.entityActionMoveDirection.mDirection = mLookatDirection;
				simEntity.entityActionMoveDirection.mMovementDirection = mMovementDirection;
				simEntity.entityActionMoveDirection.mMoveMode = mMode;
				simEntity.entityActionMoveDirection.mStatus = MovementProcessor.EnableMovement(simEntity, !simEntity.entityBlackboard.var.mActionBusy);
			}
			else if (simEntity.entityBlackboard.var.mActionBusy)
			{
				simEntity.AddEntityActionMoveDirection(MovementProcessor.EnableMovement(simEntity, !simEntity.entityBlackboard.var.mActionBusy), mLookatDirection, Int3.zero, newMIsTurn: false, 0, Int3.zero, 0, 0, mMovementDirection, mMode);
			}
			else
			{
				simEntity.AddEntityActionMoveDirection(EntityActionStatus.E_ACTIVE, mLookatDirection, Int3.zero, newMIsTurn: false, 0, Int3.zero, 0, 0, mMovementDirection, mMode);
			}
		}
		return true;
	}

	public void SetData(int entityID, int moveDegree, EMoveDirectionMode mode, int speed = 0)
	{
		mOwner = entityID;
		Angle = moveDegree;
		mJoysickOffset = speed;
		mMode = mode;
	}

	protected override void OnRead(CodedInputStream stream)
	{
		int num = stream.ReadInt32();
		Angle = num >> 12;
		mJoysickOffset = (num & 0xFFF0) >> 2;
		mMode = (EMoveDirectionMode)(num & 3);
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
		int num = Angle << 12;
		int num2 = mJoysickOffset << 2;
		int num3 = (int)(mMode & EMoveDirectionMode.Pov);
		num3 = num | num2 | num3;
		stream.WriteInt32(num3);
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
		Angle = 0;
		mMode = EMoveDirectionMode.Lookat;
		mLookatDirection = Int3.zero;
	}
}
