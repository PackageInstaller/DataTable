using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改相机优先级", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改相机优先级")]
public class AdjustCameraPriority : BaseVirtualCameraAction
{
	[Name("优先级", 0)]
	public int Priority;

	[Name("混合时间", 0)]
	public float BlendTime;

	[Name("当树结束是否还原", 0)]
	public bool OnTreeEndIsReduction;

	protected override bool IsUniqueBattleCameraCommand => false;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (IsCanCameraNode())
		{
			ownerEntity.GetSystem<VirtualCameraSystem>().AdjustVirtualCameraPriority(Key, Priority);
			ownerEntity.GetSystem<VirtualCameraSystem>().AdjustVirtualCameraBlendTime(BlendTime);
			EndAction();
		}
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (IsCanCameraNode() && OnTreeEndIsReduction)
		{
			CameraBaseData cameraBaseData = ownerEntity.GetSystem<VirtualCameraSystem>().GetCameraBaseData(Key);
			ownerEntity.GetSystem<VirtualCameraSystem>().AdjustVirtualCameraPriority(Key, cameraBaseData?.battleCameraProperty ?? 1);
			ownerEntity.GetSystem<VirtualCameraSystem>().AdjustVirtualCameraBlendTime(ownerEntity.GetWorld()?.CameraConfig?.battleDefaultBlendTime ?? 1f);
		}
	}
}
