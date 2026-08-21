namespace Ase;

public class LegacySpineFusion : SpineFusion
{
	public override void ResetToIdle()
	{
		RefreshGraphicControllers();
		foreach (SpineGraphicController validGraphicController in GetValidGraphicControllers())
		{
			validGraphicController.StopAnimation();
			validGraphicController.PlayAction(validGraphicController.SkeletonGraphic.startingAnimation, 0);
		}
	}
}
