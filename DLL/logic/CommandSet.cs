using System.Collections.Generic;

internal class CommandSet
{
	public SimFrameNumber mFrameNum;

	public SortedList<CommandType, Command> mCommands = new SortedList<CommandType, Command>();

	public CommandSet()
	{
		mCommands.Clear();
	}

	public CommandSet(SimFrameNumber frameNum)
	{
		mFrameNum = frameNum;
		mCommands.Clear();
	}

	public void Add(Command cmd)
	{
	}

	public void Remove(Command cmd)
	{
	}

	public void Update(Command cmd)
	{
	}

	public SortedList<CommandType, Command> Get()
	{
		return mCommands;
	}
}
