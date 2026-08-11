using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改相机基准距离", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于还原虚拟相机的基准高度")]
public class ReductionCameraDistanceAction : BaseVirtualCameraAction
{
	[Name("基准距离", 0)]
	public float BaseDistance;

	[Name("插值帧数", 0)]
	public float LerpTimer;

	[Name("是否随行为树还原", 0)]
	public bool OnTreeEndReduction;

	[Name("还原帧数", 0)]
	[ShowIf("OnTreeEndReduction", 1)]
	public float ReductionLerpTimer;

	protected override bool IsUniqueBattleCameraCommand => true;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (IsCanCameraNode())
		{
			ownerEntity.GetSystem<VirtualCameraSystem>().AdjustCameraBaseDistance(BaseDistance, LerpTimer);
			EndAction();
		}
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && OnTreeEndReduction)
		{
			ownerEntity.GetSystem<VirtualCameraSystem>().ResumeCameraBaseDistance(ReductionLerpTimer);
		}
	}
}
