using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改虚拟相机吸附功能参数", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改虚拟相机的吸附功能参数")]
public class AdjustVirtualCameraAdsorptionParamerter : ActionTaskBase
{
	[Name("是否保持原吸附对象", 0)]
	[Description("是否保持原有吸附对象，如果不保持，则指定新的吸附对象")]
	public bool isKeepBefore = true;

	[Name("吸附对象Id", 0)]
	[HideIf("isKeepBefore", 1)]
	[Description("新的吸附对象的Id")]
	public BBParameter<int> adsorptedTargetId;

	[Name("最大水平距离", 0)]
	[Description("相机与吸附对象之间的最大水平距离")]
	public BBParameter<float> maxHorizontalDistance;

	[Name("最大垂直距离", 0)]
	[Description("相机与吸附对象之间的最大垂直距离")]
	public BBParameter<float> maxVerticalDistance;

	[Name("最小水平距离", 0)]
	[Description("相机与吸附对象之间的最小水平距离")]
	public BBParameter<float> minHorizontalDistance;

	[Name("最小垂直距离", 0)]
	[Description("相机与吸附对象之间的最小垂直距离")]
	public BBParameter<float> minVerticalDistance;

	[Name("相机移动速度", 0)]
	[Description("相机移动的速度")]
	public BBParameter<float> cameraMovementSharpness;

	[Name("移动阈值", 0)]
	[Description("相机移动的阈值")]
	public BBParameter<float> cameraMoveThreshold;

	private VirtualCameraSystem virtualCameraSystem;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
