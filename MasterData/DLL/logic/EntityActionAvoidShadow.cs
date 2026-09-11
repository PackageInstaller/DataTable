using Entitas;

[Sim]
public class EntityActionAvoidShadow : IComponent, IComponentReset
{
	public Int3 EarliestPosition = Int3.zero;

	public bool Posted;

	public int leftTime;

	public void Reset(Entity entity)
	{
		EarliestPosition = Int3.zero;
		Posted = false;
	}
}
