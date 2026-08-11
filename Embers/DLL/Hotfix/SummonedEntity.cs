using System;
using Ase;
using Ase.ECS;
using UnityEngine;

public class SummonedEntity : BaseEntity
{
	private DRSummonedEntityConfig _config;

	private float _lifeTime;

	public DRSummonedEntityConfig SummonedConfig => _config;

	public bool IsSpecialSummoned
	{
		get
		{
			if (_config.BeHitBulletId != null)
			{
				return _config.BeHitBulletId.Count > 0;
			}
			return false;
		}
	}

	public override bool ViewInitIsActive => GetSummonedInitVisibility();

	public override bool IsSyncEntity => true;

	public override bool IsSyncPhysicsEntity => true;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		if (userData is DRSummonedEntityConfig config)
		{
			_config = config;
			property = SummonedEntityPropertyData.Create(this, _config);
			property.InitProperty();
			SetData(AIParadoxComponent.AI_PARADOX_KEY, _config.AIParadoxId);
			SetData("PrimitiveEnum", PrimitiveEnum.BoxPrimitive);
			SetData("HitColliderParam", new Vector3(1f, 2f, 1f));
			SetData("HitColliderColor", Color.magenta);
			SetData("CollisionLayer", collisionLayer);
			SetData("CollisionMass", collisionMass);
			SetData("DeadStateId", 2005);
			SetData("HitCollider", GameEntry.DataTable.GetDataRow<DRHitBox>(_config.HitBoxId));
			_lifeTime = _config.LifeTime;
		}
		ChangeUpdateType(EntityUpdateType.Authority);
	}

	public override void OnFixedUpdate(WorldUpdateType type, float deltaTime)
	{
		base.OnFixedUpdate(type, deltaTime);
		if (!(Math.Abs(_lifeTime - -1f) < 0.001f))
		{
			_lifeTime -= deltaTime;
			if (_lifeTime <= 0f)
			{
				GetComponent<SummonedDestroyComponent>().DoEntityDead();
			}
		}
	}

	public override float RandomFloat(float minValue, float maxValue)
	{
		return world.RandomFloat(minValue, maxValue);
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[20]
		{
			typeof(EntityViewComponent),
			typeof(AnimatorComponent),
			typeof(EntityBoneComponent),
			typeof(TransformComponent),
			typeof(PseudoCritComponent),
			typeof(LogicEntityCollisionComponent),
			typeof(HpComponent),
			typeof(BuffComponent),
			typeof(StateComponent),
			typeof(HitColliderComponent),
			typeof(HitComponent),
			typeof(EntityRotationComponent),
			typeof(CurveMovementComponent),
			typeof(PathfindingComponent),
			typeof(AttractionComponent),
			typeof(KinematicMoveComponent),
			typeof(AIParadoxComponent),
			typeof(DataNodeComponent),
			typeof(EntityPointMaterialComponent),
			typeof(SummonedDestroyComponent)
		};
	}

	public override Type GetEntityView()
	{
		return typeof(SummonedEntityView);
	}

	public override EntityType GetEntityType()
	{
		return EntityType.SummonedEntity;
	}

	public override void OnDispose()
	{
		if (parent != null && parent.IsSyncEntity)
		{
			parent.GetComponent<SummonedComponent>()?.RemoveSummonedEntity(this);
		}
		_lifeTime = 0f;
		_config = null;
		base.OnDispose();
	}

	protected override void InitEntitySkinConfig()
	{
		int skinConfigId = 0;
		if (userData is DRSummonedEntityConfig dRSummonedEntityConfig)
		{
			skinConfigId = parent.GetSummonedSkinConfigByParentSkin(dRSummonedEntityConfig.Id);
		}
		InitSkinAssociation(skinConfigId);
	}

	protected bool GetSummonedInitVisibility()
	{
		if (base.Parent != null && _config != null)
		{
			if (_config.SummonedVisibilityEnum == SummonedVisibilityEnum.All)
			{
				return true;
			}
			if (_config.SummonedVisibilityEnum == SummonedVisibilityEnum.ParentOnly)
			{
				if (world.ActorId != base.Parent.Id)
				{
					return false;
				}
			}
			else if (_config.SummonedVisibilityEnum == SummonedVisibilityEnum.NoParentOnly && world.ActorId == base.Parent.Id)
			{
				return false;
			}
		}
		return true;
	}
}
