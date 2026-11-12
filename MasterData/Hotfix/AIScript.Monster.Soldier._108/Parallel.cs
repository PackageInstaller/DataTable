using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._108;

public class Parallel : AIBase
{
	private const string bulletAlias = "Bullet_Soldier_108_Support";

	private const string bulletTag = "Bullet108B2Skill";

	private static readonly int damageTag_Bomb = CommonHelper.StringToHash("108_B2");

	private const int bombCount = 3;

	private static readonly FP bombInterval = 0.3;

	private static readonly FP bombRadius = 2;

	private static readonly FP shootPositionY = 1;

	private static readonly TSVector2 centerOffset_NoTarget = new TSVector2(0, 5);

	private const int bombCount_Potential2 = 5;

	private const string areaEffectAlias_FirePit = "AreaEffect_Soldier_108_Support";

	private readonly HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.BaiMaoJuTuan;

	private const int buffId_Stun = 250104402;

	private static readonly FP round2Percent = 60;

	private const int bombRound_Partner = 2;

	private static readonly FP roundInterval = 1;

	private const int bombRound_Base = 1;

	private int _potentialLv = 1;

	private bool _aborted;

	public void OnEnable()
	{
		_potentialLv = ((!(_actor is SoldierActor soldierActor)) ? 1 : soldierActor.GetPotentialLv());
		_aborted = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("KASIMIRA_SKILL_SHOOT", OnReceiveShootEvent);
		if (_potentialLv >= 3)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	public void OnDisable()
	{
		_aborted = true;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("KASIMIRA_SKILL_SHOOT", OnReceiveShootEvent);
		if (_potentialLv >= 3)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void OnReceiveShootEvent(IEvent evt)
	{
		if (!_aborted && !(_actor == null) && evt is KasimiraSkillShootEvent kasimiraSkillShootEvent && kasimiraSkillShootEvent.sender == _actor)
		{
			int count = ((_potentialLv >= 2) ? 5 : 3);
			int round = 1;
			if (GetPartnerLv() >= 1 && round2Percent > 0 && TSRandom.Range(FP.Zero, 100) <= round2Percent)
			{
				round = 2;
			}
			TSVector2 fallbackCenter = _actor.tsTransform.Position + _actor.tsTransform.Left * centerOffset_NoTarget.x + _actor.tsTransform.Forward * centerOffset_NoTarget.y;
			_actor.StartLogicCoroutine(BombLogic(kasimiraSkillShootEvent.shootPosition, kasimiraSkillShootEvent.target, fallbackCenter, count, round));
		}
	}

	private IEnumerator BombLogic(TSVector2 shootPosition, LogicEntity target, TSVector2 fallbackCenter, int count, int round)
	{
		TSVector2 lastKnownCenter = ((target != null) ? target.tsTransform.Position : fallbackCenter);
		for (int r = 0; r < round; r++)
		{
			if (r > 0)
			{
				yield return _actor.WaitTime(roundInterval);
				if (_aborted)
				{
					break;
				}
			}
			for (int i = 0; i < count; i++)
			{
				if (i > 0)
				{
					yield return _actor.WaitTime(bombInterval);
					if (_aborted)
					{
						yield break;
					}
				}
				if (target != null && !target.IsDead())
				{
					lastKnownCenter = target.tsTransform.Position;
				}
				TSVector2 targetPosition = TrueSyncExtensions.RandomPointInsideRing(lastKnownCenter, 0, bombRadius);
				ILRuntimeAPI.Shoot("Bullet_Soldier_108_Support", _actor, 0, shootPosition, shootPositionY, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (!_aborted && !(_actor == null) && evt is AdventureBulletFinishEvent adventureBulletFinishEvent && !(adventureBulletFinishEvent.owner == null) && !(adventureBulletFinishEvent.owner != _actor) && string.Equals(adventureBulletFinishEvent.tag, "Bullet108B2Skill") && !string.IsNullOrEmpty("AreaEffect_Soldier_108_Support"))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_Soldier_108_Support", adventureBulletFinishEvent.bulletPosition);
		}
	}

	private void OnDamage(IEvent evt)
	{
		if (!_aborted && !(_actor == null) && evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_Bomb) && adventureActorReceiveDamageEvent.to is AdventureActor adventureActor && GetPartnerLv() >= 1)
		{
			adventureActor.buffComponent?.AddBuff(250104402, _actor);
		}
	}

	private int GetPartnerLv()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return 0;
		}
		return soldierLevelController.GetPartnerLv(partnerType);
	}
}
