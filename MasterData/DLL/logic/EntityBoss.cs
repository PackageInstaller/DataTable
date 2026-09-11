using System.Collections.Generic;
using Entitas;

[Sim]
[IgnoreClone]
public class EntityBoss : IComponent
{
	public int deltaValueEveryTime;

	public int reductionTime;

	public int reductionPercent;

	public int attackTime;

	public int currentTime;

	public Dictionary<int, int> value;
}
