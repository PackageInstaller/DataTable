using System;
using Google.Protobuf;

public class NoOpCommand : Command
{
	public override int Opcode
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public override void ReleaseCommand()
	{
	}

	public override bool RunCommand(long frameNum)
	{
		throw new NotImplementedException();
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		throw new NotImplementedException();
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
}
