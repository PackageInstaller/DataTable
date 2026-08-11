using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改相机距离自动拉伸参数", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改相机吸附拉伸范围")]
public class AdjustStretchLimitAction : BaseVirtualCameraAction
{
	[Name("是否还原?", 0)]
	public bool IsReduction;

	[Name("实体ID", 0)]
	[ShowIf("IsReductionShow", 1)]
	public BBParameter<int> EntityId;

	[Name("还原自动拉伸上下限", 0)]
	[ShowIf("IsReductionShow", 1)]
	public bool ReductionStretchDistanceLimit;

	[Name("还原自动拉伸启动距离", 0)]
	[ShowIf("IsReductionShow", 1)]
	public bool ReductionStretchDeterminationDistance;

	[Name("还原自动拉伸速度", 0)]
	[ShowIf("IsReductionShow", 1)]
	public bool ReductionStretchSpeed;

	[Name("还原帧数", 0)]
	[ShowIf("IsReduction", 1)]
	public int ReductionTick;

	[Name("修改自动拉伸上下限", 0)]
	[ShowIf("IsReduction", 0)]
	public bool AdjustStretchDistanceLimit;

	[Name("最小范围", 0)]
	[ShowIf(new string[] { "IsReduction", "AdjustStretchDistanceLimit" }, new int[] { 0, 1 })]
	public float MinLimit;

	[Name("最大范围", 0)]
	[ShowIf(new string[] { "IsReduction", "AdjustStretchDistanceLimit" }, new int[] { 0, 1 })]
	public float MaxLimit;

	[Name("修改自动拉伸启动距离", 0)]
	[ShowIf("IsReduction", 0)]
	public bool AdjustStretchDeterminationDistance;

	[Name("启动距离", 0)]
	[ShowIf(new string[] { "IsReduction", "AdjustStretchDeterminationDistance" }, new int[] { 0, 1 })]
	public float StretchDeterminationDistance;

	[Name("修改自动拉伸速度", 0)]
	[ShowIf("IsReduction", 0)]
	public bool AdjustStretchSpeed;

	[Name("拉伸速度", 0)]
	[ShowIf(new string[] { "IsReduction", "AdjustStretchSpeed" }, new int[] { 0, 1 })]
	public float StretchSpeed;

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
			if (GetEntity(EntityId.value, isSyncEntity: false) is MonsterEntity monsterEntity)
			{
				if (ReductionStretchDistanceLimit)
				{
					float cameraDistanceBaseValue = ownerEntity.GetSystem<VirtualCameraSystem>().CameraDistanceBaseValue;
					ownerEntity.GetSystem<VirtualCameraSystem>().UpdateStretchLimit((monsterEntity.MonsterTypeConfig.AutoDistanceMin == 0f) ? cameraDistanceBaseValue : monsterEntity.MonsterTypeConfig.AutoDistanceMin, (monsterEntity.MonsterTypeConfig.AutoDistanceMax == 0f) ? cameraDistanceBaseValue : monsterEntity.MonsterTypeConfig.AutoDistanceMax, ReductionTick);
				}
				if (ReductionStretchDeterminationDistance)
				{
					ownerEntity.GetSystem<VirtualCameraSystem>().UpdateCameraStretchDeterminationDistance(monsterEntity.MonsterTypeConfig.AutoDistTrigger, ReductionTick);
				}
				if (ReductionStretchSpeed)
				{
					ownerEntity.GetSystem<VirtualCameraSystem>().UpdateCameraStretchSpeed(monsterEntity.MonsterTypeConfig.AutoDistSpeed, ReductionTick);
				}
			}
		}
		else
		{
			if (AdjustStretchDistanceLimit)
			{
				ownerEntity.GetSystem<VirtualCameraSystem>().UpdateStretchLimit(MinLimit, MaxLimit, AdjustTick);
			}
			if (AdjustStretchDeterminationDistance)
			{
				ownerEntity.GetSystem<VirtualCameraSystem>().UpdateCameraStretchDeterminationDistance(StretchDeterminationDistance, AdjustTick);
			}
			if (AdjustStretchSpeed)
			{
				ownerEntity.GetSystem<VirtualCameraSystem>().UpdateCameraStretchSpeed(StretchSpeed, AdjustTick);
			}
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && !IsReduction && OnTreeEndReduction && GetEntity(EntityId.value, isSyncEntity: false) is MonsterEntity monsterEntity)
		{
			if (ReductionStretchDistanceLimit)
			{
				float cameraDistanceBaseValue = ownerEntity.GetSystem<VirtualCameraSystem>().CameraDistanceBaseValue;
				ownerEntity.GetSystem<VirtualCameraSystem>().UpdateStretchLimit((monsterEntity.MonsterTypeConfig.AutoDistanceMin == 0f) ? cameraDistanceBaseValue : monsterEntity.MonsterTypeConfig.AutoDistanceMin, (monsterEntity.MonsterTypeConfig.AutoDistanceMax == 0f) ? cameraDistanceBaseValue : monsterEntity.MonsterTypeConfig.AutoDistanceMax, TreeEndReductionTick);
			}
			if (ReductionStretchDeterminationDistance)
			{
				ownerEntity.GetSystem<VirtualCameraSystem>().UpdateCameraStretchDeterminationDistance(monsterEntity.MonsterTypeConfig.AutoDistTrigger, TreeEndReductionTick);
			}
			if (ReductionStretchSpeed)
			{
				ownerEntity.GetSystem<VirtualCameraSystem>().UpdateCameraStretchSpeed(monsterEntity.MonsterTypeConfig.AutoDistSpeed, TreeEndReductionTick);
			}
		}
	}
}
