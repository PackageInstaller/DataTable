using System;
using System.Collections.Generic;
using Google.Protobuf;

public class GroupMoveToCommand : Command
{
	public Int3 mMoveToPostion;

	public List<int> entityArray;

	public override int Opcode => 0;

	public override void ReleaseCommand()
	{
	}

	public override bool RunCommand(long frameNum)
	{
		entityArray = TransientLists.GetList<int>();
		return false;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		throw new NotImplementedException();
	}

	protected override void OnRead(CodedInputStream stream)
	{
	}

	protected override bool OnValidateAgainstFrame()
	{
		return true;
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
	}
}
