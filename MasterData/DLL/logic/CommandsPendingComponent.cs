using System.Collections.Generic;
using Entitas;
using Entitas.CodeGeneration.Attributes;
using Pathfinding.Util;

[Unique]
[Sim]
public class CommandsPendingComponent : IComponent
{
	private readonly object mCommandMutex = new object();

	private Dictionary<long, List<Command>> mCommandBuffer;

	public string mEmpty;

	public void AddCommand(Command cmd, long atFrame)
	{
		lock (mCommandMutex)
		{
			if (mCommandBuffer == null)
			{
				mCommandBuffer = new Dictionary<long, List<Command>>();
			}
			if (!mCommandBuffer.TryGetValue(atFrame, out var value))
			{
				value = ListPool<Command>.Claim();
				mCommandBuffer.Add(atFrame, value);
			}
			value.Add(cmd);
		}
	}

	public List<Command> GetCommand(long frameNumber)
	{
		List<Command> value = null;
		lock (mCommandMutex)
		{
			if (mCommandBuffer != null && mCommandBuffer.TryGetValue(frameNumber, out value))
			{
				mCommandBuffer.Remove(frameNumber);
			}
		}
		return value;
	}
}
