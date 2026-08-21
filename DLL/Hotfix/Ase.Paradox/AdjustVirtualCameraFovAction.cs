using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改相机FOV", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改虚拟相机的广角")]
public class AdjustVirtualCameraFovAction : BaseVirtualCameraAction
{
	[Name("关卡内启用", 0)]
	public bool IsStoryWorldUse;

	[Name("还原FOV?", 0)]
	public bool IsReductionCommand;

	[Name("FOV设置类型", 0)]
	[ShowIf("IsReductionCommand", 0)]
	public Adjust CameraAdjustType;

	[Name("变化值", 0)]
	[ShowIf(new string[] { "IsReductionCommand", "CameraAdjustType" }, new int[] { 0, 0 })]
	public BBParameter<float> ChangeFOVVlaue;

	[Name("固定值", 0)]
	[ShowIf(new string[] { "IsReductionCommand", "CameraAdjustType" }, new int[] { 0, 1 })]
	public BBParameter<float> FixedFOVValue;

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
		if (ownerEntity.GetWorld().IsStoryWorld && !IsStoryWorldUse)
		{
			EndAction();
		}
		else
		{
			if (!IsCanCameraNode())
			{
				return;
			}
			ownerEntity.GetSystem<VirtualCameraSystem>();
			if (IsReductionCommand)
			{
				ownerEntity.GetSystem<VirtualCameraSystem>().ReductionFov(Key, ReductionTick.value, CameraCommandId.value);
			}
			else
			{
				int num = ownerEntity.GetSystem<VirtualCameraSystem>().CreateAdjustFovData(Key, Priority, CameraAdjustType, ChangeFOVVlaue.value, FixedFOVValue.value, Tick.value, IsOpenCurveLerp, AnimationCurve, ChangeCameraPriorityType);
				if (num != -1)
				{
					CameraCommandId.value = num;
				}
			}
			EndAction();
		}
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (IsCanCameraNode())
		{
			ownerEntity.GetSystem<VirtualCameraSystem>();
			if (!IsReductionCommand && OnTreeEndReduction)
			{
				ownerEntity.GetSystem<VirtualCameraSystem>().ReductionFov(Key, TreeEndReductionTick.value, CameraCommandId.value);
			}
		}
	}
}
