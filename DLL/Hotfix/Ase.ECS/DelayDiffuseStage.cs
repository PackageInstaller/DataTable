namespace Ase.ECS;

public class DelayDiffuseStage : BaseStage
{
	protected override void ChangeStage(WarningIndicatorStageSwitcher switcher)
	{
		base.ChangeStage(switcher);
		if (warnData is TrackWarningIndicatorData)
		{
			switcher.ChangeStage<DiffuseStageAndTrackStage>(timerData.diffuseTimer);
		}
		else
		{
			switcher.ChangeStage<DiffuseStage>(timerData.diffuseTimer);
		}
	}

	protected override void StageOver()
	{
	}
}
