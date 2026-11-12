using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.ThemePerk;

public class Theme_Blizzard : BaseTheme
{
	private readonly string fireBullut = "Misc/FateCard/Theme_Blizzard";

	private readonly int blizzardTag = CommonHelper.StringToHash("Blizzard");

	private readonly FP circleRadius = 8;

	private readonly FP delayTime = 0.5f;

	private const string triggerFxPath = "FX/Perk/fx_perk_base_ice_trigger_s";

	private readonly int iceBuffId = 92011;

	private readonly int perkId_1 = 500901;

	private readonly FP cd_1 = 2;

	private readonly int prob_1 = 100;

	private readonly int damageId_1 = 500901;

	private readonly int perkId_2 = 500902;

	private readonly FP cd_2 = 2;

	private readonly int prob_2 = 100;

	private readonly int damageId_2 = 500902;

	private readonly int perkId_3 = 500903;

	private readonly FP cd_3 = 2;

	private readonly int prob_3 = 100;

	private readonly int damageId_3 = 500903;

	private readonly int perkId_4 = 500904;

	private readonly FP cd_4 = 2;

	private readonly int prob_4 = 100;

	private readonly int damageId_4 = 500904;

	private readonly int perkId_8 = 500908;

	private readonly Dictionary<int, int> dicEff_8 = new Dictionary<int, int>
	{
		[1] = 90811,
		[2] = 90821,
		[3] = 90831
	};

	private readonly int perkId_9 = 500909;

	private readonly Dictionary<int, int> dicAddTime_9 = new Dictionary<int, int>
	{
		[1] = 3,
		[2] = 4,
		[3] = 5
	};

