using System;

namespace Ase.ECS;

public class BattleInteractiveEntity : BaseEntity
{
	private DRMapItem config;

	public override bool IsSyncEntity => false;

	public override bool IsSyncPhysicsEntity => false;

	public override EntityUpdateType UpdateType => EntityUpdateType.Local;

	public override EntityType GetEntityType()
	{
		return EntityType.BATTLEINTERACTIVE;
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[5]
		{
			typeof(EntityViewComponent),
			typeof(AnimatorComponent),
			typeof(EntityBoneComponent),
			typeof(AIParadoxComponent),
			typeof(InteractiveStateComponent)
		};
	}

	public override Type GetEntityView()
	{
		return typeof(InteractiveView);
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		config = (DRMapItem)userData;
		SetData(AIParadoxComponent.AI_PARADOX_KEY, config.AIParadoxId);
		SetData(Constant.InteractiveConstant.INTERACTIVE_TIMELENGTH_KEY, config.Time);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"INTERACTIVE_TIMELENGTH_KEY：{config.Time}", this);
		}
		SetData(Constant.InteractiveConstant.INTERACTIVE_RADIUS_KEY, config.Parameter1);
		SetData(Constant.InteractiveConstant.TRIGGERSHAPE, config.Shape);
		SetData(Constant.InteractiveConstant.SHAPELENGTH, config.Parameter2);
		SetData(Constant.InteractiveConstant.SHAPEHEIGHT, config.Parameter3);
		SetData(Constant.InteractiveConstant.INTERACTIVE_CENTEROFFSET_KEY, config.CenterOffset.ToVector3());
		SetData(Constant.InteractiveConstant.INTERACTIVE_STATEID_KEY, 4003);
		SetData(Constant.InteractiveConstant.MAPITEMTYPE, config.MapItemType);
		SetData(Constant.InteractiveConstant.INTERACTIVE_ICONTYPE_KEY, string.IsNullOrEmpty(config.InteractiveBtnAssetPath) ? "interactiveIcon_2" : config.InteractiveBtnAssetPath);
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
