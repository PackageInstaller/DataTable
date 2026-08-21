using UnityEngine;

namespace BilliardGame.Runtime;

public class PortalModule : IMechanismTrigger
{
	private EntityMechanism mech;

	private EntityMechanism otherMech;

	private BilliardGameEffect effect;

	private BoxCollider2D collider;

	private bool isBlock;

	public PortalModule(EntityMechanism m)
	{
		mech = m;
		isBlock = false;
		collider = mech.go.GetComponent<BoxCollider2D>();
		effect = BilliardGameLogicManager.Instance.MakeEffectGo("JiGuan/nya_pinball_jiguan_chuansongmen_xishou_1", mech.go, 1f);
	}

	public void SetBlock()
	{
		isBlock = true;
		if (null != effect)
		{
			effect.Die();
		}
	}

	public void BeCollision(BilliardGameEntityBase other)
	{
		if (!isBlock && other is EntityPlayer)
		{
			(otherMech.mechModule as PortalModule).SetBlock();
			SetBlock();
			(other as EntityPlayer).ChangePosition(otherMech.position);
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_portal");
		}
	}

	public void OnRoundStart()
	{
		if (otherMech == null)
		{
			otherMech = BilliardGameLogicManager.Instance.FindOtherPortal(mech.entityID, MechanismType.Portal);
		}
		isBlock = false;
		if (null != effect)
		{
			effect.Die();
		}
		effect = BilliardGameLogicManager.Instance.MakeEffectGo("JiGuan/nya_pinball_jiguan_chuansongmen_xishou_1", mech.go, 1f);
	}
}
