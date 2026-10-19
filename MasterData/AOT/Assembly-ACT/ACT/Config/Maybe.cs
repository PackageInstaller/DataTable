using System;

namespace ACT.Config;

[Serializable]
public class Maybe
{
	public readonly int id;

	public readonly int count;

	public readonly int weight;

	public Maybe(int id, int count, int weight)
	{
		this.id = id;
		this.count = count;
		this.weight = weight;
	}
}
