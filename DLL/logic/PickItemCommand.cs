using System;
using Google.Protobuf;

public class PickItemCommand : Command
{
	public override int Opcode
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public PickItemCommand(int entityID, Int3 itemPos)
		: base(entityID)
	{
	}

	public override void ReleaseCommand()
	{
	}

	protected override void OnRead(CodedInputStream stream)
	{
		throw new NotImplementedException();
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
		throw new NotImplementedException();
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		throw new NotImplementedException();
	}
}
