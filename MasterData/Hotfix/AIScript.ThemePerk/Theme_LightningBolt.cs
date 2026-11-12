using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.ThemePerk;

public class Theme_LightningBolt : BaseTheme
{
	private readonly string fireBullut = "Misc/FateCard/Theme_LightningBolt";

	private readonly string strongBullut = "Misc/FateCard/Theme_LightningBolt_1q1";

	private readonly string fireBullut_Big = "Misc/FateCard/Theme_LightningBolt_08";

	private readonly string strongBullut_Big = "Misc/FateCard/Theme_LightningBolt_11q1";

	private static readonly int fireTag = CommonHelper.StringToHash("Lightning");

	private static readonly int fireTag2 = CommonHelper.StringToHash("LightningPro");

	private static readonly int bullutTag_strong = CommonHelper.StringToHash("LightPro");

	private static readonly int lightMaskTag = CommonHelper.StringToHash("LightTag");

	private readonly FP circleRadius = 5;

	private const string triggerFxPath = "FX/Perk/fx_perk_base_light_trigger_s";

	private readonly FP delayTime = 0.2f;

	private Dictionary<int, int> dicDamageId = new Dictionary<int, int>
	{
		[1] = 500715,
		[2] = 500715,
		[3] = 500715,
		[4] = 500715
	};

	private readonly int perkId_0 = 500716;

	private readonly FP cd_0 = 1;

	private int maxShootRC = 10;

	private int buff_Strong = 70011;

	private readonly int perkId_1 = 500701;

	private readonly FP cd_1 = 2.5;

	private readonly int prob_1 = 100;

	private readonly int damageId_1 = 500701;

	private readonly int eff_1 = 312;

	private readonly int perkId_2 = 500702;

	private readonly FP cd_2 = 2.5;

	private readonly int prob_2 = 100;

	private readonly int damageId_2 = 500702;

	private readonly int eff_2 = 312;

	private readonly int perkId_3 = 500703;

	private readonly FP cd_3 = 2.5;

	private readonly int prob_3 = 100;

	private readonly int damageId_3 = 500703;

	private readonly int eff_3 = 312;

	private readonly int perkId_4 = 500704;

	private readonly FP cd_4 = 2.5;

	private readonly int prob_4 = 100;

	private readonly int damageId_4 = 500704;

	private readonly int eff_4 = 312;

	private readonly int perkId_6 = 500706;

	private FP cd_6 = 0;

