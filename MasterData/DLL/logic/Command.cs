using Google.Protobuf;

public abstract class Command : IHasID, IFramePooledObject
{
	public int mOwner;

	public ID<Command> mCommandID;

	public static SimFrameNumber mMostRecentSimFrameWithCommands = SimFrameNumber.Invalid;

	public uint mFrameCount;

	protected SimContext mSimContext;

	public abstract int Opcode { get; }

	protected Command()
	{
		mOwner = 0;
		mCommandID = ID<Command>.None;
	}

	protected Command(int owner)
	{
		mOwner = owner;
		mCommandID = ID<Command>.Next();
	}

	protected void CreateID()
	{
		mCommandID = ID<Command>.Next();
	}

	public void SetOwner(int owner)
	{
		mOwner = owner;
	}

	public int GetChecksum()
	{
		return Checksum.Combine(mOwner, (int)mCommandID);
	}

	public bool Equals(Command command)
	{
		if (command != null && command.mCommandID == mCommandID)
		{
			if (mOwner == command.mOwner)
			{
				return Opcode == command.Opcode;
			}
			return false;
		}
		return false;
	}

	public void Read(CodedInputStream reader)
	{
		mOwner = reader.ReadInt32();
		mCommandID = (ID<Command>)reader.ReadInt32();
		mFrameCount = reader.ReadUInt32();
		OnRead(reader);
	}

	public void Write(CodedOutputStream writer)
	{
		writer.WriteInt32(Opcode);
		writer.WriteInt32(mOwner);
		writer.WriteInt32((int)mCommandID);
		writer.WriteUInt32(mFrameCount);
		OnWrite(writer);
	}

	public abstract void ReleaseCommand();

	protected abstract void OnRead(CodedInputStream reader);

	protected abstract void OnWrite(CodedOutputStream writer);

	protected abstract bool OnValidateAgainstFrame();

	public abstract bool RunCommand(long frameNum);

	public abstract bool RunPredictionCommand(long frameNum);

	internal void BindContext(SimContext simContext)
	{
		mSimContext = simContext;
	}

	public virtual void OnEnterPool()
	{
		mFrameCount = 0u;
		mSimContext = null;
		CreateID();
	}
}
