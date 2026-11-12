using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.ThemePerk;

public class Theme_Shark : BaseTheme
{
	private readonly string sharkBullut = "Misc/FateCard/Theme_Shark_Bullet_base";

	private FP baseDelayTime = 0.5;

	private static readonly int hitTag_shark = CommonHelper.StringToHash("Shark");

	private static readonly int hitTag_shark_strong = CommonHelper.StringToHash("Shark_Strong");

	private static readonly int hitMask_water = CommonHelper.StringToHash("WaterTag");

	private static readonly int hitTag_shark_small = CommonHelper.StringToHash("Shark_Small");

	private readonly FP circleRadius = 15;

	private const string triggerFxPath = "";

	private const int perkId_1 = 501401;

	private readonly FP cd_1 = 3.5;

	private readonly int prob_1 = 100;

	private readonly int damageId_1 = 501401;

	private const int perkId_2 = 501402;

	private readonly FP cd_2 = 3.5;

	private readonly int prob_2 = 100;

	private readonly int damageId_2 = 501402;

	private const int perkId_3 = 501403;

	private readonly FP cd_3 = 3.5;

	private readonly int prob_3 = 100;

	private readonly int damageId_3 = 501403;

	private const int perkId_4 = 501404;

	private readonly FP cd_4 = 3.5;

	private readonly int prob_4 = 100;

	private readonly int damageId_4 = 501404;

	private const int perkId_8 = 501408;

