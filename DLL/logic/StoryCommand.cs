using System;
using Google.Protobuf;

public class StoryCommand : Command
{
	public StoryType storyType;

	public bool enterState;

	public int param;

	public override int Opcode => 121;

	public override void ReleaseCommand()
	{
		FrameObjectPool<StoryCommand>.Release(this);
	}

	public override bool RunCommand(long frameNum)
	{
		if (enterState)
		{
			mSimContext.GetSimInterface().mOnEnterStory?.Invoke(mOwner, storyType, param);
		}
		else
		{
			mSimContext.GetSimInterface().mOnExitStory?.Invoke(mOwner, storyType, param);
		}
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return true;
	}

	protected override void OnRead(CodedInputStream reader)
	{
		storyType = (StoryType)reader.ReadUInt32();
		enterState = reader.ReadBool();
		param = reader.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	protected override void OnWrite(CodedOutputStream writer)
	{
		writer.WriteUInt32((uint)storyType);
		writer.WriteBool(enterState);
		writer.WriteInt32(param);
	}
}
