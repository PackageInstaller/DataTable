using UnityEngine;

namespace BilliardGame.Runtime;

public class TimePortalModule : IMechanismTrigger
{
	private EntityMechanism mech;

	private EntityMechanism otherMech;

	private BilliardGameEffect effect;

	private BoxCollider2D collider;

	private bool isBlock;

	private int timer = -1;

	public TimePortalModule(EntityMechanism m)
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
		timer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			if (!(mech.go == null))
			{
				effect = BilliardGameLogicManager.Instance.MakeEffectGo("JiGuan/nya_pinball_jiguan_chuansongmen_xishou_1", mech.go, 1f);
				isBlock = false;
				FuncTimerManager.inst.StopFuncTimer(timer);
				timer = -1;
			}
		}, mech.logic.cdTime, 1);
	}

	public void BeCollision(BilliardGameEntityBase other)
	{
		if (!isBlock && other is EntityPlayer)
		{
			(otherMech.mechModule as TimePortalModule).SetBlock();
			SetBlock();
			(other as EntityPlayer).ChangePosition(otherMech.position);
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_portal");
		}
	}

	public void OnRoundStart()
	{
		if (otherMech == null)
		{
			otherMech = BilliardGameLogicManager.Instance.FindOtherPortal(mech.entityID, MechanismType.TimePortal);
		}
		isBlock = false;
		FuncTimerManager.inst.StopFuncTimer(timer);
		timer = -1;
		if (null != effect)
		{
			effect.Die();
		}
		effect = BilliardGameLogicManager.Instance.MakeEffectGo("JiGuan/nya_pinball_jiguan_chuansongmen_xishou_1", mech.go, 1f);
	}
}
