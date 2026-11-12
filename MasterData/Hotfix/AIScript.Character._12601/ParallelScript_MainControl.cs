#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Character._12601;

public class ParallelScript_MainControl : ParallelScript
{
	private readonly int skillId_S1 = 12631000;

	private readonly int skillId_S2 = 12631001;

	private FP autoSkillS2WaitTime = 4;

	private static readonly int magicHatTag = CommonHelper.StringToHash("126_B1Hat");

	private static readonly int firebirdTag = CommonHelper.StringToHash("126_A1");

	private static readonly int fireTag = CommonHelper.StringToHash("FireMark1");

	private readonly string magicHatBulltKey_1 = "magicHat_1";

	private readonly string magicHatBulltKey_2 = "magicHat_2";

	private readonly string magicHatReturnKey = "magicHat_Return";

	private readonly FP catchRadius = 0.3;

	private readonly string evt_Return = "126_B1_HatReturn";

	private readonly int buffId_CastSkillB = 12693011;

	private readonly int prob_Passive = 50;

	private readonly FP cd_Passive = 15;

	protected readonly string areaEffectAttack_Passive = "AreaEffect_12601_Passive";

	private readonly int perkId_2 = 512602;

	private readonly int damage_2 = 12650211;

	private readonly string bullut_T1 = "Bullet_12601_Skill1P02_MagicHat_Return";

	private readonly string bullut_T2 = "Bullet_12601_Skill1P01P02_MagicHat_Return";

	private readonly int perkId_3 = 512603;

	private readonly int buffId_3 = 12650311;

	private readonly int perkId_5 = 512605;

	private readonly int damage_5 = 12650501;

	private readonly int perkId_6 = 512606;

	private readonly int buffId_6 = 12650611;

	private readonly int perkId_7 = 512607;

	private readonly int damage_7 = 12650701;

	private readonly int perkId_8 = 512608;

	private readonly int buffId_8 = 12650811;

	private readonly int perkId_9 = 512609;

	private readonly int buffId_9 = 12650911;

	private readonly int perkId_10 = 512610;

	private readonly int prob_10 = 50;

	private readonly int buffId_10 = 1011;

	private readonly int perkId_11 = 512611;

	private readonly int buffId_11 = 12651111;

	private readonly int perkId_12 = 512612;

	private readonly int parameterId_12 = 12651202;

	private readonly int buffId_12 = 12651211;

	private readonly int perkId_13 = 512613;

	private readonly int buffId_13 = 12651311;

	private FP passiveCD;

	private List<LogicEntity> bulletMagicHatList = new List<LogicEntity>();

	private List<LogicEntity> bulletMagicHatReturnList = new List<LogicEntity>();

	private List<LogicEntity> tmpReturnList = new List<LogicEntity>();

	private FP lastCastTime;

	private bool isInS2;

	private CoroutineNode corRebind;

	private FP resetSkillTime;

	private Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

	private List<long> monsterIds = new List<long>();

	private CoroutineNode corAutoWait;

	public override void OnEnable()
	{
		base.OnEnable();
		passiveCD = 0;
		lastCastTime = 0;
		Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(skillId_S2);
		resetSkillTime = FP.FromMyriad(skill.UseTimeHint);
		isInS2 = false;
		perkCd.Clear();
		monsterIds.Clear();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		isInS2 = false;
		if (_actor is PlayerAdventureActor playerAdventureActor && !playerAdventureActor.CheckActionCondition(ActionKey.B))
		{
			playerAdventureActor.SetActionCondition(ActionKey.B, canCast: true);
		}
		StopCoroutine(ref corRebind);
		StopCoroutine(ref corAutoWait);
		skillMgr?.BindSkillIdToButton(ActionKey.B, skillId_S1);
		bulletMagicHatList.Clear();
		bulletMagicHatReturnList.Clear();
		tmpReturnList.Clear();
	}

