using System;
using System.Collections.Generic;

namespace ACT.Battle;

[Serializable]
public class AICommandData
{
	public string command;

	private static readonly Stack<AICommandData> pool = new Stack<AICommandData>(32);

	private const int MaxPoolSize = 256;

	public static AICommandData Get(string cmd)
	{
		AICommandData aICommandData;
		lock (pool)
		{
			aICommandData = ((pool.Count > 0) ? pool.Pop() : new AICommandData());
		}
		aICommandData.command = cmd;
		return aICommandData;
	}

	public void Release()
	{
		command = string.Empty;
		lock (pool)
		{
			if (pool.Count < 256)
			{
				pool.Push(this);
			}
		}
	}
}
