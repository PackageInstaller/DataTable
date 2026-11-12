using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._126;

public class Parallel : AIBase
{
	private int PotentialLv = 1;

	private bool hasQiLiMoFa;

	private int partnerLv;

	private List<LogicEntity> _targets;

	public void OnEnable()
	{
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
		hasQiLiMoFa = (_actor as SoldierActor).HasPartnerType(HotfixEnum.ChessPartnerType.QiLiMoFa);
		if (hasQiLiMoFa)
		{
			partnerLv = (ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController)?.GetPartnerLv(HotfixEnum.ChessPartnerType.QiLiMoFa) ?? 0;
		}
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	public void OnDisable()
	{
		_actor?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void OnDamage(IEvent evt)
	{
		if (PotentialLv >= 2 && evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && adventureActorReceiveDamageEvent.hitDamageTag != null && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, SupportSkill.hitTag_bullet) && adventureActorReceiveDamageEvent.to is SoldierActor soldierActor && soldierActor.actorHealthInfo.isAlive)
		{
			soldierActor.buffComponent.AddBuff(250104701, _actor);
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && !(adventureActorCustomEvent.eventName != "126SupportFire"))
		{
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.tsTransform.Position, SupportSkill.searchRadius, OnSearchTargetFinish, isConfront: true);
		}
	}

	private void OnSearchTargetFinish(List<LogicEntity> targets)
	{
		TSVector2 position = _actor.tsTransform.Position;
		int num = ((PotentialLv >= 3) ? 5 : 3);
		if (targets == null || targets.Count <= 0)
		{
			TSVector2 targetPosition = _actor.tsTransform.Position + _actor.tsTransform.Forward * SupportSkill.searchRadius;
			for (int i = 0; i < num; i++)
			{
				ILRuntimeAPI.Shoot(SupportSkill.bulletPaths.get_Item(i), _actor, 0, position, SupportSkill.bulletHeight, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
			return;
		}
		if (_targets == null)
		{
			_targets = new List<LogicEntity>(10);
		}
		else
		{
			_targets.Clear();
		}
		targets.Sort((LogicEntity x, LogicEntity y) =>
		{
			FP fP = TSVector2.DistanceSquared(x.tsTransform.Position, _actor.tsTransform.Position);
			FP fP2 = TSVector2.DistanceSquared(y.tsTransform.Position, _actor.tsTransform.Position);
			return (!(fP < fP2)) ? ((fP > fP2) ? 1 : 0) : (-1);
		});
		bool flag = false;
		if (_actor.attackTarget != null)
		{
			for (int num2 = 0; num2 < targets.Count; num2++)
			{
				if (targets.get_Item(num2).Id == _actor.attackTarget.Id)
				{
					_targets.Add(targets.get_Item(num2));
					flag = true;
					break;
				}
			}
			for (int num3 = 0; num3 < targets.Count; num3++)
			{
				if (targets.get_Item(num3).Id != _actor.attackTarget.Id)
				{
					_targets.Add(targets.get_Item(num3));
				}
			}
		}
		else
		{
			_targets.AddRange(targets);
		}
		int num4 = 0;
		bool flag2 = false;
		for (int num5 = 0; num5 < num; num5++)
		{
			if (_targets.Count <= 0)
			{
				break;
			}
			LogicEntity logicEntity = _targets.get_Item(num4) ?? _targets.get_Item(0);
			string bulletAlias = SupportSkill.bulletPaths.get_Item(num5);
			AdventureActor actor = _actor;
			FP range = 0;
			FP bulletHeight = SupportSkill.bulletHeight;
			LogicEntity target = logicEntity;
			ILRuntimeAPI.Shoot(bulletAlias, actor, range, position, bulletHeight, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			if (flag2)
			{
				num4 = ((!flag) ? ((num4 + 1) % _targets.Count) : 0);
				continue;
			}
			num4++;
			if (num4 >= _targets.Count)
			{
				flag2 = true;
				num4 = 0;
			}
		}
		if (hasQiLiMoFa && partnerLv > 0 && _targets.Count > 0)
		{
			StartCoroutine(ShootExtraBullets(position, num, flag, partnerLv switch
			{
				1 => 250104701, 
				2 => 250104702, 
				_ => 250104703, 
			}));
		}
	}

	private IEnumerator ShootExtraBullets(TSVector2 firePos, int shootCount, bool lockAttackTarget, int onceId)
	{
		List<LogicEntity> targets = new List<LogicEntity>(_targets);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(SupportSkill.extraBulletDelay));
		if (_actor == null || _actor.IsDead() || targets.Count == 0)
		{
			yield break;
		}
		int num = 0;
		bool flag = false;
		for (int i = 0; i < shootCount; i++)
		{
			LogicEntity logicEntity = targets.get_Item(num) ?? targets.get_Item(0);
			string bulletAlias = SupportSkill.bulletPaths.get_Item(i);
			AdventureActor actor = _actor;
			FP range = 0;
			FP bulletHeight = SupportSkill.bulletHeight;
			LogicEntity target = logicEntity;
			ILRuntimeAPI.Shoot(bulletAlias, actor, range, firePos, bulletHeight, default, target, AimType.Target, BulletDirectionType.BulletToTarget)?.AddAdditionalAttr(onceId);
			if (flag)
			{
				num = ((!lockAttackTarget) ? ((num + 1) % targets.Count) : 0);
				continue;
			}
			num++;
			if (num >= targets.Count)
			{
				flag = true;
				num = 0;
			}
		}
	}
}
