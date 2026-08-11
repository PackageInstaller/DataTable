using ParadoxNotion.Design;

[Name("修改相机自动范围以及速率", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改相机自动拉伸修正倍率")]
public class AdjustAutoDistanceTriggerRatio : BaseVirtualCameraAction
{
	[Name("还原修正倍率", 0)]
	public bool ReductionRatio;

	[Name("修改X轴修正倍率", 0)]
	[ShowIf("ReductionRatio", 0)]
	public bool AdjustX;

	[Name("X轴修正倍率", 0)]
	[ShowIf(new string[] { "ReductionRatio", "AdjustX" }, new int[] { 0, 1 })]
	public float XRatio;

	[Name("修改Y轴修正倍率", 0)]
	[ShowIf("ReductionRatio", 0)]
	public bool AdjustY;

	[Name("Y轴屏幕上方修正倍率", 0)]
	[ShowIf(new string[] { "ReductionRatio", "AdjustY" }, new int[] { 0, 1 })]
	public float YUpRatio;

	[Name("Y轴屏幕下方修正倍率", 0)]
	[ShowIf(new string[] { "ReductionRatio", "AdjustY" }, new int[] { 0, 1 })]
	public float YDownRatio;

	protected override bool IsUniqueBattleCameraCommand => true;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (IsCanCameraNode())
		{
			if (!ReductionRatio)
			{
				_ = AdjustX;
				_ = AdjustY;
			}
			EndAction();
		}
	}
}
