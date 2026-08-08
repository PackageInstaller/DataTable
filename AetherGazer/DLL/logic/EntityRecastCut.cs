using Entitas;
using Pathfinding;

[Sim]
[IgnoreClone]
public class EntityRecastCut : IComponent
{
	public bool isEnable;

	public NavmeshCut cutParam;
}
