namespace AIScript.BrickBreaker._16001;

public class Action : BrickActorAction
{
	private readonly int ImmuneCount = 1;

	private readonly string ballFx = "FX/BreakOut/fx_breakout_16001_loop_start_bubble_small";

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		Singleton<BrickBreakerManager>.Instance.SetSkillTips(iUse: true);
		Singleton<BrickBreakerManager>.Instance?.SetBornBallOutAreaImmune(ImmuneCount, ballFx);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}

	public override void OnStart()
	{
		base.OnStart();
	}

	public override void OnStop()
	{
		base.OnStop();
	}

	protected override bool SkillCheck()
	{
		return Singleton<BrickBreakerManager>.Instance.IsLaunched;
	}
}
