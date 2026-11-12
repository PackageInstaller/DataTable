public class GearBase : LogicEntity
{
	protected DeterministicCollider dtCollider;

	public bool IsBaked { get; set; }

	protected override void OnInit()
	{
		dtCollider = AddOrGetMonoLogicComponent<DeterministicCollider>();
	}

	protected override void OnActive()
	{
	}

	protected override void OnDeactive()
	{
		if (IsBaked)
		{
			Singleton<BrickBreakerManager>.Instance.UnregisterBakedGear(this);
		}
		else
		{
			Singleton<BrickBreakerManager>.Instance.Despawn(this);
		}
	}

	protected override void OnShutdown()
	{
	}
}
