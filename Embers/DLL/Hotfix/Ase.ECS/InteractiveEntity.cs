using System;

namespace Ase.ECS;

public class InteractiveEntity : BaseEntity
{
	private DRMapItem config;

	private InteractiveStateComponent interactiveStateComponent;

	public override bool SyncPosition
	{
		get
		{
			if (config == null)
			{
				return false;
			}
			return config.CanMove;
		}
	}

	public override bool IsSyncPhysicsEntity
	{
		get
		{
			if (config == null)
			{
				return false;
			}
			return config.CanMove;
		}
	}

	public override EntityType GetEntityType()
	{
		return EntityType.INTERACTIVE;
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[15]
		{
			typeof(EntityViewComponent),
			typeof(AnimatorComponent),
			typeof(EntityBoneComponent),
			typeof(TransformComponent),
			typeof(MonoEntityCollisionComponent),
			typeof(CurveMovementComponent),
			typeof(InteractiveEntityRotationComponent),
			typeof(KinematicMoveComponent),
			typeof(AIParadoxComponent),
			typeof(InteractiveStateComponent),
			typeof(DialogChainComponent),
			typeof(InteractiveLiftComponent),
			typeof(HitColliderComponent),
			typeof(BuffComponent),
			typeof(BingMoveComponent)
		};
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		config = (DRMapItem)userData;
		SetData(AIParadoxComponent.AI_PARADOX_KEY, config.AIParadoxId);
		SetData(Constant.InteractiveConstant.INTERACTIVE_TIMELENGTH_KEY, config.Time);
		SetData(Constant.InteractiveConstant.INTERACTIVE_RADIUS_KEY, config.Parameter1);
		SetData(Constant.InteractiveConstant.TRIGGERSHAPE, config.Shape);
		SetData(Constant.InteractiveConstant.SHAPELENGTH, config.Parameter2);
		SetData(Constant.InteractiveConstant.SHAPEHEIGHT, config.Parameter3);
		SetData(Constant.InteractiveConstant.INTERACTIVE_CENTEROFFSET_KEY, config.CenterOffset.ToVector3());
		SetData(Constant.InteractiveConstant.INTERACTIVE_STATEID_KEY, 4003);
		SetData(Constant.InteractiveConstant.INTERACTIVE_ICONTYPE_KEY, string.IsNullOrEmpty(config.InteractiveBtnAssetPath) ? "interactiveIcon_2" : config.InteractiveBtnAssetPath);
		SetData("Hp", config.HP);
		SetData(Constant.InteractiveConstant.INTERACTIVE_HITSWITCH_KEY, config.HP > 0);
		SetData(Constant.InteractiveConstant.INTERACTIVE_DROP_KEY, config.DropId);
		SetData(Constant.InteractiveConstant.BREAKTYPE, config.BreakType);
		SetData("HitCollider", GameEntry.DataTable.GetDataRow<DRHitBox>(config.HitBoxId));
		SetData(Constant.InteractiveConstant.BASEATTACK, config.Attack);
		SetData(Constant.InteractiveConstant.MAPITEMTYPE, config.MapItemType);
	}

	protected override void OnEntityStandby()
	{
		(GetComponent<EntityViewComponent>().EntityView as InteractiveView)?.ChangeHideLayer();
		(GetComponent<EntityViewComponent>().EntityView as InteractiveView)?.ChangeColloderCollision(isOpen: false);
		if (GetComponent<InteractiveStateComponent>().GetState() != MapItemState.Idle)
		{
			GetComponent<InteractiveStateComponent>().ChangeInteractiveState(MapItemState.Exit);
		}
	}

	protected override void OnReactivateEntity()
	{
		(GetComponent<EntityViewComponent>().EntityView as InteractiveView)?.ChangeActiveLayer();
		(GetComponent<EntityViewComponent>().EntityView as InteractiveView)?.ChangeColloderCollision(isOpen: true);
	}

	public override Type GetEntityView()
	{
		return typeof(InteractiveView);
	}

	public override CampType GetEntityCampType()
	{
		return (CampType)(config?.CampType).Value;
	}

	public bool GetHaveHitBox()
	{
		if (config == null)
		{
			return false;
		}
		return config.HitBoxId != 0;
	}
}
