namespace Ase.ECS;

public class SummonedDestroyComponent : DestroyComponent
{
	public override void DoEntityDead(bool isKilled = false)
	{
		base.DoEntityDead(isKilled);
		mBaseEntity.GetComponent<StateComponent>().EnterDeadState();
	}
}
