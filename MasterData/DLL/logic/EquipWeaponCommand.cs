using System;
using Google.Protobuf;

public class EquipWeaponCommand : Command, IFramePooledObject
{
	public int mWeaponID;

	public int mEntityID;

	public override int Opcode => 0;

	public EquipWeaponCommand(int commandID, int entityID, int weaponID)
		: base(commandID)
	{
		mWeaponID = weaponID;
		mEntityID = entityID;
	}

	public override void ReleaseCommand()
	{
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
		throw new NotImplementedException();
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mEntityID);
		if (entityWithEntityID == null)
		{
			return false;
		}
		if (mWeaponID < 0)
		{
			return false;
		}
		mSimContext.PostEvent(new EntityEquipWeaponEvent(mEntityID, mWeaponID));
		entityWithEntityID.AddEntityActionWeaponEquip(EntityActionStatus.E_ACTIVE, mWeaponID, 500);
		return true;
	}

	public override void OnEnterPool()
	{
		mWeaponID = -1;
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
