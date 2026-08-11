namespace Ase.ECS;

public class FlickerStage : BaseStage
{
	protected override void ChangeStage(WarningIndicatorStageSwitcher switcher)
	{
		base.ChangeStage(switcher);
		switcher.ChangeStage<DieStage>(0.4f);
	}

	protected override void StageOver()
	{
	}
}
