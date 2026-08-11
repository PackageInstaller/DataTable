namespace Ase.ECS;

public class DieStage : BaseStage
{
	protected override void StageOver()
	{
		switcher.entity.OnEntityOver();
	}
}