	private bool CheckCd(int perkId, FP Cd)
	{
		if (Cd <= 0)
		{
			return true;
		}
		bool result = false;
		if (perkCd.TryGetValue(perkId, out var value))
		{
			if (_actor.LogicTime - value > Cd)
			{
				result = true;
				perkCd.set_Item(perkId, _actor.LogicTime);
			}
		}
		else
		{
			perkCd.Add(perkId, _actor.LogicTime);
			result = true;
		}
		return result;
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		int lv;
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A)
		{
			if (TSRandom.Range(0, 100) < prob_Passive && (_actor.LogicTime - passiveCD >= cd_Passive || passiveCD == 0))
			{
				passiveCD = _actor.LogicTime;
				CreateAreaEffect(areaEffectAttack_Passive);
			}
			if (GetPerkLv(perkId_12, out lv) && CheckCd(perkId_12, CommonUtils.GetScriptValue(_actor, parameterId_12)))
			{
				_actor.buffComponent.AddBuff(buffId_12, _actor);
			}
		}
		else
		{
			if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
			{
				return;
			}
			if (GetPerkLv(perkId_2, out lv))
			{
				if (evt.skillEventInfo.skillId == skillId_S1 && _actor is PlayerAdventureActor playerAdventureActor)
				{
					playerAdventureActor.SetActionCondition(ActionKey.B, canCast: false);
					StartCoroutine(ref corAutoWait, DoWaitAutoSkillB_S2());
				}
				if (evt.skillEventInfo.skillId == skillId_S2)
				{
					isInS2 = true;
				}
			}
			if (GetPerkLv(perkId_3, out lv))
			{
				_actor.buffComponent.AddBuff(buffId_3, _actor);
			}
			if (GetPerkLv(perkId_11, out lv))
			{
				_actor.buffComponent.AddBuff(buffId_11, _actor);
			}
			Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_CastSkillB, _actor);
		}
	}

	protected override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		base.OnCustomEvent(evt);
		if (evt.eventName == evt_Return)
		{
			List<LogicEntity> list = new List<LogicEntity>();
			for (int i = 0; i < bulletMagicHatList.Count; i++)
			{
				list.Add(bulletMagicHatList.get_Item(i));
			}
			for (int j = 0; j < list.Count; j++)
			{
				AdventureBullet adventureBullet = list.get_Item(j) as AdventureBullet;
				if (adventureBullet != null)
				{
					adventureBullet.Finish();
				}
			}
		}
		if (evt.eventName == "Stop_B_S2")
		{
			isInS2 = false;
			StopCoroutine(ref corRebind);
			skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1);
		}
		if (!(evt.eventName == "126_Summon"))
		{
			return;
		}
		for (int k = 0; k < monsterIds.Count; k++)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterIds.get_Item(k));
			if (logicEntity != null && !logicEntity.IsDead())
			{
				(logicEntity as MonsterAdventureActor).DestroySelf();
			}
		}
		monsterIds.Clear();
		if (evt.stringParamList != null)
		{
			long item = long.Parse(evt.stringParamList.get_Item(0));
			monsterIds.Add(item);
		}
	}

	protected override void OnBattleReady(AdventureBattleReadyEvent evt)
	{
		base.OnBattleReady(evt);
		for (int i = 0; i < monsterIds.Count; i++)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterIds.get_Item(i));
			if (logicEntity != null && !logicEntity.IsDead())
			{
				(logicEntity as MonsterAdventureActor).DestroySelf();
			}
		}
	}

	protected override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		if (GetPerkLv(perkId_2, out var _) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && evt.skillEventInfo.skillId == skillId_S2)
		{
			isInS2 = false;
			StopCoroutine(ref corRebind);
			skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1);
		}
	}

	protected override void OnRebindSkill(AdventurRebindSkill evt)
	{
		base.OnRebindSkill(evt);
		skillMgr.BindSkillIdToButton(evt.slotKey, evt.skillId);
		if (evt.skillId == skillId_S2)
		{
			StartCoroutine(ref corRebind, ResetSkill());
		}
	}

	private IEnumerator ResetSkill()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(resetSkillTime));
		skillMgr?.BindSkillIdToButton(ActionKey.B, skillId_S1);
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		if (_evt.from as PlayerAdventureActor != null && _evt.hitDamageTag != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, magicHatTag))
		{
			if (GetPerkLv(perkId_2, out var lv))
			{
				AdventureActor.AddFromAttr(damage_2, _actor);
			}
			if (GetPerkLv(perkId_5, out lv))
			{
				AdventureActor.AddFromAttr(damage_5, _actor);
			}
			if (GetPerkLv(perkId_7, out lv))
			{
				AdventureActor.AddFromAttr(damage_7, _actor);
			}
		}
	}

	protected override void OnBeforeHurt(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHurt(_evt);
	}

	protected override void OnGetBuff(IEvent evt)
	{
		base.OnGetBuff(evt);
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if (!(adventureActorGetBuff.from != _actor) && GetPerkLv(perkId_13, out var _) && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.FireMark1) && adventureActorGetBuff.sender is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.buffComponent.AddBuff(buffId_13, _actor);
		}
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent _evt)
	{
		base.OnHitPre(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		_ = _evt.from;
		if (monsterAdventureActor != null && _evt.hitDamageTag != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, magicHatTag) && GetPerkLv(perkId_6, out var lv))
		{
			monsterAdventureActor.buffComponent.AddBuff(buffId_6, _actor);
		}
		if (monsterAdventureActor != null && _evt.hitDamageTag != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, firebirdTag))
		{
			if (GetPerkLv(perkId_8, out lv))
			{
				monsterAdventureActor.buffComponent.AddBuff(buffId_8, _actor);
			}
			if (GetPerkLv(perkId_9, out lv))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_9, _actor);
			}
			if (GetPerkLv(perkId_10, out lv) && TSRandom.Range(0, 100) < prob_10)
			{
				monsterAdventureActor.buffComponent.AddBuff(buffId_10, _actor);
			}
		}
	}

	protected override void OnBulletBorn(AdventureBulletBornEvent _evt)
	{
		base.OnBulletBorn(_evt);
		if (!(_evt.owner is PlayerAdventureActor))
		{
			return;
		}
		if (_evt.tag.Equals(magicHatBulltKey_1) || _evt.tag.Equals(magicHatBulltKey_2))
		{
			LogicEntity logicEntity = _evt.sender as LogicEntity;
			if (logicEntity != null)
			{
				AdventureBullet component = logicEntity.gameObject.GetComponent<AdventureBullet>();
				int lv;
				if (component != null)
				{
					component.isPlayFinishPrefab = true;
					if (GetPerkLv(perkId_2, out lv))
					{
						component.isPlayFinishPrefab = false;
					}
				}
				WeaponFeaturePull component2 = logicEntity.gameObject.GetComponent<WeaponFeaturePull>();
				if (component2 != null)
				{
					component2.isPull = false;
					if (GetPerkLv(perkId_5, out lv))
					{
						component2.isPull = true;
					}
				}
				WeaponFeatureReflectWhenHitObstacleOrStop component3 = logicEntity.gameObject.GetComponent<WeaponFeatureReflectWhenHitObstacleOrStop>();
				if (component3 != null)
				{
					component3.isStop = true;
					if (GetPerkLv(perkId_7, out lv))
					{
						component3.isStop = false;
					}
				}
				bulletMagicHatList.Add(logicEntity);
			}
		}
		if (_evt.tag.Equals(magicHatReturnKey))
		{
			LogicEntity item = _evt.sender as LogicEntity;
			bulletMagicHatReturnList.Add(item);
		}
	}

	protected override void OnBulletFinish(AdventureBulletFinishEvent _evt)
	{
		base.OnBulletFinish(_evt);
		if (!(_evt.owner is PlayerAdventureActor))
		{
			return;
		}
		if (_evt.tag.Equals(magicHatBulltKey_1) || _evt.tag.Equals(magicHatBulltKey_2))
		{
			LogicEntity logicEntity = _evt.sender as LogicEntity;
			if (logicEntity != null && GetPerkLv(perkId_2, out var _))
			{
				string bulletAlias = bullut_T1;
				if (_evt.tag.Equals(magicHatBulltKey_2))
				{
					bulletAlias = bullut_T2;
					NovaLogger.Debug(bullut_T2);
				}
				ILRuntimeAPI.Shoot(bulletAlias, _actor, 0, logicEntity.tsTransform.Position, logicEntity.tsTransform.PositionY, _actor.tsTransform.Position, _actor, AimType.Target, BulletDirectionType.BulletToTarget);
			}
			if (bulletMagicHatList.Contains(logicEntity))
			{
				bulletMagicHatList.Remove(logicEntity);
			}
		}
		if (_evt.tag.Equals(magicHatReturnKey))
		{
			LogicEntity item = _evt.sender as LogicEntity;
			if (bulletMagicHatReturnList.Contains(item))
			{
				bulletMagicHatReturnList.Remove(item);
			}
			if (bulletMagicHatReturnList.Count == 0 && isInS2)
			{
				isInS2 = false;
				StopCoroutine(ref corRebind);
				skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1);
			}
		}
	}

	protected override void OnBulletBlock(AdventureBulletBlockEvent _evt)
	{
		base.OnBulletBlock(_evt);
		if (_evt.sender is AdventureBullet adventureBullet && _actor.Id == _evt.owner.Id && (adventureBullet.DefaultBulletTag.Equals(magicHatBulltKey_1) || adventureBullet.DefaultBulletTag.Equals(magicHatBulltKey_2)))
		{
			adventureBullet.velocitySpeed = 0;
		}
	}

	protected void CreateAreaEffect(string areaName)
	{
		ILRuntimeAPI.PlayAreaEffect(_actor, areaName, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (bulletMagicHatReturnList.Count <= 0)
		{
			return;
		}
		tmpReturnList.Clear();
		for (int i = 0; i < bulletMagicHatReturnList.Count; i++)
		{
			tmpReturnList.Add(bulletMagicHatReturnList.get_Item(i));
		}
		for (int j = 0; j < tmpReturnList.Count; j++)
		{
			if (TSVector2.Distance(_actor.tsTransform.Position, tmpReturnList.get_Item(j).tsTransform.Position) < catchRadius)
			{
				AdventureBullet adventureBullet = tmpReturnList.get_Item(j) as AdventureBullet;
				if (adventureBullet != null)
				{
					adventureBullet.Finish();
				}
			}
		}
	}

	private IEnumerator DoWaitAutoSkillB_S2()
	{
		yield return _actor.WaitTime(autoSkillS2WaitTime);
		if (_actor is PlayerAdventureActor playerAdventureActor)
		{
			playerAdventureActor.SetActionCondition(ActionKey.B, canCast: true);
		}
	}
}
