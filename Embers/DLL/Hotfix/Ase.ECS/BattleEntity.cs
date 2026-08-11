using System;
using UnityEngine;

namespace Ase.ECS;

public class BattleEntity : BaseEntity
{
	private DRBattleEntityConfig _config;

	public override bool IsSyncEntity => true;

	public override bool IsSyncPhysicsEntity => true;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		if (userData is DRBattleEntityConfig config)
		{
			_config = config;
			property = BattleEntityData.Create(this, _config);
			property.InitProperty();
			SetData(AIParadoxComponent.AI_PARADOX_KEY, _config.AIParadoxId);
			SetData("PrimitiveEnum", PrimitiveEnum.BoxPrimitive);
			SetData("HitColliderParam", new Vector3(1f, 2f, 1f));
			SetData("HitColliderColor", Color.magenta);
			SetData("CollisionLayer", collisionLayer);
			SetData("CollisionMass", collisionMass);
			SetData("DeadStateId", 2005);
			SetData("HitCollider", GameEntry.DataTable.GetDataRow<DRHitBox>(_config.HitBoxId));
		}
		ChangeUpdateType(EntityUpdateType.Authority);
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[18]
		{
			typeof(EntityViewComponent),
			typeof(EntityBoneComponent),
			typeof(HpComponent),
			typeof(BuffComponent),
			typeof(StateComponent),
			typeof(HitColliderComponent),
			typeof(HitComponent),
			typeof(EntityRotationComponent),
			typeof(CurveMovementComponent),
			typeof(PathfindingComponent),
			typeof(AIParadoxComponent),
			typeof(DataNodeComponent),
			typeof(EntityPointMaterialComponent),
			typeof(TransformComponent),
			typeof(MonsterDestroyComponent),
			typeof(AttractionComponent),
			typeof(KinematicMoveComponent),
			typeof(MonoEntityCollisionComponent)
		};
	}

	public override Type GetEntityView()
	{
		return typeof(BattleEntityView);
	}

	public override EntityType GetEntityType()
	{
		return EntityType.BATTLEENTITY;
	}
}
