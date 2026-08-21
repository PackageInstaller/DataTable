namespace Ase.ECS;

public class FillStage : BaseStage
{
	protected override void ChangeStage(WarningIndicatorStageSwitcher switcher)
	{
		base.ChangeStage(switcher);
		switcher.ChangeStage<DelayLifeTimeStage>(timerData.delayLifeTimer);
	}

	protected override void StageOver()
	{
	}
}
