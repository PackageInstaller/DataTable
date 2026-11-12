using AdventureBehaviour;
using TrueSync;

namespace AIScript.BrickBreaker._139;

public class Action : BrickActorAction
{
	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		Singleton<BrickBreakerManager>.Instance?.SetSkillTips(iUse: true);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_actor?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override bool SkillCheck()
	{
		return Singleton<BrickBreakerManager>.Instance.IsLaunched;
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent { eventHashCode: 145010001 })
		{
			GainSoul();
			ShootIceEdgeUp();
		}
	}

	private void GainSoul()
	{
		if (_actor.buffComponent.GetBuffNumByID(13900001) < 3)
		{
			_actor.buffComponent.AddBuff(13900001, _actor);
		}
	}

	private void ShootIceEdgeUp()
	{
		PaddleCollider currentPaddleCollider = Singleton<BrickBreakerManager>.Instance.CurrentPaddleCollider;
		TSVector2 position = ((currentPaddleCollider != null) ? currentPaddleCollider.tsTransform.Position : _actor.tsTransform.Position);
		ILRuntimeAPI.ShootByDirection("Bullet_13901_Sup_P21_l90_BO", _actor, 0, TSVector2.up, position, Config.bulletPositionY);
	}
}
