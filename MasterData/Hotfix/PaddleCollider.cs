using TrueSync;

public class PaddleCollider : LogicEntity
{
	public FP paddleLength;

	private TSVector2 offsetPos;

	public DeterministicCollider dtcollider { get; private set; }

	protected VisualSmooth Smooth { get; private set; }

	protected override void OnInit()
	{
		InitCollider();
		gameObject.layer = 22;
		Smooth = AddOrGetMonoLogicComponent<VisualSmooth>();
	}

	protected override void OnActive()
	{
		tsTransform.transformSyncEnabled = false;
		Singleton<BrickBreakerManager>.Instance.ChangePaddleCollider(this);
		if (paddleLength <= 0)
		{
			paddleLength = dtcollider.ColliderWidth;
		}
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
	}

	protected override void OnLogicUpdate()
	{
	}

	public TSVector2 GetOffsetPos(bool iLeft)
	{
		FP fP = paddleLength / 2;
		return new TSVector2(iLeft ? fP : (-fP), 0);
	}

	public FP GetRayCastColliderPointToLocalPercent(DeterministicRaycastHit dRaycastHit)
	{
		return (tsTransform.TransformWorldPointToLocalSpace(dRaycastHit.point).x + dtcollider.ColliderWidth / 2) / dtcollider.ColliderWidth;
	}
}
