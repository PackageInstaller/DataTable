using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.TowerDefense._12501;

public class Parallel : TowerCharacterParalletBase
{
	private const int buffId_Berserk = 801250030;

	private FP berserkDuration = 15;

	private FP maxBerserkDuration = 30;

	private int damageTag_Ultra = CommonHelper.StringToHash("125_Ultra");

	private int damageTag_NormalAttack_Rage = CommonHelper.StringToHash("125_NormalAttack_Rage");

	private int enterBerserkEvt = CommonHelper.StringToHash("12501_EnterBerserk");

	private const int perkId_1 = 1250101;

	private int buffId_P01 = 801250040;

	private int maxCount_P01 = 15;

	private FP interval_P01 = 1;

	private const int perkId_2 = 1250102;

	private int onceId_P02 = 811250001;

	private int buffId_P02_Slow = 801250060;

	private FP slowDuration_P02 = 5;

	private int damageTag_Ultra_Last = CommonHelper.StringToHash("125_Ultra_Last");

	private FP blowUpStrength_P02 = 5;

	private FP blowUpSpeed_P02 = 40;

	private FP blowUpDistance_P02 = 3;

	private string linkFxKey_P02 = "fx_12501_bullet_Ultra_TL2_tengman";

	private const int perkId_3 = 1250103;

	private int buffId_P03_Atk = 801250050;

	private int maxCount_P03 = 99;

	private FP addBerserkTime_P03 = 1;

	private int lastCountedAttackId_P03;

	private const int perkId_4 = 1250104;

	private FP chargePerHit_P04 = 2;

	private FP maxCharge_P04 = 40;

	private FP pendingCharge_P04;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int>
	{
		[1250105] = 15,
		[1250106] = 20,
		[1250107] = 25
	};

	private FP berserkEndTime;

	private CoroutineNode berserkCor;

	private List<LogicEntity> p02LinkTargets = new List<LogicEntity>();

	private Dictionary<long, AdventureFXPlayer> p02LinkFxDic = new Dictionary<long, AdventureFXPlayer>();

	private GameObject linkFxPrefab_P02;

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	private bool InBerserk => _actor.buffComponent.CheckBuffByBuffID(801250030);

