using System;
using Google.Protobuf;

public class ResurrectCommand : Command
{
	public bool result;

	public int targetEntityID;

	public override int Opcode => 122;

	public override void ReleaseCommand()
	{
		FrameObjectPool<ResurrectCommand>.Release(this);
	}

	public ResurrectCommand()
	{
	}

	public ResurrectCommand(int entityID, int targetEntityID, bool result)
	{
		this.result = result;
		this.targetEntityID = targetEntityID;
	}

	public void SetData(int entityID, int targetEntityID, bool result)
	{
		mOwner = entityID;
		this.result = result;
		this.targetEntityID = targetEntityID;
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
		result = false;
		targetEntityID = 0;
	}

	public override bool RunCommand(long frameNum)
	{
		SimWorldState status = mSimContext.sEntityWorldState.status;
		ResurrectEventState state = ResurrectEventState.resurrect;
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(targetEntityID);
		if (entityWithEntityID == null)
		{
			return false;
		}
		bool flag = result;
		if (result && mOwner == status.mLocalPlayerID)
		{
			if (status.coinNumber >= status.coinConsume)
			{
				status.coinNumber -= status.coinConsume;
				status.resurrectTimes++;
			}
			else
			{
				flag = false;
			}
		}
		if (flag)
		{
			entityWithEntityID.entityBlackboard.var.sendDeathEvent = false;
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2191, 0L, 0L, 0L);
		}
		else
		{
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2190, 0L, 0L, 0L);
			if (entityWithEntityID.hasEntityActionAbility)
			{
				entityWithEntityID.entityActionAbility.mAbilitySpeed = 100;
			}
			state = ResurrectEventState.giveup;
		}
		mSimContext.PostEvent(SimResurrectEvent.Claim(targetEntityID, status.coinNumber, status.coinConsume, status.resurrectTimes, state));
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null)
		{
			return false;
		}
		return true;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		targetEntityID = reader.ReadInt32();
		result = reader.ReadBool();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(targetEntityID);
		writer.WriteBool(result);
	}
}
