using System;
using System.Collections.Generic;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Monster.Soldier._30601;

public class SummonSkill1 : SkillAdvancedBase
{
	private readonly string comboTag = "Attack";

	private readonly string evtFir = "Fire";

	private readonly string[] bulletAlias = new string[5] { "Bullet_Blue_Soldier", "Bullet_Green_Soldier", "Bullet_Purple_Soldier", "Bullet_Red_Soldier", "Bullet_Yellow_Soldier" };

	private readonly TSVector2 shootOffset = new TSVector2(0, 0);

	private readonly FP shootPositionY = 1.5;

	private readonly FP bulletRange = 10;

	private readonly HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.LongYi;

	private readonly FP fireInterval_Base = 3;

	private readonly FP[] fireInterval_ByTotalStar = new FP[9] { 3, 2.7, 2.4, 2.1, 1.8, 1.5, 1.2, 0.9, 0.9 };

	private FP _fireTimer;

	private readonly List<AdventureActor> _enemyBuffer = new List<AdventureActor>();

	private readonly List<SoldierActor> _allyBuffer = new List<SoldierActor>();

	private FP waitime;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_fireTimer = 0;
	}

	public void OnStart()
	{
		_fireTimer = GetFireInterval();
		waitime = _fireTimer;
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboLoop = OnComboLoop;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, null, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, evtFir))
		{
			ShootAtRandomEnemy();
		}
	}

	private void OnComboLoop()
	{
		comboAttack?.CancelAttack();
	}

	public void OnUpdate()
	{
		if (_fireTimer > 0)
		{
			_fireTimer -= _actor.LogicDeltaTime;
			return;
		}
		_fireTimer = waitime;
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboLoop = OnComboLoop;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, null, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void ShootAtRandomEnemy()
	{
		string value = PickRandomBulletAlias();
		if (!string.IsNullOrEmpty(value))
		{
			TSVector2 shootPosition = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset.x + _actor.tsTransform.Forward * shootOffset.y;
			AdventureActor adventureActor = PickRandomEnemy();
			TSVector2 targetPosition = _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * bulletRange;
			if (adventureActor != null)
			{
				targetPosition = adventureActor.tsTransform.Position;
			}
			ILRuntimeAPI.FanMultipleShoot(_actor, value, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, shootPosition, shootPositionY, _actor.tsTransform.Forward, 0, AimType.Position, BulletDirectionType.BulletToTarget, 1, 1, 0, targetPosition);
		}
	}

	private string PickRandomBulletAlias()
	{
		if (bulletAlias == null || bulletAlias.Length == 0)
		{
			return null;
		}
		return bulletAlias[TSRandom.Range(0, bulletAlias.Length)];
	}

	private AdventureActor PickRandomEnemy()
	{
		_enemyBuffer.Clear();
		List<AdventureActor> confrontFactionActors = ILRuntimeAPI.GetConfrontFactionActors(_actor);
		if (confrontFactionActors == null)
		{
			return null;
		}
		for (int i = 0; i < confrontFactionActors.Count; i++)
		{
			AdventureActor adventureActor = confrontFactionActors.get_Item(i);
			if (!(adventureActor == null))
			{
				ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
				{
					_enemyBuffer.Add(adventureActor);
				}
			}
		}
		if (_enemyBuffer.Count == 0)
		{
			return null;
		}
		return _enemyBuffer.get_Item(TSRandom.Range(0, _enemyBuffer.Count));
	}

	private FP GetFireInterval()
	{
		int totalMemberStarLv = GetTotalMemberStarLv();
		if (totalMemberStarLv < 1 || fireInterval_ByTotalStar.Length == 0)
		{
			return fireInterval_Base;
		}
		int num = totalMemberStarLv - 1;
		if (num >= fireInterval_ByTotalStar.Length)
		{
			num = fireInterval_ByTotalStar.Length - 1;
		}
		return fireInterval_ByTotalStar[num];
	}

	private int GetTotalMemberStarLv()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return 0;
		}
		SoldierActor soldierActor = (_actor as SoldierActor) ?? soldierLevelController.mainControlActor;
		if (soldierActor == null)
		{
			return 0;
		}
		List<SoldierActor> allActors = soldierLevelController.GetAllActors(soldierActor, _allyBuffer);
		int num = 0;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor2 = allActors.get_Item(i);
			if (!(soldierActor2 == null) && soldierActor2.HasPartnerType(partnerType))
			{
				num += soldierActor2.GetPotentialLv();
			}
		}
		return num;
	}

	private void CollectMemberDataIds(SoldierLevelController levelController)
	{
		Dictionary<int, List<int>> partnerDic = levelController.PartnerDic;
		if (partnerDic == null)
		{
			return;
		}
		foreach (KeyValuePair<int, List<int>> item in partnerDic)
		{
			SoldierPartner soldierPartner = Singleton<HotfixDataController>.Instance.GetSoldierPartner(item.Key);
			if (soldierPartner == null || soldierPartner.PartnerType != (int)partnerType)
			{
				continue;
			}
			List<int> value = item.Value;
			if (value != null)
			{
				for (int i = 0; i < value.Count; i++)
				{
				}
			}
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_fireTimer = 0;
		_enemyBuffer.Clear();
		_allyBuffer.Clear();
	}
}
