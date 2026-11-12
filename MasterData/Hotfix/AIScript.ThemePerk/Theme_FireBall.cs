using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.ThemePerk;

public class Theme_FireBall : BaseTheme
{
	private readonly string fireBullut = "Misc/FateCard/Theme_fireball";

	private readonly string fireBullut_11 = "Misc/FateCard/Theme_fireball_11";

	private static readonly int hitTag = CommonHelper.StringToHash("FireTag");

	private static readonly int fireTag = CommonHelper.StringToHash("FireBallHit");

	private readonly FP circleRadius = 15;

	private const string triggerFxPath = "FX/Perk/fx_perk_base_fire_trigger_s";

	private int perkId_0 = 500616;

	private int damageId_0 = 500616;

	private int maxShootRC = 8;

	private int buff_Strong = 61611;

	private FP interval = 0.75;

	private FP cd_strong = 20;

	private FP radius_strong = 15;

	private const int perkId_1 = 500601;

	private readonly FP cd_1 = 1.5;

	private readonly int prob_1 = 100;

	private readonly int damageId_1 = 500601;

	private const int perkId_2 = 500602;

	private readonly FP cd_2 = 1.5;

	private readonly int prob_2 = 100;

	private readonly int damageId_2 = 500602;

	private const int perkId_3 = 500603;

	private readonly FP cd_3 = 1.5;

	private readonly int prob_3 = 100;

	private readonly int damageId_3 = 500603;

	private const int perkId_4 = 500604;

	private readonly FP cd_4 = 1.5;

	private readonly int prob_4 = 100;

	private readonly int damageId_4 = 500604;

	private const int perkId_8 = 500608;

	private readonly FP cd_8 = 0;

	private readonly Dictionary<int, int> dicBuff_8 = new Dictionary<int, int>
	{
		[1] = 60811,
		[2] = 60821,
		[3] = 60831,
		[4] = 60841,
		[5] = 60851
	};

	private const int perkId_9 = 500609;

	private readonly FP cd_9 = 0;

	private readonly Dictionary<int, int> dicBuff_9 = new Dictionary<int, int>
	{
		[1] = 60911,
		[2] = 60921,
		[3] = 60931,
		[4] = 60941,
		[5] = 60951
	};

	private const int perkId_10 = 500610;

	private readonly FP hp_10 = 0.5;

	private readonly Dictionary<int, int> dicEff_10 = new Dictionary<int, int>
	{
		[1] = 60,
		[2] = 120,
		[3] = 180,
		[4] = 556,
		[5] = 556
	};

	private const int perkId_11 = 500611;

	private readonly Dictionary<int, int> dicCd_11 = new Dictionary<int, int>
	{
		[1] = 6,
		[2] = 6,
		[3] = 6,
		[4] = 4,
		[5] = 4
	};

	private readonly Dictionary<int, int> dicCount_11 = new Dictionary<int, int>
	{
		[1] = 4,
		[2] = 5,
		[3] = 6,
		[4] = 6,
		[5] = 6
	};

	private const int perkId_12 = 500612;

	private readonly FP cd_12 = 2;

	private readonly string hitBullut_12 = "Misc/FateCard/Theme_fireball_12";

	private readonly FP radius_12 = 10;

	private readonly Dictionary<int, int> dicCount_12 = new Dictionary<int, int>
	{
		[1] = 2,
		[2] = 4,
		[3] = 6,
		[4] = 6,
		[5] = 6
	};

	private readonly Dictionary<int, int> dicProb_12 = new Dictionary<int, int>
	{
		[1] = 100,
		[2] = 100,
		[3] = 100,
		[4] = 100,
		[5] = 100
	};

	private const int perkId_13 = 500613;

	private int basePro_13 = 50;

	private readonly Dictionary<int, int> dicPro_13 = new Dictionary<int, int>
	{
		[1] = 20,
		[2] = 25,
		[3] = 30,
		[4] = 35,
		[5] = 50
	};

	private readonly Dictionary<int, int> dicCd_13 = new Dictionary<int, int>
	{
		[1] = 3,
		[2] = 3,
		[3] = 3,
		[4] = 3,
		[5] = 3
	};

	private readonly string areaEffect_13 = "Misc/FateCard/Theme_fireball_13_Area";

	private int dicDmg_13 = 500613;

	private const int perkId_14 = 500614;

	private readonly FP cd_14 = 0;

	private string bullut_14 = "Misc/FateCard/Theme_fireball_14";

