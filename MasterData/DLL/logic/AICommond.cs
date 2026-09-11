using System;
using System.Collections.Generic;
using Google.Protobuf;

public class AICommond : Command
{
	public AICommandType type;

	public override int Opcode => 115;

	public override void ReleaseCommand()
	{
		FrameObjectPool<AICommond>.Release(this);
	}

	public void SetData(int entityID, AICommandType type)
	{
		this.type = type;
	}

	public override bool RunCommand(long frameNum)
	{
		ChangeCommand(type);
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		ChangeCommand(type);
		return true;
	}

	public void ChangeCommand(AICommandType type)
	{
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mSimContext.sEntityWorldState.status.mRoomMembers.GetEnumerator();
		while (enumerator.MoveNext())
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityAIThink)
			{
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, (long)type, 0L, 0L);
			}
		}
	}

	protected override void OnRead(CodedInputStream reader)
	{
		type = (AICommandType)reader.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteInt32((int)type);
	}
}
