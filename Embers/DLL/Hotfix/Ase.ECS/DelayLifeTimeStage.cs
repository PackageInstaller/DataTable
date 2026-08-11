namespace Ase.ECS;

public class DelayLifeTimeStage : BaseStage
{
	protected override void ChangeStage(WarningIndicatorStageSwitcher switcher)
	{
		base.ChangeStage(switcher);
		switcher.ChangeStage<DieStage>(0f);
	}

	protected override void StageOver()
	{
	}
}
