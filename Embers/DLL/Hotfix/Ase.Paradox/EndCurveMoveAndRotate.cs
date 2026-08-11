using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("结束曲线移动和旋转", 0)]
[Description("结束实体的曲线移动和旋转动作。")]
[Category("✫ DragonLost/Transform")]
public class EndCurveMoveAndRotate : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要结束曲线移动和旋转的实体的ID。")]
	public BBParameter<int> EntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			EndAction();
			return;
		}
		entity.GetComponent<CurveMovementComponent>()?.OnCurveMoveEnd();
		entity.GetComponent<SurroundRotateComponent>()?.ShieldAll();
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"结束曲线移动和旋转  实体ID : {EntityId.value}", ownerEntity);
		}
		EndAction();
	}
}
