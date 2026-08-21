using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改相机焦点位置", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改虚拟相机的焦点偏移")]
public class AdjustVirtualPositionOffsetAction : BaseVirtualCameraAction
{
	[Name("还原相机?", 0)]
	public bool IsReductionCommand;

	[Name("相机移动阻尼", 0)]
	public BBParameter<Vector3> lerpSpeed;

	[Name("偏移类型", 0)]
	[ShowIf("IsReductionCommand", 0)]
	public CameraOffsetType CameraOffsetType;

	[ShowIf(new string[] { "IsReductionCommand", "CameraOffsetType" }, new int[] { 0, 2 })]
	[Name("实体ID", 0)]
	public BBParameter<int> EntityId;

	[ShowIf(new string[] { "IsReductionCommand", "CameraOffsetType" }, new int[] { 0, 2 })]
	[Name("绑点名字", 0)]
	public string PointName;

	[ShowIf(new string[] { "IsReductionCommand", "CameraOffsetType" }, new int[] { 0, 2 })]
	[Name("焦点跟随", 0)]
	public bool CameraFollowPoint;

	[ShowIf(new string[] { "IsReductionCommand", "CameraOffsetType" }, new int[] { 0, 2 })]
	[Name("位置偏移量", 0)]
	public BBParameter<Vector3> PositionOffset;

	[ShowIf(new string[] { "IsReductionCommand", "CameraOffsetType" }, new int[] { 0, 0 })]
	[Name("固定位置", 0)]
	public BBParameter<Vector3> FixedOffset;

	[ShowIf(new string[] { "IsReductionCommand", "CameraOffsetType" }, new int[] { 0, 1 })]
	[Name("相对坐标偏移", 0)]
	public BBParameter<Vector3> RelativeOffset;

	[ShowIf(new string[] { "IsReductionCommand", "CameraOffsetType" }, new int[] { 0, 1 })]
	[Name("绝对坐标偏移", 0)]
	public BBParameter<Vector3> AbsoluteOffset;

	[ShowIf("IsReductionCommand", 0)]
	[Name("插值帧数", 0)]
	public BBParameter<int> Tick;

	[ShowIf("IsReductionCommand", 0)]
	[Name("是否开启曲线插值", 0)]
	public bool IsOpenCurveLerp;

	[Name("插值曲线", 0)]
	[ShowIf(new string[] { "IsReductionCommand", "IsOpenCurveLerp" }, new int[] { 0, 1 })]
	public AnimationCurve AnimationCurve;

	[Name("优先级判断", 0)]
	public ChangeCameraPriorityType ChangeCameraPriorityType;

	[ShowIf("IsReductionCommand", 0)]
	[Name("修改优先级", 0)]
	public int Priority;

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
		VirtualCameraSystem system = ownerEntity.GetSystem<VirtualCameraSystem>();
		if (IsReductionCommand)
		{
			system.ReductionOffset(Key, ReductionTick.value, CameraCommandId.value, lerpSpeed.value);
		}
		else
		{
			int num = system.CreateMoveCameraCommand(Key, CameraOffsetType, EntityId.value, PointName, CameraFollowPoint, PositionOffset.value, FixedOffset.value, RelativeOffset.value, AbsoluteOffset.value, Tick.value, IsOpenCurveLerp, AnimationCurve, Priority, lerpSpeed.value, ChangeCameraPriorityType);
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
		if (IsCanCameraNode())
		{
			VirtualCameraSystem system = ownerEntity.GetSystem<VirtualCameraSystem>();
			if (!IsReductionCommand && OnTreeEndReduction)
			{
				system.ReductionOffset(Key, TreeEndReductionTick.value, CameraCommandId.value, lerpSpeed.value);
			}
		}
	}
}
