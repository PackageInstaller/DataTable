public class PaddleCollider_Ch : LogicEntity
{
	public DeterministicCollider dtcollider { get; private set; }

	protected override void OnInit()
	{
		InitCollider();
		gameObject.layer = 22;
	}

	protected override void OnActive()
	{
		tsTransform.transformSyncEnabled = false;
	}

	protected override void OnDeactive()
	{
		tsTransform.transformSyncEnabled = true;
	}

	protected override void OnShutdown()
	{
		base.OnShutdown();
	}

	private void InitCollider()
	{
		if (dtcollider == null)
		{
			dtcollider = AddOrGetMonoLogicComponent<DeterministicCollider>();
		}
		else
		{
			AddLogicComponent(dtcollider);
		}
		dtcollider.collisionListener = Singleton<BrickBreakerManager>.Instance.Paddle;
	}

	protected override void OnLogicUpdate()
	{
	}
}