	private readonly Dictionary<int, int> dicAddNum_9 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 1,
		[3] = 2
	};

	private readonly Dictionary<int, int> dicAttr_9 = new Dictionary<int, int>
	{
		[1] = 25,
		[2] = 45,
		[3] = 60
	};

	private readonly int perkId_10 = 500910;

	private readonly Dictionary<int, int> dicEff_10 = new Dictionary<int, int>
	{
		[1] = 91011,
		[2] = 91021,
		[3] = 91031
	};

	private readonly Dictionary<int, int> dicAttr_10 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 50,
		[3] = 70
	};

	private const int perkId_11 = 500911;

	private readonly FP cd_11 = 0;

	private readonly string bulletPath_11 = "Misc/FateCard/Theme_Blizzard_11";

	private readonly FP interl_11 = 0.3;

	private readonly FP innerRadius_11 = 1;

	private readonly FP radius_11 = 2;

	private readonly Dictionary<int, int> dicNum_11 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3
	};

	private const int perkId_12 = 500912;

	private readonly FP cd_12 = 3;

	private readonly int iceTag_12 = CommonHelper.StringToHash("BlizzardSpark");

	private readonly Dictionary<int, string> dicAreaEff_12 = new Dictionary<int, string>
	{
		[1] = "Misc/FateCard/Theme_Blizzard_Area_12_5m",
		[2] = "Misc/FateCard/Theme_Blizzard_Area_12_7m",
		[3] = "Misc/FateCard/Theme_Blizzard_Area_12_9m"
	};

	private readonly Dictionary<int, FP> dicPercent_12 = new Dictionary<int, FP>
	{
		[1] = 100,
		[2] = 100,
		[3] = 100
	};

	private const int perkId_13 = 500913;

	private readonly FP cd_13 = 0;

	private readonly Dictionary<int, int> dicBuff_13 = new Dictionary<int, int>
	{
		[1] = 91311,
		[2] = 91321,
		[3] = 91331
	};

	private const int perkId_14 = 500914;

	private readonly FP cd_14 = 10;

	private readonly FP delayTime_14 = 0.5;

	private readonly string areaPath_14 = "Misc/FateCard/Theme_Blizzard_Area_14";

	private readonly Dictionary<int, int> dicDuration_14 = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 5,
		[3] = 5
	};

	private readonly Dictionary<int, FP> dicInter_14 = new Dictionary<int, FP>
	{
		[1] = 1,
		[2] = 0.7,
		[3] = 0.5
	};

	private readonly Dictionary<int, int> dicHitID_14 = new Dictionary<int, int>
	{
		[1] = 500914,
		[2] = 500914,
		[3] = 500914
	};

	private const int perkId_15 = 500915;

	private readonly FP cd_15 = 2;

	private readonly Dictionary<int, int> dicEff_15 = new Dictionary<int, int>
	{
		[1] = 964,
		[2] = 988,
		[3] = 1212,
		[4] = 1236,
		[5] = 1260
	};

	private const int perkId_16 = 500916;

	private readonly FP AdjustRate_16 = 100;

	private readonly FP cd_16 = 2;

	private readonly string bulletPath_16 = "Misc/FateCard/Theme_Blizzard_16";

	private readonly int perk16Tag = CommonHelper.StringToHash("BlizzardAim");

	private AdventureTimeBomb bullutObj;

	private readonly List<int> _perkEffectIdList = new List<int>();

	private readonly HashSet<LogicEntity> hitMonsterSet = new HashSet<LogicEntity>();

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	private Dictionary<long, FP> _perk16TriggerDic;

	private int buffNum;

	private FP hitPercent_12;

	public override void OnEnable()
	{
		base.OnEnable();
		_perk16TriggerDic = new Dictionary<long, FP>(10);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_perk16TriggerDic.Clear();
		foreach (CoroutineNode cor in corList)
		{
			StopLogicCoroutine(cor);
		}
		hitMonsterSet.Clear();
		corList.Clear();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
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
	}

	private void CheckShoot(int perkId, int perkIndex, int prob, FP cd, int dmgId)
	{
		if (GetPerkLv(perkId, out var _) && TSRandom.Range(0, 100) <= prob && CheckPerkCD(perkId, cd))
		{
			Shoot(fireBullut, _actor.attackTarget, dmgId);
		}
	}

	private void Shoot(string bullut, LogicEntity target, int hitDamageId)
	{
		target = ((target != null) ? target : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (!(target == null))
		{
			CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_ice_trigger_s");
			AdventureActor actor = _actor;
			TSVector2 position = target.tsTransform.Position;
			TSVector2 position2 = target.tsTransform.Position;
			bullutObj = ILRuntimeAPI.Shoot(bullut, actor, default, position, default, position2, null, AimType.Position, BulletDirectionType.BulletToTarget) as AdventureTimeBomb;
			bullutObj.hitBox.hitDamageId = hitDamageId;
			bullutObj.useOwnerActorInfo = true;
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500911, out var perkLevel) && CheckPerkCD(500911, cd_11))
			{
				CoroutineNode item = StartLogicCoroutine(perk11_Shoot(bulletPath_11, target.tsTransform.Position, perkLevel));
				corList.Add(item);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500914, out var perkLevel2) && CheckPerkCD(500914, cd_14))
			{
				CoroutineNode item2 = StartLogicCoroutine(DelayEffect(target, perkLevel2));
				corList.Add(item2);
			}
			if (GetPerkLv(500915, out var _))
			{
				TSVector2 position3 = target.tsTransform.Position;
				CoroutineNode item3 = StartLogicCoroutine(DelayShoot(bullut, hitDamageId, position3, position3));
				corList.Add(item3);
			}
		}
	}

	private IEnumerator DelayShoot(string bullut, int hitDamageId, TSVector2 startPos, TSVector2 targetPos)
	{
		yield return StartLogicCoroutine(_actor.WaitForSeconds(delayTime));
		ILRuntimeAPI.Shoot(bullut, _actor, default, startPos, default, targetPos, null, AimType.Position, BulletDirectionType.BulletToTarget).hitBox.hitDamageId = hitDamageId;
	}

	private IEnumerator DelayEffect(LogicEntity target, int level_14)
	{
		yield return StartLogicCoroutine(_actor.WaitForSeconds(delayTime_14));
		_ = "Assets/AssetBundles/" + areaPath_14 + ".prefab";
		ILRuntimeAPI.PlayAreaEffect(_actor, areaPath_14, target.tsTransform.Position, default, (AreaEffectEntity entity) =>
		{
			entity.duration = dicDuration_14.get_Item(level_14);
			AreaEffect_AttackComponent areaEffectComponent = entity.GetAreaEffectComponent<AreaEffect_AttackComponent>();
			if (areaEffectComponent != null)
			{
				areaEffectComponent.hitInterval = dicInter_14.get_Item(level_14);
				areaEffectComponent.hitDamageId = dicHitID_14.get_Item(level_14);
			}
		});
	}

	private IEnumerator perk11_Shoot(string bullut, TSVector2 startPos, int level)
	{
		for (int i = 0; i < dicNum_11.get_Item(level); i++)
		{
			yield return StartLogicCoroutine(_actor.WaitForSeconds(interl_11));
			TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(startPos, innerRadius_11, radius_11);
			ILRuntimeAPI.Shoot(bullut, _actor, default, tSVector, _actor.tsTransform.PositionY, tSVector, null, AimType.Position, BulletDirectionType.BulletToTarget);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		AdventureActor adventureActor = _evt.to as AdventureActor;
		AdventureActor adventureActor2 = _evt.from as AdventureActor;
		if (!(adventureActor != null) || _evt.hitDamageTag == null || !(adventureActor.buffComponent != null))
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(_evt.hitDamageTag, iceTag_12) && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500912, out var perkLevel) && buffNum > 0)
		{
			adventureActor.SetExtraAtk(buffNum * dicPercent_12.get_Item(perkLevel) / 100, 0);
		}
		if (CommonUtils.CheckHitByTag(_evt.hitDamageTag, blizzardTag))
		{
			adventureActor.buffComponent?.AddBuff(iceBuffId, _actor);
			if (GetPerkLv(perkId_8, out var lv))
			{
				adventureActor.buffComponent?.AddBuff(dicEff_8.get_Item(lv), _actor);
			}
			if (GetPerkLv(perkId_10, out var lv2))
			{
				adventureActor.buffComponent?.AddBuff(dicEff_10.get_Item(lv2), _actor);
			}
			if (GetPerkLv(perkId_9, out var lv3))
			{
				BuffCom buffComponent = adventureActor.buffComponent;
				if ((object)buffComponent != null && buffComponent.GetBuffNumByID(iceBuffId) == 1)
				{
					adventureActor.buffComponent?.AddBuffExceptTimeByBuffID(iceBuffId, dicAddTime_9.get_Item(lv3));
					adventureActor.buffComponent?.AdjustBuffNum(dicAddNum_9.get_Item(lv3), iceBuffId);
				}
				if (lv > 0)
				{
					BuffCom buffComponent2 = adventureActor.buffComponent;
					if ((object)buffComponent2 != null && buffComponent2.GetBuffNumByID(dicEff_8.get_Item(lv)) == 1)
					{
						adventureActor.buffComponent?.AddBuffExceptTimeByBuffID(dicEff_8.get_Item(lv), dicAddTime_9.get_Item(lv3));
						adventureActor.buffComponent?.AdjustBuffNum(dicAddNum_9.get_Item(lv3), dicEff_8.get_Item(lv));
					}
				}
				if (lv2 > 0)
				{
					BuffCom buffComponent3 = adventureActor.buffComponent;
					if ((object)buffComponent3 != null && buffComponent3.GetBuffNumByID(dicEff_10.get_Item(lv2)) == 1)
					{
						adventureActor.buffComponent?.AddBuffExceptTimeByBuffID(dicEff_10.get_Item(lv2), dicAddTime_9.get_Item(lv3));
						adventureActor.buffComponent?.AdjustBuffNum(dicAddNum_9.get_Item(lv3), dicEff_10.get_Item(lv2));
					}
				}
			}
			if (adventureActor2 != null && CanTriggerPerk(perkId_9, out var lv4, 0))
			{
				AdventureActor.AddFromAttr(dicAttr_9.get_Item(lv4), _actor);
			}
			if (adventureActor2 != null && CanTriggerPerk(perkId_10, out var lv5, 0))
			{
				AdventureActor.AddFromAttr(dicAttr_10.get_Item(lv5), _actor);
			}
			if (CanTriggerPerk(500916, out var _, 0))
			{
				bool flag = false;
				if (!_perk16TriggerDic.ContainsKey(adventureActor.Id))
				{
					_perk16TriggerDic.Add(adventureActor.Id, adventureActor.LogicTime);
					flag = true;
				}
				else if (_perk16TriggerDic.get_Item(adventureActor.Id) + cd_16 < adventureActor.LogicTime)
				{
					_perk16TriggerDic.set_Item(adventureActor.Id, adventureActor.LogicTime);
					flag = true;
				}
				if (flag)
				{
					int num = adventureActor.buffComponent.GetBuffNum(0, 0, blizzardTag);
					hitPercent_12 = num * AdjustRate_16 / 100;
					string bulletAlias = bulletPath_16;
					AdventureActor actor = _actor;
					TSVector2 position = adventureActor.tsTransform.Position;
					TSVector2 position2 = adventureActor.tsTransform.Position;
					ILRuntimeAPI.Shoot(bulletAlias, actor, default, position, default, position2, null, AimType.Position, BulletDirectionType.BulletToTarget);
				}
			}
		}
		else if (CommonUtils.CheckHitByTag(_evt.hitDamageTag, perk16Tag))
		{
			adventureActor.SetExtraAtk(hitPercent_12, 0);
		}
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		base.OnHitPre(evt);
		if (evt.hitDamageTag == null)
		{
			return;
		}
		_perkEffectIdList.Clear();
		AdventureActor adventureActor = evt.to as AdventureActor;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, blizzardTag))
		{
			if (adventureActor != null && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500913, out var perkLevel) && CheckPerkCD(500913, cd_13))
			{
				adventureActor.buffComponent.AddBuff(iceBuffId, _actor);
				adventureActor.buffComponent.AddBuff(dicBuff_13.get_Item(perkLevel), _actor);
			}
			if (GetPerkLv(500915, out var lv))
			{
				_perkEffectIdList.Add(dicEff_15.get_Item(lv));
			}
			_actor.effectManage.AddEffectByAI(_perkEffectIdList);
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent evt)
	{
		base.OnHitPost(evt);
		if (evt.hitDamageTag != null)
		{
			_ = evt.to;
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, blizzardTag) && _perkEffectIdList.Count > 0)
			{
				_actor.effectManage.RemoveEffectByAI(_perkEffectIdList);
			}
		}
	}

	protected override void OnBulletFinish(AdventureBulletFinishEvent _evt)
	{
		base.OnBulletFinish(_evt);
	}

	private void OnDied(IEvent evt)
	{
		AdventureActorDiedEvent obj = evt as AdventureActorDiedEvent;
		AdventureActor actor = obj.actor;
		if (!(obj.killer != _actor))
		{
			int num = actor.buffComponent.GetBuffNum(0, 0, blizzardTag);
			if (num > 0 && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500912, out var perkLevel) && CheckPerkCD(500912, cd_12))
			{
				buffNum = num;
				_ = "Assets/AssetBundles/" + dicAreaEff_12.get_Item(perkLevel) + ".prefab";
				ILRuntimeAPI.PlayAreaEffect(_actor, dicAreaEff_12.get_Item(perkLevel), actor.tsTransform.Position);
			}
		}
	}
}
