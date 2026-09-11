using System.Collections.Generic;
using Entitas;

[Sim]
public class EntityResistance : IComponent
{
	public int maxValue;

	public int curValue;

	public uint maxTime;

	public uint curTime;

	public bool reState;

	public int reStateEle;

	public int enterReason;

	public int exitReason;

	public List<int> element;
}