	private readonly Dictionary<int, FP> dicAddSpd_8 = new Dictionary<int, FP>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 3,
		[5] = 4
	};

	private readonly Dictionary<int, int> dicOnce_8 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 60,
		[3] = 90,
		[4] = 20,
		[5] = 20
	};

	private const int perkId_9 = 501409;

	private readonly Dictionary<int, int> dicOnce_9 = new Dictionary<int, int>
	{
		[1] = 50,
		[2] = 100,
		[3] = 150,
		[4] = 30,
		[5] = 30
	};

	private readonly Dictionary<int, FP> dicHp_9 = new Dictionary<int, FP>
	{
		[1] = 0.5,
		[2] = 0.5,
		[3] = 0.5,
		[4] = 0.8,
		[5] = 0.9
	};

	private const int perkId_10 = 501410;

	private readonly Dictionary<int, int> dicBuff_10 = new Dictionary<int, int>
	{
		[1] = 141011,
		[2] = 141021,
		[3] = 141031,
		[4] = 141041,
		[5] = 141051
	};

	private const int perkId_11 = 501411;

	private readonly Dictionary<int, int> dicOnce_11 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 60,
		[3] = 90,
		[4] = 40,
		[5] = 50
	};

	private List<int> buffTag_12 = new List<int>
	{
		CommonHelper.StringToHash("减速"),
		CommonHelper.StringToHash("束缚"),
		CommonHelper.StringToHash("WaterTag1")
	};

	private const int perkId_12 = 501412;

	private readonly FP cd_12 = 3;

	private string aoe_12_base = "Misc/FateCard/Theme_Shark_Area_12_base";

	private string aoe_12_high = "Misc/FateCard/Theme_Shark_Area_12_high";

	private const int perkId_13 = 501413;

	private readonly FP cd_13 = 8;

	private string summonEffect_13 = "FX/Perk/fx_perk_loop_water_shark_standby_13";

	private FP circleInner_13 = 3;

	private FP circleOuter_13 = 7;

	private FP interval_13 = 1;

	private Dictionary<int, int> dicCount_13 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 3,
		[5] = 3
	};

	private int hitDmgId_13 = 501413;

	private Dictionary<int, int> dicPro_13 = new Dictionary<int, int>
	{
		[1] = 20,
		[2] = 40,
		[3] = 60,
		[4] = 50,
		[5] = 60
	};

	private const int perkId_14 = 501414;

	private readonly FP cd_14 = 10;

	private int hitDmgId_14 = 501414;

	private string bullut_14 = "Misc/FateCard/Theme_Shark_Bullet_14";

	private string drop_14 = "";

	private readonly Dictionary<int, int> dicBuff_14 = new Dictionary<int, int>
	{
		[1] = 141411,
		[2] = 141421,
		[3] = 141431,
		[4] = 141441,
		[5] = 141451
	};

	private const int perkId_15 = 501415;

	private FP circleInner_15 = 0;

	private FP circleOuter_15 = 1;

	private string summonEffect_15 = "FX/Perk/fx_perk_loop_water_shark_standby_13";

	private int hitDmgId_15 = 501415;

	private readonly Dictionary<int, int> dicBuff_15 = new Dictionary<int, int>
	{
		[1] = 141511,
		[2] = 141521,
		[3] = 141531,
		[4] = 141541,
		[5] = 141551
	};

	private readonly Dictionary<int, int> dicInterval_15 = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 4,
		[3] = 3,
		[4] = 5,
		[5] = 5
	};

	private const int perkId_16 = 501416;

	private string drop_16 = "Misc/FateCard/Theme_Shark_Drop_16";

	private int hitDmgId_16 = 501416;

	private readonly Dictionary<int, int> dicInterval_16 = new Dictionary<int, int> { [1] = 5 };

	private const int perkId_17 = 501417;

	private string bullut_17 = "Misc/FateCard/Theme_Shark_Bullet_base_17";

	private Dictionary<int, int> dicOnce_17 = new Dictionary<int, int> { [1] = 50 };

	private Dictionary<int, FP> dicHp_17 = new Dictionary<int, FP> { [1] = 0.5 };

	private const int perkId_18 = 501418;

	private int count_18 = 3;

	private string bullut_18 = "Misc/FateCard/Theme_Shark_Bullet_18";

	private int hitDmgId_18 = 501418;

	private Dictionary<int, int> dicBuff_18 = new Dictionary<int, int> { [1] = 4011 };

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	private LogicEntity curMarkedMonster;

	private int perk15Lv;

	private int perk16Lv;

	private HashSet<long> dropHash_14 = new HashSet<long>();

	private HashSet<long> dropHash_16 = new HashSet<long>();

	private int shootCount;

	private PlayFX playFX_perk13 = new PlayFX();

	private PlayFX playFX_perk15 = new PlayFX();

	private static readonly int bullutTag = CommonHelper.StringToHash("Shark");

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		if (GetPerkLv(501415, out perk15Lv))
		{
			CoroutineNode item = StartLogicCoroutine(IntervalMark());
			corList.Add(item);
		}
		if (GetPerkLv(501416, out perk16Lv))
		{
			CoroutineNode item2 = StartLogicCoroutine(IntervalDrop());
			corList.Add(item2);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		foreach (CoroutineNode cor in corList)
		{
			_actor.StopLogicCoroutine(cor);
		}
		corList.Clear();
		dropHash_14.Clear();
		dropHash_16.Clear();
		shootCount = 0;
		playFX_perk13.Stop();
		playFX_perk15.Stop();
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		CheckShoot(501401, prob_1, cd_1, damageId_1);
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		CheckShoot(501402, prob_2, cd_2, damageId_2);
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		CheckShoot(501403, prob_3, cd_3, damageId_3);
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		CheckShoot(501404, prob_4, cd_4, damageId_4);
	}

	private void CheckShoot(int perkId, int prob, FP cd, int dmgId)
	{
		if (GetPerkLv(perkId, out var _) && CheckPerkCDTimeout(perkId, cd) && TSRandom.Range(0, 100) <= prob)
		{
			Shoot(sharkBullut, _actor.attackTarget, dmgId);
			TriggerPerk(perkId);
		}
	}

	private void Shoot(string bullut, LogicEntity target, int hitDamageId)
	{
		target = ((target != null) ? target : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (!(target == null))
		{
			CommonUtils.PlayOneOffFx(_actor, "");
			string bullut2 = GetBullut();
			AdventureActor actor = _actor;
			FP heightCenter = _actor.dtCollider.HeightCenter;
			LogicEntity target2 = target;
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bullut2, actor, default, default, heightCenter, default, target2, AimType.Target, BulletDirectionType.BulletToTarget);
			adventureBulletBase.hitBox.hitDamageId = hitDamageId;
			if (GetPerkLv(501418, out var _) && string.Equals(bullut2, bullut_18))
			{
				adventureBulletBase.hitBox.hitDamageId = hitDmgId_18;
			}
			FixBullutInfo(adventureBulletBase, adventureBulletBase.hitBox.hitDamageId);
			RefreshCount(bullut2);
			if (GetPerkLv(501408, out var lv2))
			{
				adventureBulletBase.velocitySpeed += dicAddSpd_8.get_Item(lv2);
			}
		}
	}

	private string GetBullut()
	{
		if (GetPerkLv(501417, out var lv))
		{
			return bullut_17;
		}
		if (GetPerkLv(501418, out lv) && shootCount >= count_18)
		{
			shootCount = 0;
			return bullut_18;
		}
		return sharkBullut;
	}

	private void RefreshCount(string tempBullut)
	{
		if (GetPerkLv(501418, out var _) && string.Equals(tempBullut, sharkBullut))
		{
			shootCount++;
		}
	}

	protected override void OnNoDmgHit(AdventureActorNoDamageEvent evt)
	{
		base.OnNoDmgHit(evt);
		if (evt.weapon != null && evt.weapon.CheckBulletTag(bullutTag))
		{
			CoroutineNode item = StartLogicCoroutine(DelayHit(evt.to, evt.weapon.temphitDmgId), runImmediately: true);
			corList.Add(item);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		base.OnBeforeHit(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null))
		{
			return;
		}
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark_strong);
		if (!(flag | flag2))
		{
			return;
		}
		if (GetPerkLv(501408, out var lv))
		{
			AdventureActor.AddFromAttr(dicOnce_8.get_Item(lv), _actor);
		}
		if (GetPerkLv(501409, out lv) && monsterAdventureActor.actorHealthInfo.hpPercentage < dicHp_9.get_Item(lv))
		{
			AdventureActor.AddFromAttr(dicOnce_9.get_Item(lv), _actor);
		}
		if (!GetPerkLv(501411, out lv))
		{
			return;
		}
		for (int i = 0; i < buffTag_12.Count; i++)
		{
			if (monsterAdventureActor.buffComponent.CheckBuffByBuffTag(buffTag_12.get_Item(i)))
			{
				AdventureActor.SetFromForceCrit(val: true);
				AdventureActor.AddFromAttr(dicOnce_11.get_Item(lv), _actor);
				break;
			}
		}
	}

	protected override void OnBeforeHurt(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		base.OnBeforeHurt(evt);
		if (evt.to as PlayerAdventureActor != null && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark_small) && GetPerkLv(501414, out var lv))
		{
			_actor.buffComponent.AddBuff(dicBuff_14.get_Item(lv), _actor);
		}
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		base.OnHitPre(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null))
		{
			return;
		}
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark_strong);
		if (!(flag | flag2))
		{
			return;
		}
		if (GetPerkLv(501410, out var lv))
		{
			monsterAdventureActor.buffComponent.AddBuff(dicBuff_10.get_Item(lv), _actor);
		}
		if (GetPerkLv(501413, out lv) && (CommonUtils.CheckElementMark(CommonDefine.Water, monsterAdventureActor) || TSRandom.Range(0, 100) < dicPro_13.get_Item(lv)) && CheckPerkCD(501413, cd_13))
		{
			TSVector2 tSVector = CommonUtils.RandomReachablePointInsideRing(_actor, _actor.tsTransform.Position, circleInner_13, circleOuter_13);
			playFX_perk13.Play(_actor, null, summonEffect_13, _actor.tsTransform.PositionY, tSVector, _actor.tsTransform.Forward);
			CoroutineNode item = StartLogicCoroutine(IntervalShoot(monsterAdventureActor, tSVector, dicCount_13.get_Item(lv)));
			corList.Add(item);
		}
		if (GetPerkLv(501417, out lv))
		{
			if (monsterAdventureActor.IsBossMonster())
			{
				AdventureActor.AddFromAttr(dicOnce_17.get_Item(lv), _actor);
			}
			else if (monsterAdventureActor.actorHealthInfo.hpPercentage < dicHp_17.get_Item(lv))
			{
				monsterAdventureActor.Kill(_actor);
			}
		}
		if (GetPerkLv(501418, out lv) & flag2)
		{
			monsterAdventureActor.buffComponent.AddBuff(dicBuff_18.get_Item(lv), _actor);
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent evt)
	{
		base.OnHitPost(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null))
		{
			return;
		}
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark_strong);
		if (flag | flag2)
		{
			if (GetPerkLv(501412, out var lv) && evt.isKill && CheckPerkCD(501412, cd_12))
			{
				string areaEffect = (flag2 ? aoe_12_high : aoe_12_base);
				CoroutineNode item = StartLogicCoroutine(DelayHit(monsterAdventureActor, areaEffect));
				corList.Add(item);
			}
			if (GetPerkLv(501414, out lv) && CheckPerkCD(501414, cd_14))
			{
				string bulletAlias = bullut_14;
				TSVector2 position = monsterAdventureActor.tsTransform.Position;
				FP heightCenter = _actor.dtCollider.HeightCenter;
				LogicEntity actor = _actor;
				ILRuntimeAPI.Shoot(bulletAlias, monsterAdventureActor, default, position, heightCenter, default, actor, AimType.Target, BulletDirectionType.BulletToTarget).hitBox.hitDamageId = hitDmgId_14;
			}
		}
	}

	protected override void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
		base.OnHurt(evt);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark_strong);
		if ((flag | flag2) && GetPerkLv(501414, out var lv))
		{
			_actor.buffComponent.AddBuff(dicBuff_14.get_Item(lv), _actor);
		}
	}

	private void OnDropFinish(IEvent evt)
	{
		AdventureDropFinishEvent obj = evt as AdventureDropFinishEvent;
		long entityID = obj.entityID;
		if (obj.isPickUp && GetPerkLv(501416, out var _) && dropHash_16.Contains(entityID))
		{
			LogicEntity logicEntity = ((_actor.attackTarget != null) ? _actor.attackTarget : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
			if (logicEntity != null)
			{
				string bullut = GetBullut();
				AdventureActor actor = _actor;
				TSVector2 position = logicEntity.tsTransform.Position;
				ILRuntimeAPI.Shoot(bullut, actor, default, default, default, position, null, AimType.Position, BulletDirectionType.BulletToTarget).hitBox.hitDamageId = hitDmgId_16;
				RefreshCount(bullut);
			}
			dropHash_16.Remove(entityID);
		}
	}

	private IEnumerator DelayHit(AdventureActor to, string areaEffect, int damageId = 0)
	{
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect, to.tsTransform.Position);
		yield return null;
	}

	private IEnumerator IntervalMark()
	{
		dicInterval_15.get_Item(perk15Lv);
		FP curTime = 0;
		while (true)
		{
			if (curMarkedMonster == null || curMarkedMonster.IsDead())
			{
				curMarkedMonster = null;
				List<LogicEntity> list = CommonUtils.SearchNearTargetsByCircle(_actor, circleRadius, isConfront: true, includeSelf: false);
				if (list.Count > 0)
				{
					IOrderedEnumerable<LogicEntity> source = list.OrderBy((LogicEntity logicEntity) => (logicEntity as AdventureActor).actorHealthInfo.hp);
					curMarkedMonster = source.First();
					(curMarkedMonster as AdventureActor).buffComponent.AddBuff(dicBuff_15.get_Item(perk15Lv), _actor);
				}
			}
			else if (curTime < 0 && curMarkedMonster != null)
			{
				TSVector2 tSVector = CommonUtils.RandomReachablePointInsideRing(_actor, curMarkedMonster.tsTransform.Position, circleInner_15, circleOuter_15);
				playFX_perk15.Play(_actor, null, summonEffect_15, curMarkedMonster.tsTransform.PositionY, tSVector, _actor.tsTransform.Forward);
				CoroutineNode item = StartLogicCoroutine(DelayShoot(curMarkedMonster, tSVector, hitDmgId_15, 0.5f), runImmediately: true);
				corList.Add(item);
				curTime = dicInterval_15.get_Item(perk15Lv);
			}
			curTime -= LogicDeltaTime;
			yield return null;
		}
	}

	private IEnumerator IntervalDrop()
	{
		int rawTime = dicInterval_16.get_Item(perk16Lv);
		FP curTime = 0;
		while (true)
		{
			if (curTime < 0)
			{
				long num = ILRuntimeAPI.PlayDrop(_actor, drop_16);
				if (num > 0)
				{
					dropHash_16.Add(num);
				}
				curTime = rawTime;
			}
			curTime -= LogicDeltaTime;
			yield return null;
		}
	}

	private IEnumerator IntervalShoot(LogicEntity target, TSVector2 startPos, int count)
	{
		yield return 0.5f;
		int i = 0;
		while (i < count && !target.IsDead())
		{
			string bullut = GetBullut();
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bullut, _actor, default, startPos, _actor.dtCollider.HeightCenter, target.tsTransform.Position, null, AimType.Position, BulletDirectionType.BulletToTarget);
			adventureBulletBase.hitBox.hitDamageId = hitDmgId_13;
			if (GetPerkLv(501418, out var lv))
			{
				adventureBulletBase.hitBox.hitDamageId = hitDmgId_18;
			}
			FixBullutInfo(adventureBulletBase, adventureBulletBase.hitBox.hitDamageId);
			RefreshCount(bullut);
			yield return interval_13;
			lv = i++;
		}
		playFX_perk13.Stop();
	}

	private IEnumerator DelayShoot(LogicEntity to, TSVector2 shootPos, int hitDmgId, FP delayTime)
	{
		yield return delayTime;
		string bullut = GetBullut();
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bullut, _actor, default, shootPos, _actor.dtCollider.HeightCenter, to.tsTransform.Position, null, AimType.Position, BulletDirectionType.BulletToTarget);
		adventureBulletBase.hitBox.hitDamageId = hitDmgId;
		if (GetPerkLv(501418, out var _))
		{
			adventureBulletBase.hitBox.hitDamageId = hitDmgId_18;
		}
		FixBullutInfo(adventureBulletBase, adventureBulletBase.hitBox.hitDamageId);
		RefreshCount(bullut);
		playFX_perk15.Stop();
	}

	private IEnumerator DelayHit(LogicEntity to, int hitDmgId)
	{
		yield return baseDelayTime;
		ILRuntimeAPI.HitActor(_actor, to as AdventureActor, hitDmgId);
	}

	private void FixBullutInfo(AdventureBulletBase bullCom, int finalHitDmgId)
	{
		bullCom.temphitDmgId = finalHitDmgId;
		bullCom.hitBox.hitDamageId = -3;
		bullCom.ModifyBulletTag(bullutTag);
	}
}