	public override void OnEnable()
	{
		base.OnEnable();
		linkFxPrefab_P02 = _actor.comboGroup?.relatedResourceConfig?.GetFXByAlias(linkFxKey_P02);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref berserkCor);
		ClearP02Link();
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		base.OnCustomEvent(evt);
		if (evt.eventHashCode == enterBerserkEvt)
		{
			EnterBerserk();
		}
	}

	private void EnterBerserk()
	{
		_actor.buffComponent.AddBuff(801250030, actor);
		berserkEndTime = _actor.LogicTime + berserkDuration;
		lastCountedAttackId_P03 = 0;
		pendingCharge_P04 = 0;
		StartCoroutine(ref berserkCor, BerserkCor());
	}

	private void AddBerserkTime(FP addTime)
	{
		if (InBerserk)
		{
			berserkEndTime += addTime;
			FP fP = _actor.LogicTime + maxBerserkDuration;
			if (berserkEndTime > fP)
			{
				berserkEndTime = fP;
			}
		}
	}

	private IEnumerator BerserkCor()
	{
		FP p01Timer = 0;
		while (_actor.LogicTime < berserkEndTime)
		{
			if (GetPerk(1250101))
			{
				p01Timer += _actor.LogicDeltaTime;
				if (p01Timer >= interval_P01)
				{
					p01Timer = 0;
					if (_actor.buffComponent.GetBuffNumByID(buffId_P01) < maxCount_P01)
					{
						_actor.buffComponent.AddBuff(buffId_P01, actor);
					}
				}
			}
			yield return null;
		}
		_actor.buffComponent.RemoveBuffByBuffId(801250030);
		_actor.buffComponent.RemoveBuffByBuffId(buffId_P01);
		_actor.buffComponent.RemoveBuffByBuffId(buffId_P03_Atk);
		if (GetPerk(1250104) && pendingCharge_P04 > 0)
		{
			actor.skillMgr.ModifyEnergyByPercent(actor.mainSkillId, pendingCharge_P04);
			pendingCharge_P04 = 0;
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		if (GetPerk(1250102) && CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_Ultra))
		{
			AdventureActor.AddFromAttr(onceId_P02, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (!isSelf)
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_Ultra))
		{
			if (GetPerk(1250104) && pendingCharge_P04 < maxCharge_P04)
			{
				pendingCharge_P04 += chargePerHit_P04;
				if (pendingCharge_P04 > maxCharge_P04)
				{
					pendingCharge_P04 = maxCharge_P04;
				}
			}
			if (GetPerk(1250102) && CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_Ultra_Last))
			{
				ApplyP02LinkAndBlowUp(monster);
			}
		}
		if (GetPerk(1250103) && InBerserk && CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_NormalAttack_Rage) && evt.uniqueAttackId != 0 && evt.uniqueAttackId != lastCountedAttackId_P03)
		{
			lastCountedAttackId_P03 = evt.uniqueAttackId;
			if (_actor.buffComponent.GetBuffNumByID(buffId_P03_Atk) < maxCount_P03)
			{
				_actor.buffComponent.AddBuff(buffId_P03_Atk, actor);
			}
			AddBerserkTime(addBerserkTime_P03);
		}
	}

	public override void OnReceiveDamage(AdventureActorReceiveDamageEvent evt)
	{
		base.OnReceiveDamage(evt);
		if (evt.isKill && evt.to is MonsterAdventureActor monsterAdventureActor)
		{
			RemoveP02Link(monsterAdventureActor.Id);
		}
	}

	private void ApplyP02LinkAndBlowUp(MonsterAdventureActor monster)
	{
		ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, _actor.tsTransform.Position, new List<LogicEntity> { monster }, blowUpDistance_P02, blowUpSpeed_P02, blowUpStrength_P02, 99, isPull: false, withRadius: true);
		monster.buffComponent.AddBuff(buffId_P02_Slow, actor);
		if (linkFxPrefab_P02 != null && !p02LinkFxDic.ContainsKey(monster.Id))
		{
			GameObject fxPrefab = linkFxPrefab_P02;
			Vector3 position = _actor.transform.position;
			Quaternion identity = Quaternion.identity;
			Transform transform = _actor.transform;
			Transform transform2 = monster.transform;
			AdventureFXPlayer value = AdventureFXPlayer.PlayFX(fxPrefab, 1f, position, identity, 1f, transform, default, transform2);
			p02LinkFxDic.Add(monster.Id, value);
			p02LinkTargets.Add(monster);
		}
		StartCoroutine(RemoveP02LinkAfter(monster, slowDuration_P02));
	}

	private IEnumerator RemoveP02LinkAfter(MonsterAdventureActor monster, FP time)
	{
		yield return _actor.WaitTime(time);
		if (monster != null)
		{
			monster.buffComponent.RemoveBuffByBuffId(buffId_P02_Slow);
			RemoveP02Link(monster.Id);
		}
	}

	private void RemoveP02Link(long id)
	{
		if (p02LinkFxDic.TryGetValue(id, out var value))
		{
			value?.Stop();
			p02LinkFxDic.Remove(id);
		}
		for (int num = p02LinkTargets.Count - 1; num >= 0; num--)
		{
			if (p02LinkTargets.get_Item(num) != null && p02LinkTargets.get_Item(num).Id == id)
			{
				p02LinkTargets.RemoveAt(num);
			}
		}
	}

	private void ClearP02Link()
	{
		foreach (AdventureFXPlayer value in p02LinkFxDic.Values)
		{
			value?.Stop();
		}
		p02LinkFxDic.Clear();
		p02LinkTargets.Clear();
	}
}
