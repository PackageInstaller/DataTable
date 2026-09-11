using System.Collections.Generic;
using Entitas;
using Pathfinding.Util;

public class CommandSystem : IExecuteSystem, ISystem, IInitializeSystem
{
	private SimContext mContext;

	public CommandSystem(Contexts context)
	{
		mContext = context.sim;
	}

	public void Initialize()
	{
	}

	public void Execute()
	{
		ProcessCommandOnFrame(mContext.simStatus.mServerFrame, ref mContext.simStatus.expectedChecksum);
	}

	public void ProcessCommandOnFrame(long frameNum, ref Checksum expectedChecksum)
	{
		List<Command> command = mContext.commandsPending.GetCommand(frameNum);
		if (command != null && command.Count > 0)
		{
			List<Command>.Enumerator enumerator = command.GetEnumerator();
			while (enumerator.MoveNext())
			{
				enumerator.Current.RunCommand(frameNum);
			}
		}
		if (command != null)
		{
			for (int i = 0; i < command.Count; i++)
			{
				command[i].ReleaseCommand();
			}
			ListPool<Command>.Release(command);
		}
	}
}
