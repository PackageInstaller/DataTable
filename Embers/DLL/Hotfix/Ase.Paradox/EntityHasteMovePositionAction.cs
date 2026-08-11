using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("实体闪现到目标位置", 0)]
[Description("立即将实体移动到指定的目标位置。可以选择是否忽略地形碰撞。(带偏移)")]
[Category("✫ DragonLost/Transform")]
public class EntityHasteMovePositionAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	public BBParameter<int> entityId;

	[Name("无视地形", 0)]
	[Description("如果勾选，将忽略地形碰撞，直接移动到目标位置。")]
	public bool ignoreCollider;

	[Name("目标位置", 0)]
	[Description("要移动到的目标位置。")]
	public BBParameter<Vector3> targetBBP;

	private int waitFrameCount;

	private float offset;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
		if (entity == null)
		{
			EndAction();
			return;
		}
		Vector3 value = targetBBP.value;
		value.x += offset;
		value.z += offset;
		BattleWorldMode battleMode = entity.GetSystem<BattleSystem>().BattleMode;
		if (battleMode == BattleWorldMode.SyncBattle || battleMode == BattleWorldMode.GameBack)
		{
			entity.GetComponent<KinematicMoveComponent>().SetPosition(value, "闪现到目标位置.ignoreCollider = false");
		}
		else if (!ignoreCollider)
		{
			entity.GetComponent<KinematicMoveComponent>().SetPosition(value, "闪现到目标位置.ignoreCollider = false");
		}
		else
		{
			entity.GetComponent<KinematicMoveComponent>().Teleport(value);
			OnActionFinish();
		}
		waitFrameCount = 0;
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		if (waitFrameCount++ == 1)
		{
			OnActionFinish();
		}
	}
}
