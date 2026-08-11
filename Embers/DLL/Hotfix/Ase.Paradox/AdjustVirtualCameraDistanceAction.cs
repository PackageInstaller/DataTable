using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改相机距离", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改虚拟相机的高度")]
public class AdjustVirtualCameraDistanceAction : BaseVirtualCameraAction
{
	[Name("还原相机?", 0)]
	public bool IsReductionCommand;

	[Name("相机移动阻尼", 0)]
	public BBParameter<Vector3> lerpSpeed;

	[Name("修改类型", 0)]
	[ShowIf("IsReductionCommand", 0)]
	public Adjust AdjustType;

	[ShowIf("AdjustType", 2)]
	[Name("实体ID", 0)]
	public BBParameter<int> RelativeEntityId;

	[ShowIf("AdjustType", 2)]
	[Name("偏移量", 0)]
	public BBParameter<Vector3> RelativeEntityOffset;

	[ShowIf(new string[] { "IsReductionCommand", "AdjustType" }, new int[] { 0, 0 })]
	[Name("变化类型", 0)]
	public ChangeValueType ChangeType;

	[ShowIf(new string[] { "IsReductionCommand", "AdjustType" }, new int[] { 0, 0 })]
	[Name("变化值", 0)]
	public BBParameter<float> ChangeValue;

	[ShowIf(new string[] { "IsReductionCommand", "AdjustType" }, new int[] { 0, 1 })]
	[Name("固定值", 0)]
	public BBParameter<float> DistanceValue;

	[ShowIf(new string[] { "IsReductionCommand", "AdjustType" }, new int[] { 0, 1 })]
	[Name("固定值限制", 0)]
	public DistanceValueLimit DistanceLimit;

	[ShowIf("IsReductionCommand", 0)]
	[Name("是否同步修改相机基准值", 0)]
	public bool IsAdjustCameraBaseDistance;

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

	[Name("同步还原基准值", 0)]
	[ShowIf("ShowReductionCameraBaseDistance", 1)]
	public bool ReductionCameraBaseDistance;

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
		ownerEntity.GetSystem<VirtualCameraSystem>();
		if (IsReductionCommand)
		{
			ownerEntity.GetSystem<VirtualCameraSystem>().ReductionDistance(Key, ReductionTick.value, CameraCommandId.value, lerpSpeed.value, ReductionCameraBaseDistance);
		}
		else if (AdjustType == Adjust.ChangeValue)
		{
			int num = ownerEntity.GetSystem<VirtualCameraSystem>().CreateRateAdjustDistanceData(Key, lerpSpeed.value, IsAdjustCameraBaseDistance, Tick.value, IsOpenCurveLerp, AnimationCurve, Priority, ChangeType, ChangeValue.value, ChangeValue.value, ChangeCameraPriorityType);
			if (num != -1)
			{
				CameraCommandId.value = num;
			}
		}
		else
		{
			int num2 = ownerEntity.GetSystem<VirtualCameraSystem>().CreateFixedAdjustDistanceData(Key, lerpSpeed.value, IsAdjustCameraBaseDistance, Tick.value, IsOpenCurveLerp, AnimationCurve, Priority, DistanceValue.value, DistanceLimit, ChangeCameraPriorityType);
			if (num2 != -1)
			{
				CameraCommandId.value = num2;
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
				system.ReductionDistance(Key, TreeEndReductionTick.value, CameraCommandId.value, lerpSpeed.value, ReductionCameraBaseDistance);
			}
		}
	}
}