	private static readonly int bullutTag_14 = CommonHelper.StringToHash("fireball_14");

	private Dictionary<int, FP> dicRange_14 = new Dictionary<int, FP>
	{
		[1] = 4,
		[2] = 6,
		[3] = 8,
		[4] = 7,
		[5] = 7
	};

	private readonly Dictionary<int, int> dicEff_14 = new Dictionary<int, int>
	{
		[1] = 40,
		[2] = 80,
		[3] = 120,
		[4] = 20,
		[5] = 20
	};

	private string tagCastCount = "CastCount_Fire";

	private AdventureBulletBase bullutObj;

	private CoroutineNode corStrong;

	private readonly List<LogicEntity> targets = new List<LogicEntity>();

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	private bool isInStrongState => _actor.buffComponent.CheckBuffByBuffID(buff_Strong);

	public override void OnEnable()
	{
		base.OnEnable();
		if (GetPerkLv(perkId_0, out var _))
		{
			corStrong = StartLogicCoroutine(IntervalShoot());
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		foreach (CoroutineNode cor in corList)
		{
			_actor.StopLogicCoroutine(cor);
		}
		corList.Clear();
		StopLogicCoroutine(corStrong);
		ClearKey(tagCastCount);
		targets.Clear();
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		CheckShoot(500601, prob_1, cd_1, damageId_1);
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		CheckShoot(500602, prob_2, cd_2, damageId_2);
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		CheckShoot(500603, prob_3, cd_3, damageId_3);
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		CheckShoot(500604, prob_4, cd_4, damageId_4);
	}

	private void CheckShoot(int perkId, int prob, FP cd, int dmgId)
	{
		if (GetPerkLv(perkId, out var _) && CheckPerkCDTimeout(perkId, cd) && TSRandom.Range(0, 100) <= prob)
		{
			Shoot(fireBullut, _actor.attackTarget, dmgId);
			TriggerPerk(perkId);
		}
	}

	private void Shoot(string bullut, LogicEntity target, int hitDamageId)
	{
		target = ((target != null) ? target : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (!(target == null))
		{
			int hashCode = 0;
			if (GetPerkLv(500614, out var lv) && TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position) < dicRange_14.get_Item(lv) && CheckPerkCD(500614, cd_14))
			{
				bullut = bullut_14;
				hashCode = bullutTag_14;
			}
			CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_fire_trigger_s");
			string bulletAlias = bullut;
			AdventureActor actor = _actor;
			FP heightCenter = _actor.dtCollider.HeightCenter;
			LogicEntity target2 = target;
			bullutObj = ILRuntimeAPI.Shoot(bulletAlias, actor, default, default, heightCenter, default, target2, AimType.Target, BulletDirectionType.BulletToTarget);
			bullutObj.hitBox.hitDamageId = hitDamageId;
			bullutObj.ModifyBulletTag(hashCode);
			RefreshShootRC();
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		base.OnBeforeHit(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (!CommonUtils.CheckHitByTag(evt.hitDamageTag, fireTag))
		{
			return;
		}
		if (GetPerkLv(500610, out var lv) && monsterAdventureActor != null && monsterAdventureActor.actorHealthInfo.hpPercentage < hp_10)
		{
			AdventureActor.AddFromAttr(dicEff_10.get_Item(lv), _actor);
		}
		if (GetPerkLv(500614, out lv))
		{
			AdventureBullet adventureBullet = evt.weapon as AdventureBullet;
			if (adventureBullet != null && adventureBullet.CheckBulletTag(bullutTag_14))
			{
				AdventureActor.AddFromAttr(dicEff_14.get_Item(lv), _actor);
			}
		}
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		base.OnHitPre(evt);
		if (evt.hitDamageTag == null)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (!CommonUtils.CheckHitByTag(evt.hitDamageTag, fireTag))
		{
			return;
		}
		if (GetPerkLv(500608, out var lv) && CheckPerkCD(500608, cd_8))
		{
			monsterAdventureActor.buffComponent.AddBuff(dicBuff_8.get_Item(lv), _actor);
		}
		if (GetPerkLv(500609, out lv) && CheckPerkCD(500609, cd_9))
		{
			_actor.buffComponent.AddBuff(dicBuff_9.get_Item(lv), _actor);
		}
		if (GetPerkLv(500612, out lv) && TSRandom.Range(0, 100) <= dicProb_12.get_Item(lv) && CheckPerkCD(500612, cd_12) && monsterAdventureActor != null)
		{
			List<LogicEntity> list = CommonUtils.SearchNearTargetsByCircle(monsterAdventureActor, radius_12, isConfront: false, includeSelf: false);
			int num = Mathf.Min(list.Count, dicCount_12.get_Item(lv));
			for (int i = 0; i < num; i++)
			{
				LogicEntity logicEntity = list.get_Item(i);
				TSVector2 normalized = (logicEntity.tsTransform.Position - monsterAdventureActor.tsTransform.Position).normalized;
				TSVector2 position = monsterAdventureActor.tsTransform.Position + normalized * TSMath.Max(monsterAdventureActor.dtCollider.Radius + 0.5, AdventureModuleController.Config.dtRadius);
				string bulletAlias = hitBullut_12;
				AdventureActor actor = _actor;
				LogicEntity target = logicEntity;
				ILRuntimeAPI.Shoot(bulletAlias, actor, default, position, default, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
				RefreshShootRC();
			}
		}
		if (GetPerkLv(500613, out lv) && monsterAdventureActor != null)
		{
			int num2 = ((monsterAdventureActor != null && monsterAdventureActor.CheckTag(hitTag)) ? (dicPro_13.get_Item(lv) + basePro_13) : dicPro_13.get_Item(lv));
			if (TSRandom.Range(0, 100) < num2 && CheckPerkCD(500613, dicCd_13.get_Item(lv)))
			{
				CoroutineNode item = StartLogicCoroutine(DelayHit(monsterAdventureActor, areaEffect_13, dicDmg_13));
				corList.Add(item);
			}
		}
	}

	protected override void OnMonsterKilled(AdventureActorReceiveDamageEvent evt)
	{
		if (GetPerkLv(500611, out var lv) && CheckPerkCD(500611, dicCd_11.get_Item(lv)))
		{
			FP fP = TSMath.Floor(360f / (float)dicCount_11.get_Item(lv));
			TSVector2 forward = _actor.tsTransform.Forward;
			for (int i = 0; i < dicCount_11.get_Item(lv); i++)
			{
				TSVector2 tSVector = TSVector2.Rotate(forward, fP * i);
				TSVector2 tSVector2 = _actor.tsTransform.Position + tSVector.normalized * 10;
				string bulletAlias = fireBullut_11;
				AdventureActor actor = _actor;
				FP heightCenter = _actor.dtCollider.HeightCenter;
				TSVector2 targetPosition = tSVector2;
				ILRuntimeAPI.Shoot(bulletAlias, actor, default, default, heightCenter, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
				RefreshShootRC();
			}
		}
	}

	private IEnumerator DelayHit(AdventureActor to, string areaEffect, int damageId = 0)
	{
		if (to != null)
		{
			AreaEffect_AttackComponent areaEffect_AttackComponent = ILRuntimeAPI.GetAreaEffect(ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect, to.tsTransform.Position))?.GetLogicComponent<AreaEffect_AttackComponent>();
			if (areaEffect_AttackComponent != null && damageId != 0)
			{
				areaEffect_AttackComponent.hitDamageId = damageId;
			}
		}
		yield return null;
	}

	private void RefreshShootRC()
	{
		if (GetPerkLv(perkId_0, out var _) && !isInStrongState)
		{
			AddKey(tagCastCount);
			if (GetKeyCount(tagCastCount) >= maxShootRC && CheckPerkCDTimeout(perkId_0, cd_strong))
			{
				TriggerPerk(perkId_0);
				ClearKey(tagCastCount);
				EnterStrongState();
			}
		}
	}

	private void EnterStrongState()
	{
		_actor.buffComponent.AddBuff(buff_Strong, _actor);
	}

	private IEnumerator IntervalShoot()
	{
		while (true)
		{
			if (isInStrongState)
			{
				List<LogicEntity> list = CommonUtils.SearchNearTargetsByCircle(_actor, radius_strong, isConfront: true, includeSelf: false);
				for (int i = 0; i < list.Count; i++)
				{
					LogicEntity logicEntity = list.get_Item(i);
					string bulletAlias = fireBullut;
					AdventureActor actor = _actor;
					LogicEntity target = logicEntity;
					ILRuntimeAPI.Shoot(bulletAlias, actor, default, _actor.tsTransform.Position, default, default, target, AimType.Target, BulletDirectionType.BulletToTarget).hitBox.hitDamageId = damageId_0;
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(interval));
		}
	}
}
