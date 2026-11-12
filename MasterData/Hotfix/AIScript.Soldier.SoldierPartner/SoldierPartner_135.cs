using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_135 : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.GaoGeDaXinWen;

	private const int buffId_TouTiao = 260113511;

	private const int summonChessId_NanGua = 100007;

	private const int wuYuDataId = 2501054;

	private const string Fx_GhostStart = "FX/Soldier/fx_soldier_base_ghost_start";

	private SoldierLevelController _levelCtrl;

	private AdventureActor _touTiao;

	private CoroutineNode _markCor;

	private readonly List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(partnerTypes);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		StopCoroutine(ref _markCor);
		_actorBuffer.Clear();
		_touTiao = null;
		_levelCtrl = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (partnerLv >= 1 && !(_levelCtrl == null))
		{
			StartMarkWhenWuYuHasTarget(null);
		}
	}

	private void OnActorDied(IEvent evt)
	{
		if (partnerLv >= 1 && !(_levelCtrl == null) && evt is AdventureActorDiedEvent adventureActorDiedEvent && !(adventureActorDiedEvent.actor == null) && !(adventureActorDiedEvent.actor != _touTiao))
		{
			AdventureActor actor = adventureActorDiedEvent.actor;
			_touTiao = null;
			new PlayFX().Play(actor, null, "FX/Soldier/fx_soldier_base_ghost_start", FP.Zero, actor.tsTransform.Position, TSVector2.zero, null, 1f, 3f);
			SpawnNanGua(actor.tsTransform.Position);
			StartMarkWhenWuYuHasTarget(actor);
		}
	}

	private void StartMarkWhenWuYuHasTarget(AdventureActor exclude)
	{
		_actor = _levelCtrl.mainControlActor;
		if (!(_actor == null))
		{
			StartCoroutine(ref _markCor, MarkWhenWuYuHasTarget(exclude));
		}
	}

	private IEnumerator MarkWhenWuYuHasTarget(AdventureActor exclude)
	{
		AdventureActor wuYuAttackTarget;
		while (true)
		{
			wuYuAttackTarget = GetWuYuAttackTarget(exclude);
			if (wuYuAttackTarget != null)
			{
				break;
			}
			yield return null;
		}
		MarkTouTiao(wuYuAttackTarget);
	}

	private void MarkTouTiao(AdventureActor target)
	{
		if (!(target == null))
		{
			ActorHealthInfo actorHealthInfo = target.actorHealthInfo;
			if (actorHealthInfo != null && actorHealthInfo.isAlive && !(target.buffComponent == null))
			{
				target.buffComponent.AddBuff(260113511, target);
				_touTiao = target;
			}
		}
	}

	private AdventureActor GetWuYuAttackTarget(AdventureActor exclude)
	{
		SoldierActor soldierActor = FindOurWuYu();
		if (soldierActor != null && soldierActor.attackTarget is AdventureActor adventureActor && IsValidEnemy(adventureActor, exclude))
		{
			return adventureActor;
		}
		return null;
	}

	private bool IsValidEnemy(AdventureActor a, AdventureActor exclude)
	{
		if (a == null || a == exclude)
		{
			return false;
		}
		ActorHealthInfo actorHealthInfo = a.actorHealthInfo;
		if (actorHealthInfo == null || !actorHealthInfo.isAlive)
		{
			return false;
		}
		if (a.IsSearchedImmunity())
		{
			return false;
		}
		if (a is SoldierActor { isSupport: not false })
		{
			return false;
		}
		return true;
	}

	private void SpawnNanGua(TSVector2 position)
	{
		SoldierActor soldierActor = FindOurWuYu() ?? _levelCtrl.mainControlActor;
		if (!(soldierActor == null))
		{
			_levelCtrl.SpawnSoldierSummon(soldierActor, 100007, position, default, isClearSelf: false);
		}
	}

	private SoldierActor FindOurWuYu()
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return null;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (soldierActor != null && !soldierActor.isDead && soldierActor.dataID == 2501054)
			{
				return soldierActor;
			}
		}
		return null;
	}
}
