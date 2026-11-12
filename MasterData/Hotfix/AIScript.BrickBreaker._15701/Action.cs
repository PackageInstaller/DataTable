using AdventureBehaviour;
using TrueSync;

namespace AIScript.BrickBreaker._15701;

public class Action : BrickActorAction
{
	private readonly string boltBullet = "Bullet_157_NrmAtk_BO_Bullet";

	private readonly TSVector2 offeset = new TSVector2(0, 2f);

	private readonly FP boltInterval = 3;

	private readonly FP boltPositionY = 1.6;

	private FP _boltCdTimer;

	private readonly string BulletTag = "Bullet_157_Skill_BO_Bullet";

	private readonly string linkFx = "fx_15701_loop_Hunt_Line";

	private readonly FP linkFxDuration = 7;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		_actor?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent { eventHashCode: 157010001 }) || string.IsNullOrEmpty(boltBullet) || _actor.LogicTime < _boltCdTimer)
		{
			return;
		}
		_boltCdTimer = _actor.LogicTime + boltInterval;
		TSVector2 position = _actor.tsTransform.Position;
		TSVector2 shootDir = TSVector2.up;
		if (Singleton<BrickBreakerManager>.Instance.HasHuntingChain)
		{
			TSVector2 normalized = (Singleton<BrickBreakerManager>.Instance.HuntingChainPos - position).normalized;
			if (normalized != TSVector2.zero)
			{
				shootDir = normalized;
			}
		}
		TSVector2 position2 = _actor.tsTransform.TransformLocalPointToWorldSpace(offeset);
		ILRuntimeAPI.ShootByDirection(boltBullet, _actor, 0, shootDir, position2, boltPositionY);
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (!string.IsNullOrEmpty(BulletTag) && evt is AdventureBulletFinishEvent adventureBulletFinishEvent && string.Equals(adventureBulletFinishEvent.tag, BulletTag))
		{
			Singleton<BrickBreakerManager>.Instance?.StartHuntingChain(adventureBulletFinishEvent.bulletPosition, linkFxDuration, linkFx);
		}
	}

	public override void OnStart()
	{
		base.OnStart();
		_boltCdTimer = 0;
	}

	public override void OnStop()
	{
		base.OnStop();
	}
}
