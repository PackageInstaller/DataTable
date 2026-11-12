using TrueSync;

public class Brick_BallSkin : LogicEntity
{
	public BrickBallType ballType;

	public int skinHitId;

	public bool skinIsHittedEffectScale;

	public FP skinDamageImmuneDuration;

	public bool resetToNormal = true;

	public HitBox hitBox;

	protected override void OnInit()
	{
		if (hitBox == null)
		{
			hitBox = transform.GetComponent<HitBox>();
		}
	}

	protected override void OnActive()
	{
	}

	protected override void OnDeactive()
	{
	}

	protected override void OnShutdown()
	{
		base.OnShutdown();
	}
}
