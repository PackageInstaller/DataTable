using System;
using Google.Protobuf;

public class GameStopCommand : Command
{
	public E_BattleResult mResult;

	public override int Opcode => 113;

	public override void ReleaseCommand()
	{
		FrameObjectPool<GameStopCommand>.Release(this);
	}

	public GameStopCommand()
	{
	}

	public GameStopCommand(int entityID, E_BattleResult reason)
		: base(entityID)
	{
		mResult = reason;
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null)
		{
			return false;
		}
		if (!mSimContext.hasSEntityGameOver)
		{
			mSimContext.SetSEntityGameOver(GameOverState.start, 0, 100, mResult);
			ClientSimulator.Instance.SimTimeScale = 100;
		}
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

	public void SetData(int entityID, E_BattleResult reason)
	{
		mOwner = entityID;
		mResult = reason;
	}

	protected override void OnRead(CodedInputStream stream)
	{
		mResult = (E_BattleResult)stream.ReadEnum();
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
		stream.WriteEnum((int)mResult);
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
		mResult = E_BattleResult.None;
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}
}
