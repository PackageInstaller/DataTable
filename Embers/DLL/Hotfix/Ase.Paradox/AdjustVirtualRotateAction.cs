using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改相机旋转", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改虚拟相机的俯仰角")]
public class AdjustVirtualRotateAction : BaseVirtualCameraAction
{
	[Name("关卡是否启用?", 0)]
	public bool LevelOpen;

	[Name("还原相机?", 0)]
	public bool IsReductionCommand;

	[Name("相机旋转类型", 0)]
	[ShowIf("IsReductionCommand", 0)]
	public CameraRotateAdjust cameraRotateType;

	[ShowIf("cameraRotateType", 2)]
	[Name("实体ID", 0)]
	public BBParameter<int> RelativeEntityId;

	[ShowIf("ShowAngleOffset", 1)]
	[Name("角度偏移量", 0)]
	public BBParameter<Vector3> angleOffset;

	[ShowIf(new string[] { "IsReductionCommand", "cameraRotateType" }, new int[] { 0, 1 })]
	[Name("固定角度", 0)]
	public BBParameter<Vector3> fixedAngle;

	[ShowIf("IsReductionCommand", 0)]
	[Name("插值帧数", 0)]
	public BBParameter<int> rotateTick;

	[ShowIf("IsReductionCommand", 0)]
	[Name("是否开启曲线插值", 0)]
	public bool isOpenRotateCurveLerp;

	[ShowIf(new string[] { "IsReductionCommand", "isOpenRotateCurveLerp" }, new int[] { 0, 1 })]
	[Name("插值曲线", 0)]
	public AnimationCurve rotateAnimationCurve;

	[Name("优先级判断", 0)]
	public ChangeCameraPriorityType ChangeCameraPriorityType;

	[ShowIf("IsReductionCommand", 0)]
	[Name("修改优先级", 0)]
	public int rotatePriority;

	[ShowIf("IsReductionCommand", 0)]
	[Name("是否随行为树还原", 0)]
	public bool OnTreeEndReduction;

	[Name("还原的帧数", 0)]
	[ShowIf(new string[] { "IsReductionCommand", "OnTreeEndReduction" }, new int[] { 0, 1 })]
	public BBParameter<int> TreeEndReductionTick;

	[Name("还原的帧数", 0)]
	[ShowIf("IsReductionCommand", 1)]
	public BBParameter<int> ReductionTick;

	[Name("操作相机的指令ID", 0)]
	[Description("返回为-1为无效指令Id")]
	public BBParameter<int> CameraCommandId;

	protected override bool IsUniqueBattleCameraCommand => false;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (!IsCanCameraNode())
		{
			return;
		}
		if (!LevelOpen && ownerEntity.GetWorld().IsStoryWorld)
		{
			EndAction();
			return;
		}
		if (IsReductionCommand)
		{
			ownerEntity.GetSystem<VirtualCameraSystem>().ReductionAngle(Key, ReductionTick.value, CameraCommandId.value);
		}
		else
		{
			int num = ownerEntity.GetSystem<VirtualCameraSystem>().CreateRotateCameraCommand(Key, cameraRotateType, angleOffset.value, fixedAngle.value, RelativeEntityId.value, rotateTick.value, isOpenRotateCurveLerp, rotateAnimationCurve, rotatePriority, ChangeCameraPriorityType);
			if (num != -1)
			{
				CameraCommandId.value = num;
			}
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (IsCanCameraNode() && !IsReductionCommand && OnTreeEndReduction)
		{
			ownerEntity?.GetSystem<VirtualCameraSystem>()?.ReductionAngle(Key, TreeEndReductionTick.value, CameraCommandId.value);
		}
	}
}
