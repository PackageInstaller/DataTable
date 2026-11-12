public class AdventureWeaponEntity : LogicEntity
{
	protected override void OnInit()
	{
		AddOrGetMonoLogicComponent<DeterministicCollider>().ActiveSelf = true;
	}

	protected override void OnActive()
	{
	}

	protected override void OnDeactive()
	{
	}
}
