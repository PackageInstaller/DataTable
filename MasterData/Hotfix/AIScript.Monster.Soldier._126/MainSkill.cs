using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._126;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "MainSkill";

	private const string fireEvent = "Fire";

	private const string bulletPath = "Bullet_Soldier_12601_MainSkill";

	private static readonly FP bulletHeight = 1.5;

	private static readonly FP bulletRange = 10;

	public const int onceId_partner_1 = 250104701;

	public const int onceId_partner_2 = 250104702;

	public const int onceId_partner_3 = 250104703;

	private static readonly FP extraBulletDelay = 0.2;

	private bool hasQiLiMoFa;

	private int partnerLv;

	private readonly List<LogicEntity> _searchBuffer = new List<LogicEntity>();

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		hasQiLiMoFa = (_actor as SoldierActor).HasPartnerType(HotfixEnum.ChessPartnerType.QiLiMoFa);
		if (hasQiLiMoFa)
		{
			partnerLv = (ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController)?.GetPartnerLv(HotfixEnum.ChessPartnerType.QiLiMoFa) ?? 0;
		}
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("MainSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			ShootBullet();
		}
	}

	private void ShootBullet()
	{
		TSVector2 position = _actor.tsTransform.Position;
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = bulletHeight;
			LogicEntity attackTarget = _actor.attackTarget;
			ILRuntimeAPI.Shoot("Bullet_Soldier_12601_MainSkill", actor, range, position, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection("Bullet_Soldier_12601_MainSkill", _actor, bulletRange, _actor.tsTransform.Forward, position, bulletHeight);
		}
		if (hasQiLiMoFa && partnerLv > 0)
		{
			AdventureActor adventureActor = FindOtherConfrontTarget();
			if (!(adventureActor == null))
			{
				StartCoroutine(ShootExtraBullet(position, adventureActor, partnerLv switch
				{
					1 => 250104701, 
					2 => 250104702, 
					_ => 250104703, 
				}));
			}
		}
	}

	private IEnumerator ShootExtraBullet(TSVector2 firePos, LogicEntity target, int onceId)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(extraBulletDelay));
		if (!(_actor == null) && !_actor.IsDead())
		{
			ILRuntimeAPI.Shoot("Bullet_Soldier_12601_MainSkill", _actor, 0, firePos, bulletHeight, default, target, AimType.Target, BulletDirectionType.BulletToTarget)?.AddAdditionalAttr(onceId);
		}
	}

	private AdventureActor FindOtherConfrontTarget()
	{
		_searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, _searchBuffer);
		LogicEntity attackTarget = _actor.attackTarget;
		for (int i = 0; i < _searchBuffer.Count; i++)
		{
			if (_searchBuffer.get_Item(i) is AdventureActor adventureActor && (!(attackTarget != null) || adventureActor.Id != attackTarget.Id))
			{
				ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
				{
					return adventureActor;
				}
			}
		}
		return null;
	}
}
