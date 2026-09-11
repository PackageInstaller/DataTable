using Google.Protobuf;

public class StartMeleeCommand : Command
{
	public int mAttackerID = -1;

	public Int3 mFireDirection = Int3.zero;

	public int mTargetID = -1;

	public bool mIsPressing;

	public bool mIsTarget;

	public override int Opcode => 111;

	public override void ReleaseCommand()
	{
		mAttackerID = -1;
		mFireDirection = Int3.zero;
		mTargetID = -1;
		mIsTarget = false;
		FrameObjectPool<StartMeleeCommand>.Release(this);
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityAIThink && mIsPressing)
		{
			if (!entityWithEntityID.hasEntityActionManualAIInput)
			{
				entityWithEntityID.AddEntityActionManualAIInput(EntityActionStatus.E_ACTIVE, mAttackerID, newMCanDestroy: true, mIsPressing);
			}
			else
			{
				entityWithEntityID.ReplaceEntityActionManualAIInput(EntityActionStatus.E_ACTIVE, mAttackerID, newMCanDestroy: true, mIsPressing);
			}
			return true;
		}
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2010, out var baseValue, out var _, out var _);
			if (baseValue > 0)
			{
				entityWithEntityID.entityBlackboard.var.ClearOnPressDownBtnID();
				return true;
			}
		}
		if (entityWithEntityID != null && mIsPressing)
		{
			if (entityWithEntityID.hasEntityActionManualInput)
			{
				entityWithEntityID.ReplaceEntityActionManualInput(EntityActionStatus.E_ACTIVE, mAttackerID, TimeHelper.Now(), newMCanDestroy: true, mIsPressing);
			}
			else
			{
				entityWithEntityID.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, mAttackerID, TimeHelper.Now(), newMCanDestroy: true, mIsPressing);
			}
		}
		if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility)
		{
			entityWithEntityID.entityActionAbility.mIsPressing = mIsPressing;
		}
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			if (mIsPressing)
			{
				entityWithEntityID.entityBlackboard.var.AddOnPressDownBtnID(mAttackerID);
			}
			else if (entityWithEntityID.entityBlackboard.var.IsOnPressDownBtnID(mAttackerID))
			{
				entityWithEntityID.entityBlackboard.var.RemoveOnPressDownBtnID(mAttackerID);
			}
		}
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (!entityWithEntityID.hasEntityRemotePlayer || !entityWithEntityID.entityRemotePlayer.mIsLocalPlayer)
		{
			return false;
		}
		SimEntity entityWithEntityID2 = mSimContext.GetEntityWithEntityID(entityWithEntityID.entityRemotePlayer.mLocalEntityID);
		if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID2.entityBlackboard.var.mAttributeID, 2010, out var baseValue, out var _, out var _);
			if (baseValue > 0)
			{
				entityWithEntityID2.entityBlackboard.var.ClearOnPressDownBtnID();
				return true;
			}
		}
		if (entityWithEntityID2 != null && mIsPressing)
		{
			if (entityWithEntityID2.hasEntityActionManualInput)
			{
				entityWithEntityID2.ReplaceEntityActionManualInput(EntityActionStatus.E_ACTIVE, mAttackerID, TimeHelper.Now(), newMCanDestroy: true, mIsPressing);
			}
			else
			{
				entityWithEntityID2.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, mAttackerID, TimeHelper.Now(), newMCanDestroy: true, mIsPressing);
			}
		}
		if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityActionAbility)
		{
			entityWithEntityID2.entityActionAbility.mIsPressing = mIsPressing;
		}
		return true;
	}

	public void SetData(int ownerID, int btnID)
	{
		mOwner = ownerID;
		mAttackerID = btnID;
	}

	public void SetData(int ownerID, int attackID, bool isPressing)
	{
		mOwner = ownerID;
		mAttackerID = attackID;
		mIsPressing = isPressing;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		mAttackerID = reader.ReadInt32();
		mIsPressing = reader.ReadBool();
	}

	protected override bool OnValidateAgainstFrame()
	{
		return true;
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(mAttackerID);
		writer.WriteBool(mIsPressing);
	}
}