	private readonly Dictionary<int, int> dicBuff_6 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 1,
		[3] = 1,
		[4] = 1,
		[5] = 1
	};

	private readonly int perkId_8 = 500708;

	private FP cd_8 = 0;

	private readonly Dictionary<int, int> dicEff_8 = new Dictionary<int, int>
	{
		[1] = 25,
		[2] = 50,
		[3] = 75,
		[4] = 40,
		[5] = 50
	};

	private readonly int perkId_9 = 500709;

	private readonly FP cd_9 = 0;

	private readonly Dictionary<int, int> dicEff_9 = new Dictionary<int, int>
	{
		[1] = 310,
		[2] = 315,
		[3] = 320,
		[4] = 312,
		[5] = 315
	};

	private readonly int perkId_10 = 500710;

	private readonly FP cd_10 = 0;

	private readonly FP hp_10 = 0.8f;

	private readonly Dictionary<int, int> dicEff_10 = new Dictionary<int, int>
	{
		[1] = 40,
		[2] = 80,
		[3] = 120,
		[4] = 80,
		[5] = 80
	};

	private const int perkId_11 = 500711;

	private readonly FP cd_11 = 3;

	private readonly int buff_11 = 70911;

	private readonly Dictionary<int, int> dicProb_11 = new Dictionary<int, int>
	{
		[1] = 50,
		[2] = 75,
		[3] = 100
	};

	private const int perkId_12 = 500712;

	private int basePro_12 = 100;

	private readonly Dictionary<int, int> dicPro_12 = new Dictionary<int, int>
	{
		[1] = 10,
		[2] = 20,
		[3] = 30,
		[4] = 40,
		[5] = 50
	};

	private readonly Dictionary<int, int> dicEnergy_12 = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 10,
		[3] = 15,
		[4] = 20,
		[5] = 25
	};

	private readonly Dictionary<int, FP> dicCd_12 = new Dictionary<int, FP>
	{
		[1] = 1,
		[2] = 1,
		[3] = 1,
		[4] = 1,
		[5] = 1
	};

	private const int perkId_13 = 500713;

	private readonly FP cd_13 = 2;

	private readonly Dictionary<int, int> dicCount_13 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 3,
		[5] = 3
	};

	private readonly Dictionary<int, int> dicEff_13 = new Dictionary<int, int>
	{
		[1] = 400,
		[2] = 400,
		[3] = 400,
		[4] = 400,
		[5] = 400
	};

	private const int perkId_14 = 500714;

	private int hurtCount_14 = 3;

	private readonly FP cd_14 = 2;

	private readonly Dictionary<int, int> dicCount_14 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 3,
		[5] = 3
	};

	private readonly Dictionary<int, int> dicEff_14 = new Dictionary<int, int>
	{
		[1] = 400,
		[2] = 400,
		[3] = 400,
		[4] = 400,
		[5] = 400
	};

	private AdventureTimeBomb bullutObj;

	private string tagHitCount = "HitCount";

	private string tagCastCount = "CastCount_Blot";

	private readonly Dictionary<LogicEntity, int> hitMonsterSet = new Dictionary<LogicEntity, int>();

	private readonly Dictionary<LogicEntity, FP> hitMonsterDic = new Dictionary<LogicEntity, FP>();

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	private bool isInStrongState => _actor.buffComponent.CheckBuffByBuffID(buff_Strong);

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		foreach (CoroutineNode cor in corList)
		{
			_actor.StopLogicCoroutine(cor);
		}
		corList.Clear();
		hitMonsterSet.Clear();
		hitMonsterDic.Clear();
		ClearKey(tagCastCount);
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		CheckShoot(perkId_1, 1, prob_1, cd_1, damageId_1);
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		CheckShoot(perkId_2, 2, prob_2, cd_2, damageId_2);
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		CheckShoot(perkId_3, 3, prob_3, cd_3, damageId_3);
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		CheckShoot(perkId_4, 4, prob_4, cd_4, damageId_4);
		if (GetPerkLv(perkId_6, out var lv) && CheckPerkCD(perkId_6, cd_6))
		{
			_actor.buffComponent.AddBuff(dicBuff_6.get_Item(lv), _actor);
		}
	}

	private void CheckShoot(int perkId, int perkIndex, int prob, FP cd, int dmgId)
	{
		if (GetPerkLv(perkId, out var _) && CheckPerkCDTimeout(perkId, cd) && TSRandom.Range(0, 100) <= prob)
		{
			Shoot(perkIndex, _actor.attackTarget, dmgId);
			TriggerPerk(perkId);
		}
	}

	private void Shoot(int perkIndex, LogicEntity target, int hitDamageId)
	{
		target = ((target != null) ? target : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (!(target == null))
		{
			CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_light_trigger_s");
			string bullul = GetBullul();
			AdventureActor actor = _actor;
			TSVector2 position = target.tsTransform.Position;
			TSVector2 position2 = target.tsTransform.Position;
			bullutObj = ILRuntimeAPI.Shoot(bullul, actor, default, position, default, position2, null, AimType.Position, BulletDirectionType.BulletToTarget) as AdventureTimeBomb;
			bullutObj.hitBox.hitDamageId = hitDamageId;
			bullutObj.ModifyBulletTag(0);
			if (isInStrongState)
			{
				bullutObj.hitBox.hitDamageId = dicDamageId.get_Item(perkIndex);
			}
			if (GetPerkLv(perkId_0, out var _) && !isInStrongState)
			{
				AddKey(tagCastCount);
				RefreshShootRC();
			}
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		base.OnBeforeHit(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, fireTag);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, fireTag2);
		if (!(flag | flag2))
		{
			return;
		}
		if (GetPerkLv(perkId_1, out var lv) && evt.perkSlot == HotfixEnum.perkSlot.NormalAttack)
		{
			AdventureActor.AddFromAttr(eff_1, _actor);
		}
		if (GetPerkLv(perkId_2, out lv) && evt.perkSlot == HotfixEnum.perkSlot.Dodge)
		{
			AdventureActor.AddFromAttr(eff_2, _actor);
		}
		if (GetPerkLv(perkId_3, out lv) && evt.perkSlot == HotfixEnum.perkSlot.CastSkill)
		{
			AdventureActor.AddFromAttr(eff_3, _actor);
		}
		if (GetPerkLv(perkId_4, out lv) && evt.perkSlot == HotfixEnum.perkSlot.Behit)
		{
			AdventureActor.AddFromAttr(eff_4, _actor);
		}
		if (GetPerkLv(perkId_8, out lv))
		{
			AdventureActor.AddFromAttr(dicEff_8.get_Item(lv), _actor);
		}
		if (GetPerkLv(perkId_9, out lv) && CheckPerkCD(perkId_9, cd_9) && monsterAdventureActor != null && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
		{
			AdventureActor.AddFromAttr(dicEff_9.get_Item(lv), _actor);
		}
		if (GetPerkLv(perkId_10, out lv) && _actor.actorHealthInfo.hpPercentage > hp_10)
		{
			AdventureActor.AddFromAttr(dicEff_10.get_Item(lv), _actor);
		}
		if (GetPerkLv(500712, out lv))
		{
			int num = ((monsterAdventureActor != null && CommonUtils.CheckElementMark(CommonDefine.Light, monsterAdventureActor)) ? (dicPro_12.get_Item(lv) + basePro_12) : dicPro_12.get_Item(lv));
			if (TSRandom.Range(0, 100) < num && CheckPerkCD(500712, dicCd_12.get_Item(lv)))
			{
				SceneSingleton<AdventurePlayerController>.Instance.AddEnergy(dicEnergy_12.get_Item(lv));
				AdventureActor.SetFromForceCrit(val: true);
			}
		}
		if (GetPerkLv(500713, out lv))
		{
			AdventureTimeBomb adventureTimeBomb = evt.weapon as AdventureTimeBomb;
			if (adventureTimeBomb != null && adventureTimeBomb.CheckBulletTag(bullutTag_strong))
			{
				AdventureActor.AddFromAttr(dicEff_13.get_Item(lv), _actor);
			}
		}
		if (GetPerkLv(500714, out lv))
		{
			AdventureTimeBomb adventureTimeBomb2 = evt.weapon as AdventureTimeBomb;
			if (adventureTimeBomb2 != null && adventureTimeBomb2.CheckBulletTag(bullutTag_strong))
			{
				AdventureActor.AddFromAttr(dicEff_14.get_Item(lv), _actor);
			}
		}
	}

	protected override void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
		base.OnCrit(evt);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, fireTag);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, fireTag2);
		if (!(flag | flag2) || !GetPerkLv(500713, out var lv))
		{
			return;
		}
		LogicEntity logicEntity = ((_actor.attackTarget != null) ? _actor.attackTarget : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (logicEntity != null && CheckPerkCD(500713, cd_13))
		{
			int hitDamageConfigId = evt.hitDamageConfigId;
			string bullut;
			if (GetPerkLv(500711, out var _))
			{
				bullut = (isInStrongState ? strongBullut_Big : fireBullut_Big);
			}
			else
			{
				bullut = (isInStrongState ? strongBullut : fireBullut);
			}
			TSVector2 position = logicEntity.tsTransform.Position;
			CoroutineNode item = StartLogicCoroutine(DelayShoot(bullut, hitDamageConfigId, position, position, dicCount_13.get_Item(lv)));
			corList.Add(item);
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
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, fireTag);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, fireTag2);
		if (!(flag | flag2))
		{
			return;
		}
		if (GetPerkLv(500711, out var lv) && TSRandom.Range(0, 100) <= dicProb_11.get_Item(lv) && monsterAdventureActor != null)
		{
			monsterAdventureActor.buffComponent.AddBuff(buff_11, _actor);
		}
		if (!(GetPerkLv(500714, out lv) & flag) || !(monsterAdventureActor != null))
		{
			return;
		}
		monsterAdventureActor.AddTag(tagHitCount);
		if (monsterAdventureActor.GetTagCount(tagHitCount) >= hurtCount_14)
		{
			int hitDamageConfigId = evt.hitDamageConfigId;
			string bullut = strongBullut;
			if (GetPerkLv(500711, out var _))
			{
				bullut = strongBullut_Big;
			}
			if (CheckPerkCD(500714, cd_14))
			{
				TSVector2 position = monsterAdventureActor.tsTransform.Position;
				CoroutineNode item = StartLogicCoroutine(DelayShoot(bullut, hitDamageConfigId, position, position, dicCount_14.get_Item(lv)));
				corList.Add(item);
				monsterAdventureActor.ClearTag(tagHitCount);
			}
		}
	}

	private string GetBullul()
	{
		string result = (isInStrongState ? strongBullut : fireBullut);
		if (GetPerkLv(500711, out var _))
		{
			result = (isInStrongState ? strongBullut_Big : fireBullut_Big);
		}
		return result;
	}

	private IEnumerator DelayShoot(string bullut, int hitDamageId, TSVector2 startPos, TSVector2 targetPos, int count)
	{
		for (int i = 0; i < count; i++)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(delayTime));
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bullut, _actor, default, startPos, default, targetPos, null, AimType.Position, BulletDirectionType.BulletToTarget);
			if (hitDamageId != 0)
			{
				adventureBulletBase.hitBox.hitDamageId = hitDamageId;
			}
			adventureBulletBase.ModifyBulletTag(bullutTag_strong);
			if (GetPerkLv(perkId_0, out var _) && !isInStrongState && string.Equals(bullut, fireBullut))
			{
				AddKey(tagCastCount);
				RefreshShootRC();
			}
		}
	}

	private void RefreshShootRC()
	{
		if (GetKeyCount(tagCastCount) >= maxShootRC)
		{
			ClearKey(tagCastCount);
			EnterStrongState();
		}
	}

	private void EnterStrongState()
	{
		_actor.buffComponent.AddBuff(buff_Strong, _actor);
	}
}
