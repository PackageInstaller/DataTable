public class Portal_TractionRange : LogicEntity
{
	private Portal_End _owner;

	public DeterministicCollider dtCollider { get; private set; }

	public void InitData(Portal_End owner)
	{
		_owner = owner;
	}

	protected override void OnInit()
	{
		dtCollider = AddOrGetMonoLogicComponent<DeterministicCollider>();
	}

	protected override void OnActive()
	{
		if (_owner != null)
		{
			dtCollider.collisionListener = _owner;
		}
	}

	protected override void OnDeactive()
	{
	}

	protected override void OnShutdown()
	{
	}
}
