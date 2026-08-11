using System;
using UnityEngine;

namespace Ase.ECS;

public class NpcEntity : BaseEntity
{
	private DRNPC config;

	public override bool SyncPosition => false;

	public override EntityType GetEntityType()
	{
		return EntityType.NPC;
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[6]
		{
			typeof(EntityViewComponent),
			typeof(AnimatorComponent),
			typeof(EntityBoneComponent),
			typeof(AIParadoxComponent),
			typeof(InteractiveStateComponent),
			typeof(DialogChainComponent)
		};
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		if (userData is DRNPC dRNPC)
		{
			config = dRNPC;
			SetData(AIParadoxComponent.AI_PARADOX_KEY, config.AIParadoxId);
			SetData(Constant.InteractiveConstant.INTERACTIVE_TIMELENGTH_KEY, 0f);
			SetData(Constant.InteractiveConstant.INTERACTIVE_RADIUS_KEY, 2f);
			SetData(Constant.InteractiveConstant.TRIGGERSHAPE, "Circle");
			SetData(Constant.InteractiveConstant.INTERACTIVE_CENTEROFFSET_KEY, Vector3.zero);
			SetData(Constant.InteractiveConstant.INTERACTIVE_ICONTYPE_KEY, "interactiveIcon_3");
			SetData(Constant.InteractiveConstant.INTERACTIVE_STATEID_KEY, 0);
			SetData(Constant.InteractiveConstant.MAPITEMTYPE, -1);
		}
	}

	protected override void OnEntityStandby()
	{
		GetComponent<EntityViewComponent>().HideEntityView();
		if (GetComponent<InteractiveStateComponent>().GetState() != MapItemState.Idle)
		{
			GetComponent<InteractiveStateComponent>().ChangeInteractiveState(MapItemState.Exit);
		}
	}

	protected override void OnReactivateEntity()
	{
		GetComponent<EntityViewComponent>().ShowEntityView();
	}

	public override Type GetEntityView()
	{
		return typeof(NPCView);
	}
}
