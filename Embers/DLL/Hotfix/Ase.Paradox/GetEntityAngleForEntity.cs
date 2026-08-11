#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取实体与实体的相对角度", 0)]
[Description("计算两个实体之间的相对角度，并将结果存储在指定的变量中。")]
[Category("✫ DragonLost/Transform")]
public class GetEntityAngleForEntity : ActionTaskBase
{
	[Name("获取的角度", 0)]
	[Description("存储计算得到的相对角度的变量。")]
	public BBParameter<float> Angle;

	[Name("基准实体ID", 0)]
	[Description("用作计算基准的实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("目标实体ID", 0)]
	[Description("要计算相对角度的目标实体的ID。")]
	public BBParameter<int> TargetEntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: true);
		BaseEntity entity2 = GetEntity(TargetEntityId.value, isSyncEntity: true);
		if (entity == null || entity2 == null)
		{
			LogActionError($"获取实体{EntityId.value}与实体{TargetEntityId.value}的相对角度");
			EndAction(success: true);
			return;
		}
		Angle.value = TSUtil.TargetFwdAngleToSelf(entity.transform.position, entity.transform.eulerAngles.y - 180f, entity2.transform.position);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取实体与实体的相对角度 {Angle.value}", ownerEntity);
		}
		EndAction();
	}
}
