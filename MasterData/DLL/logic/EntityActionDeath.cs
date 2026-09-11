using Entitas;

[Sim]
public class EntityActionDeath : IComponent
{
	public int mKiller = -1;

	public int mAbilityID = -1;

	public int mDeathDuring = 1000;
}
