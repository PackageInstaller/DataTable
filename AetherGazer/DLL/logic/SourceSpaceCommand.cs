using System;
using Config;
using Google.Protobuf;
using UnityEngine;

public class SourceSpaceCommand : Command
{
	public int mSourceSpaceDelayTime;

	public int mSourceSpaceKeepTime;

	public int mSourceSpaceExitTime;

	public int mSourceSpaceRaceID;

	public int mSourceSpaceTargetEntityID;

	public override int Opcode => 116;

	public override void ReleaseCommand()
	{
		FrameObjectPool<SourceSpaceCommand>.Release(this);
	}

	public SourceSpaceCommand()
	{
	}

	public SourceSpaceCommand(int entityID)
		: base(entityID)
	{
	}

	public override bool RunCommand(long frameNum)
	{
		return PrepareEnterSourceSpace(mSimContext, mSourceSpaceDelayTime, mSourceSpaceKeepTime, mSourceSpaceExitTime, mSourceSpaceRaceID, mSourceSpaceTargetEntityID);
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return true;
	}

	public void SetData(int entityID, int sourceSpaceKeepTime, int sourceSpaceDelayTime, int raceID, int targetEntityID)
	{
		mOwner = entityID;
		mSourceSpaceDelayTime = sourceSpaceDelayTime;
		mSourceSpaceKeepTime = sourceSpaceKeepTime;
		mSourceSpaceRaceID = raceID;
		mSourceSpaceTargetEntityID = targetEntityID;
	}

	protected override void OnRead(CodedInputStream stream)
	{
		mSourceSpaceDelayTime = stream.ReadInt32();
		mSourceSpaceKeepTime = stream.ReadInt32();
		mSourceSpaceRaceID = stream.ReadInt32();
		mSourceSpaceTargetEntityID = stream.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
		stream.WriteInt32(mSourceSpaceDelayTime);
		stream.WriteInt32(mSourceSpaceKeepTime);
		stream.WriteInt32(mSourceSpaceRaceID);
		stream.WriteInt32(mSourceSpaceTargetEntityID);
	}

	public override void OnEnterPool()
	{
		base.OnEnterPool();
	}

	public static bool PrepareEnterSourceSpace(SimContext pSimContext, int enterTime, int pKeepTime, int exitTime, int pRaceID, int pBrokenEntityID)
	{
		if (CommonProcessor.IsInSourceSpaceState())
		{
			Debug.LogError((object)"已经进入间层");
			return false;
		}
		if (!pSimContext.hasEntitySourceSpace)
		{
			pSimContext.SetEntitySourceSpace(newEnable: true, pKeepTime, int.MaxValue, int.MaxValue, pRaceID, 0, pBrokenEntityID, newManualMode: false);
			SimEntity entitySourceSpaceEntity = pSimContext.entitySourceSpaceEntity;
			entitySourceSpaceEntity.AddEntityPositon(new Int3(0, 0, 0), new Int3(0, 0, 1), 0, new Int3(0, 1, 0), newIsTeleport: false);
			entitySourceSpaceEntity.AddEntityCamp(256u);
			entitySourceSpaceEntity.AddEntityConfig(ConfigHelper.GetInstance().GetConfig<RoleConfig>(65535), 65535);
			entitySourceSpaceEntity.AddEntityRemotePlayer(0, 0, newMIsLocalPlayer: false);
			entitySourceSpaceEntity.AddEntityBlackboard(new SimBlackboard());
			EntityBlackboard entityBlackboard = entitySourceSpaceEntity.entityBlackboard;
			entityBlackboard.var.mHP = 2147483647L;
			entityBlackboard.var.mMaxHP = 2147483647L;
		}
		pSimContext.entitySourceSpaceEntity.entitySourceSpace.Enable = true;
		pSimContext.entitySourceSpaceEntity.entitySourceSpace.SourceSpaceDelayTime = enterTime;
		pSimContext.entitySourceSpaceEntity.entitySourceSpace.SourceSpaceKeepTime = pKeepTime;
		pSimContext.entitySourceSpaceEntity.entitySourceSpace.SourceSpaceExitTime = exitTime;
		pSimContext.entitySourceSpaceEntity.entitySourceSpace.SourceSpaceRaceID = pRaceID;
		pSimContext.entitySourceSpaceEntity.entitySourceSpace.BreakEntityID = pBrokenEntityID;
		pSimContext.PostEvent(SourceSpaceEvent.Claim(SourceSpaceEvent.E_SourceSpaceState.Prepare, pKeepTime, pRaceID, pBrokenEntityID));
		return true;
	}
}
