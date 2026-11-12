using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPlayerPassive;

public class SoldierPlayerPassive_10 : SoldierPlayerPassiveBase
{
	private static readonly FP PER_SHOP_LV_PERCENT = FP.One / 10;

	private static readonly FP TARGET_PERCENT_CAP = FP.One;

	private const int SHOP_LV_FALLBACK = 1;

	private SoldierLevelController _levelCtrl;

	private readonly HashSet<SoldierActor> _grantedActors = new HashSet<SoldierActor>();

	private bool _consumed;

	private readonly List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	protected override void OnPlayerPassiveEnable()
	{
		base.OnPlayerPassiveEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DEAD_IMMUNITY", OnActorDeadImmunity);
	}

	protected override void OnPlayerPassiveDisable()
	{
		base.OnPlayerPassiveDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DEAD_IMMUNITY", OnActorDeadImmunity);
		RevokeAll();
		_levelCtrl = null;
		_actorBuffer.Clear();
		_consumed = false;
	}

	protected override void OnPlayerPassiveBattleStart()
	{
		base.OnPlayerPassiveBattleStart();
		RevokeAll();
		_consumed = false;
		if (_levelCtrl == null)
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.actorHealthInfo != null && soldierActor.actorHealthInfo.isAlive)
			{
				soldierActor.EnableDeadImmunity();
				_grantedActors.Add(soldierActor);
			}
		}
	}

	private void OnActorDeadImmunity(IEvent evt)
	{
		if (!_consumed && evt is AdventureActorDeadImmunityEvent { to: SoldierActor { isEnemyCamp: false } to } && _grantedActors.Contains(to))
		{
			_consumed = true;
			ApplyReviveHpToSoldier(to);
			RevokeAll();
		}
	}

	private void ApplyReviveHpToSoldier(SoldierActor actor)
	{
		if (actor == null || actor.actorHealthInfo == null || !actor.actorHealthInfo.isAlive)
		{
			return;
		}
		long hpMax = actor.actorHealthInfo.hpMax;
		if (hpMax > 0)
		{
			int num = ((!(_levelCtrl != null)) ? 1 : _levelCtrl.shopLv);
			if (num <= 0)
			{
				num = 1;
			}
			FP fP = PER_SHOP_LV_PERCENT * num;
			if (fP > TARGET_PERCENT_CAP)
			{
				fP = TARGET_PERCENT_CAP;
			}
			long num2 = (hpMax * fP).AsLong();
			long hp = actor.actorHealthInfo.hp;
			long num3 = num2 - hp;
			if (num3 > 0)
			{
				actor.DirectHeal((int)num3, showHud: true);
			}
		}
	}

	private void RevokeAll()
	{
		if (_grantedActors.Count == 0)
		{
			return;
		}
		foreach (SoldierActor grantedActor in _grantedActors)
		{
			if (!(grantedActor == null) && grantedActor.isDeadImmunity)
			{
				grantedActor.DisableDeadImmunity();
			}
		}
		_grantedActors.Clear();
	}
}
