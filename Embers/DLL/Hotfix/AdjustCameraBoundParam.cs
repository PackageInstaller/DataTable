using Ase;
using Ase.ECS;
using ParadoxNotion.Design;
using UnityEngine;

[Name("修改相机包围盒参数", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改相机包围盒参数")]
public class AdjustCameraBoundParam : BaseVirtualCameraAction
{
	[Name("是否还原参数", 0)]
	public bool IsReduction;

	[Name("还原包围盒半径", 0)]
	[ShowIf("IsReduction", 1)]
	public bool ReductionBoundRadius;

	[Name("还原包围盒位置", 0)]
	[ShowIf("IsReduction", 1)]
	public bool ReductionBoundPosition;

	[Name("还原帧数", 0)]
	[ShowIf("IsReduction", 1)]
	public int ReductionTick;

	[Name("修改包围盒半径", 0)]
	[ShowIf("IsReduction", 0)]
	public bool AdjustBoundRadius;

	[Name("半径", 0)]
	[ShowIf(new string[] { "IsReduction", "AdjustBoundRadius" }, new int[] { 0, 1 })]
	public float Radius;

	[Name("修改包围盒位置", 0)]
	[ShowIf("IsReduction", 0)]
	public bool AdjustBoundPosition;

	[Name("相对偏移", 0)]
	[ShowIf(new string[] { "IsReduction", "AdjustBoundPosition" }, new int[] { 0, 1 })]
	public Vector3 PositionOffset;

	[Name("绝对偏移", 0)]
	[ShowIf(new string[] { "IsReduction", "AdjustBoundPosition" }, new int[] { 0, 1 })]
	public Vector3 MonsterBoundAbsoluteOffset;

	[Name("修改帧数", 0)]
	[ShowIf("IsReduction", 0)]
	public int AdjustTick;

	[Name("是否随行为树还原", 0)]
	[ShowIf("IsReduction", 0)]
	public bool OnTreeEndReduction;

	[Name("行为树还原帧数", 0)]
	[ShowIf(new string[] { "IsReduction", "OnTreeEndReduction" }, new int[] { 0, 1 })]
	public int TreeEndReductionTick;

	protected override bool IsUniqueBattleCameraCommand => true;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (!IsCanCameraNode())
		{
			return;
		}
		if (IsReduction)
		{
			ownerEntity.GetSystem<VirtualCameraSystem>().ReductionStretchBoundParam(ReductionBoundRadius, ReductionBoundPosition, ReductionTick);
		}
		else
		{
			if (AdjustBoundRadius)
			{
				ownerEntity.GetSystem<VirtualCameraSystem>().UpdateMonsterEntityBoundRadius(Radius, AdjustTick);
			}
			if (AdjustBoundPosition)
			{
				ownerEntity.GetSystem<VirtualCameraSystem>().UpdateMonsterEntityBoundOffset(PositionOffset, MonsterBoundAbsoluteOffset, AdjustTick);
			}
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (OnTreeEndReduction && ownerEntity != null)
		{
			ownerEntity.GetSystem<VirtualCameraSystem>().ReductionStretchBoundParam(reductionBoundRadius: true, reductionBoundPosition: true, TreeEndReductionTick);
		}
	}
}
