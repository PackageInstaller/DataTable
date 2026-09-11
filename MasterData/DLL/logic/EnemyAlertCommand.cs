using System;
using Google.Protobuf;

public class EnemyAlertCommand : Command
{
	public int enemyEntityID;

	public EnemyAlertState state;

	public override int Opcode => 139;

	public void SetData(int entityID, int enemyEntityID, EnemyAlertState state)
	{
		mOwner = entityID;
		this.enemyEntityID = enemyEntityID;
		this.state = state;
	}

	public EnemyAlertCommand()
	{
	}

	internal EnemyAlertCommand(int owner, int enemyEntityID, EnemyAlertState state)
		: base(owner)
	{
		this.enemyEntityID = enemyEntityID;
		this.state = state;
	}

	public override void ReleaseCommand()
	{
		FrameObjectPool<EnemyAlertCommand>.Release(this);
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
		enemyEntityID = 0;
		state = EnemyAlertState.None;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		enemyEntityID = reader.ReadInt32();
		state = (EnemyAlertState)reader.ReadEnum();
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32(enemyEntityID);
		writer.WriteEnum((int)state);
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null)
		{
			return false;
		}
		mSimContext.PostEvent(EnemyAlertEvent.Claim(enemyEntityID, mOwner, state));
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

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}
}
