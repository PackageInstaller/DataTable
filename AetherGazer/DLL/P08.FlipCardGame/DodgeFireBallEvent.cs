public class DodgeFireBallEvent
{
	public float startTime;

	public float warningEndTime;

	public DodgeFireBallGameStep.FireBallDropEventConfig fireBallDropEventConfig;

	public DodgeFireBallGameStep config;

	public bool isInvoked;

	public DodgeFireBallEvent(DodgeFireBallGameStep.FireBallDropEventConfig fireBallDropEventConfig, DodgeFireBallGameStep config)
	{
		this.fireBallDropEventConfig = fireBallDropEventConfig;
		this.config = config;
		isInvoked = false;
	}

	public void UpdateTime(float startTime)
	{
		this.startTime = startTime;
		warningEndTime = startTime + config.warningDurationTime;
	}
}
