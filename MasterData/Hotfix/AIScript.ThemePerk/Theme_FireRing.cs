using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using PathologicalGames;
using TrueSync;
using UnityEngine;

namespace AIScript.ThemePerk;

public class Theme_FireRing : BaseTheme
{
	private readonly FP duration = 1.4;

	private readonly FP duration_11 = 1.4;

	private readonly FP duration_1p = 1.4;

	private readonly FP initInnerRadius = 0.3;

	private readonly FP radius = 1;

	private readonly int fireRingDamageTag = CommonHelper.StringToHash("fireRing");

	private const string fxPath = "FX/Perk/fx_perk_base_fire_firering_6m_1s_01";

	private const string fxPath_11 = "FX/Perk/fx_perk_base_fire_firering_9m_1s_11";

	private const string fxPath_13 = "FX/Perk/fx_perk_base_fire_firering_6m_1s_13";

	private const string fxPath_11_13 = "FX/Perk/fx_perk_base_fire_firering_9m_1s_13";

	private const string fxPath_1p = "FX/Perk/fx_perk_base_fire_firering_3m_1s_q01";

	private const string fxPath_1p_13 = "FX/Perk/fx_perk_base_fire_firering_3m_1s_13q01";

	private const string triggerFxPath = "FX/Perk/fx_perk_base_fire_trigger_s";

	private const string fxPath_bom6 = "FX/Perk/fx_perk_base_fire_firering_6m_q2";

	private const string fxPath_bom9 = "FX/Perk/fx_perk_base_fire_firering_9m_q2";

	private const string fxPath_hitQ2 = "FX/Perk/fx_perk_hit_fire_firering_q02";

	private readonly FP diffuseSpeed = 0.5;

	private readonly FP diffuseInterval = 0.08;

	private readonly FP attackInterval = 0.2;

	private const int perkId_1 = 500101;

	private readonly FP trigger_Percentage1 = 100;

	private readonly FP cd_1 = 4;

	private const int hitDamageId_1 = 500101;

	private const int perkId_2 = 500102;

	private readonly FP trigger_Percentage2 = 100;

	private readonly FP cd_2 = 4;

	private const int hitDamageId_2 = 500102;

	private const int perkId_3 = 500103;

	private readonly FP trigger_Percentage3 = 100;

	private readonly FP cd_3 = 4;

	private const int hitDamageId_3 = 500103;

	private const int perkId_4 = 500104;

	private readonly FP trigger_Percentage4 = 100;

	private readonly FP cd_4 = 4;

	private const int hitDamageId_4 = 500104;

	private const int perkId_8 = 500108;

	private readonly FP cd_8 = 10;

	private readonly FP fixedCd_8 = 8;

	private readonly int buffTag_8 = CommonHelper.StringToHash("buffTag_firRperk8");

	private readonly Dictionary<int, int> buffIdDic_8 = new Dictionary<int, int>
	{
		[1] = 10811,
		[2] = 10821,
		[3] = 10831,
		[4] = 10841,
		[5] = 10851,
		[6] = 10861
	};

	private const int perkId_9 = 500109;

	private readonly FP cd_9 = 15;

	private readonly FP fixedCd_9 = 8;

	private readonly int buffTag_9 = CommonHelper.StringToHash("buffTag_firRperk9");

	private readonly Dictionary<int, int> buffIdDic_9 = new Dictionary<int, int>
	{
		[1] = 10911,
		[2] = 10921,
		[3] = 10931,
		[4] = 10941,
		[5] = 10951,
		[6] = 10961
	};

	private const int perkId_10 = 500110;

	private readonly FP cd_10 = 0;

	private readonly int maxTriggerCount = 5;

	private readonly Dictionary<int, FP> dicPower_10 = new Dictionary<int, FP>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 2.5,
		[5] = 3.5,
		[6] = 4.5
	};

	private const int perkId_11 = 500111;

	private readonly FP diffuseInterval_11 = 0.06;

	private readonly FP cd_11 = 0;

	private readonly Dictionary<int, int> attrIdDic_11 = new Dictionary<int, int>
	{
		[1] = 25,
		[2] = 50,
		[3] = 75
	};

	private const int perkId_12 = 500112;

	private readonly FP cd_12 = 0;

	private readonly FP dis_12 = 2;

	private readonly Dictionary<FP, int> atrriIdDic_12 = new Dictionary<FP, int>
	{
		[1] = 10,
		[2] = 20,
		[3] = 30
	};

	private const int perkId_13 = 500113;

	private readonly Dictionary<int, int> attriIdDic_13 = new Dictionary<int, int>
	{
		[1] = 440,
		[2] = 420,
		[3] = 400
	};

	private const int perkId_14 = 500114;

	private readonly FP cd_14 = 0;

	private static readonly int fireMarkTag = CommonHelper.StringToHash("FireTag");

	private readonly Dictionary<int, int> dicCD_14 = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 5,
		[3] = 5
	};

	private readonly Dictionary<int, int> dicTriggerPercent_14 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 40,
		[3] = 50
	};

	private readonly Dictionary<int, int> buffDic_14 = new Dictionary<int, int>
	{
		[1] = 11411,
		[2] = 11421,
		[3] = 11431
	};

	private readonly Dictionary<int, int> attriIdDic_14 = new Dictionary<int, int>
	{
		[1] = 40,
		[2] = 80,
		[3] = 120
	};

	private const int perkId_15 = 500115;

	private readonly FP cd_15 = 0;

	private readonly Dictionary<int, int> buffIdDic_15 = new Dictionary<int, int>
	{
		[1] = 11511,
		[2] = 11521,
		[3] = 11531
	};

	private readonly Dictionary<int, int> buffIdDic_15_self = new Dictionary<int, int>
	{
		[1] = 11512,
		[2] = 11522,
		[3] = 11532
	};

	private const int hitDamageId_15 = 500115;

	private const int perkId_1p = 500116;

	private readonly FP cd_1p = 6;

	private readonly FP diffuseInterval_1p = 0.3;

	private readonly int triggerCount = 3;

	private const int hitDamageId_1p = 500115;

	private const int perkId_2p = 500117;

	private readonly FP cd_2p = 0;

	private readonly FP one_percent = 5;

	private readonly int numMax = 10;

	private readonly int hitId_2p = 500117;

	private readonly int hitId_2pTag = CommonHelper.StringToHash("fireRingClear");

	private const int perkId_3p = 500118;

	private readonly FP range_3p = 8;

	private const int attrId_3p = 50;

	private GameObject _prefab_FireRing;

	private List<int> _perkEffectIdList;

	private Dictionary<string, GameObject> _fxPrefabDic;

	private string _fireRingPrefabName;

	private Dictionary<long, FP> _perk8TriggerDic;

	private FP _perk9TriggerTime;

	private Dictionary<long, int> _perk10TriggerDic;

	private int _perk1pTriggerCount;

	private List<long> _perk2pTriggers;

	private bool _perk1pTrigger;

	private FP percetAjust_2p;

	public override void OnEnable()
	{
		base.OnEnable();
		_fireRingPrefabName = $"FireRing_{_actor.dataID}";
		_perkEffectIdList = new List<int>(10);
		_perk8TriggerDic = new Dictionary<long, FP>(10);
		_fxPrefabDic = new Dictionary<string, GameObject>(4);
		_perk9TriggerTime = 0;
		_perk10TriggerDic = new Dictionary<long, int>(30);
		_perk1pTriggerCount = 0;
		_perk2pTriggers = new List<long>(10);
		_perk1pTrigger = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_DIFFUSE", OnDiffuseEvent);
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500101, out var _) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage1 && CheckPerkCD(500101, cd_1))
		{
			PlayFireRing(500101);
		}
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500102, out var _) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage2 && CheckPerkCD(500102, cd_2))
		{
			PlayFireRing(500102);
		}
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500103, out var _) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage3 && CheckPerkCD(500103, cd_3))
		{
			PlayFireRing(500103);
		}
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500104, out var _) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage4 && CheckPerkCD(500104, cd_4))
		{
			PlayFireRing(500104);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		int perkLevel6;
		if (_evt.from as AdventureActor != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, fireRingDamageTag))
		{
			AdventureActor adventureActor = _evt.to as AdventureActor;
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500111, out var perkLevel))
			{
				AdventureActor.AddFromAttr(attrIdDic_11.get_Item(perkLevel), _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500112, out var perkLevel2))
			{
				TSVector2 position = _actor.tsTransform.Position;
				if (_evt.firstFrom != null)
				{
					position = _evt.firstFrom.tsTransform.Position;
				}
				int num = (int)(long)(TSVector2.Distance(position, adventureActor.tsTransform.Position) / dis_12);
				num = ((num < 1) ? 1 : num);
				AdventureActor.AddFromAttr(atrriIdDic_12.get_Item((FP)perkLevel2), _actor, num);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500113, out var perkLevel3))
			{
				AdventureActor.AddFromAttr(attriIdDic_13.get_Item(perkLevel3), _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500114, out var perkLevel4) && CheckPerkCD(500114, cd_14) && (CommonUtils.CheckElementMark(CommonDefine.Fire, adventureActor) || TSRandom.Range(0, 100) < dicTriggerPercent_14.get_Item(perkLevel4)) && CheckPerkCD((int)adventureActor.Id, dicCD_14.get_Item(perkLevel4)))
			{
				AdventureActor.AddFromAttr(attriIdDic_14.get_Item(perkLevel4), _actor);
				adventureActor.buffComponent?.AddBuff(buffDic_14.get_Item(perkLevel4), _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500118, out var _))
			{
				AdventureActor.AddFromAttr(50, _actor);
			}
		}
		else if (CommonUtils.CheckHitByTag(_evt.hitDamageTag, hitId_2pTag) && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500117, out perkLevel6))
		{
			AdventureActor adventureActor2 = _evt.to as AdventureActor;
			adventureActor2.SetExtraAtk(1 + percetAjust_2p, 0);
			PlayFX playFX = new PlayFX();
			playFX.Play(_actor, null, "FX/Perk/fx_perk_hit_fire_firering_q02", adventureActor2.tsTransform.PositionY, adventureActor2.tsTransform.Position, adventureActor2.tsTransform.Forward);
			playFX.Clear();
		}
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent _evt)
	{
		base.OnHitPre(_evt);
		if (_evt.from != _actor)
		{
			return;
		}
		for (int i = 0; i < _evt.hitDamageTag.Count; i++)
		{
			if (!object.Equals(_evt.hitDamageTag.get_Item(i), fireRingDamageTag))
			{
				continue;
			}
			AdventureActor adventureActor = _evt.to as AdventureActor;
			_perkEffectIdList.Clear();
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500108, out var perkLevel) && adventureActor.buffComponent != null && !adventureActor.buffComponent.CheckBuffByBuffTag(buffTag_8))
			{
				if (!_perk8TriggerDic.ContainsKey(adventureActor.Id))
				{
					_perk8TriggerDic.Add(adventureActor.Id, _actor.LogicTime);
				}
				else if (_perk8TriggerDic.get_Item(adventureActor.Id) + fixedCd_8 > _actor.LogicTime)
				{
					if (CheckPerkCD(500108, cd_8))
					{
						_perk8TriggerDic.Remove(adventureActor.Id);
						adventureActor.buffComponent?.AddBuff(buffIdDic_8.get_Item(perkLevel), _actor);
					}
				}
				else
				{
					_perk8TriggerDic.set_Item(adventureActor.Id, _actor.LogicTime);
				}
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500110, out var perkLevel2))
			{
				bool flag = false;
				if (!_perk10TriggerDic.ContainsKey(_evt.firstFrom.Id))
				{
					_perk10TriggerDic.Add(_evt.firstFrom.Id, 1);
					flag = true;
				}
				else if (_perk10TriggerDic.get_Item(_evt.firstFrom.Id) < maxTriggerCount)
				{
					_perk10TriggerDic.get_Item(_evt.firstFrom.Id)++;
					flag = true;
				}
				if (CheckPerkCD(500110, cd_10) && flag)
				{
					_actor.GetLogicComponent<PlayerSkillCd>().AddEnergy(dicPower_10.get_Item(perkLevel2));
				}
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500116, out var _) && CheckPerkCDTimeout(500116, cd_1p))
			{
				_perk1pTriggerCount++;
				if (_perk1pTriggerCount >= triggerCount)
				{
					TriggerPerk(500116);
					_perk1pTrigger = true;
					PlayFireRing(500115, adventureActor.tsTransform.Position);
					_perk1pTriggerCount = 0;
				}
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500115, out var perkLevel4) && CheckPerkCD(500115, cd_15))
			{
				_actor.buffComponent.AddBuff(buffIdDic_15_self.get_Item(perkLevel4), _actor);
				adventureActor.buffComponent?.AddBuff(buffIdDic_15.get_Item(perkLevel4), _actor);
			}
			if (_perkEffectIdList.Count > 0)
			{
				_actor.effectManage.AddEffectByAI(_perkEffectIdList);
			}
			break;
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnHitPost(_evt);
		if (!(_evt.from != _actor) && _perkEffectIdList.Count > 0)
		{
			_actor.effectManage.RemoveEffectByAI(_perkEffectIdList);
		}
	}

	private void OnDied(IEvent evt)
	{
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		if (!(adventureActorDiedEvent.killer != _actor) && adventureActorDiedEvent.damageTag != null)
		{
			for (int i = 0; i < adventureActorDiedEvent.damageTag.Count && !object.Equals(adventureActorDiedEvent.damageTag.get_Item(i), fireRingDamageTag); i++)
			{
			}
		}
	}

	private void OnDiffuseEvent(IEvent evt)
	{
		AdventureAreaEffectDiffuseEvent adventureAreaEffectDiffuseEvent = evt as AdventureAreaEffectDiffuseEvent;
		if (!adventureAreaEffectDiffuseEvent.iDiffuseMax || !_perk2pTriggers.Contains(adventureAreaEffectDiffuseEvent.entityID))
		{
			return;
		}
		string fxAlias = "FX/Perk/fx_perk_base_fire_firering_6m_q2";
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500111, out var _))
		{
			fxAlias = "FX/Perk/fx_perk_base_fire_firering_9m_q2";
		}
		PlayFX playFX = new PlayFX();
		TSVector2 tSVector = new TSVector2(adventureAreaEffectDiffuseEvent.pos.x, adventureAreaEffectDiffuseEvent.pos.z);
		playFX.Play(_actor, null, fxAlias, adventureAreaEffectDiffuseEvent.pos.y, tSVector, _actor.tsTransform.Forward);
		playFX.Clear();
		percetAjust_2p = 0;
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, tSVector, adventureAreaEffectDiffuseEvent.hitBoxRadius, (List<LogicEntity> result) =>
		{
			int count = result.Count;
			if (count > 0)
			{
				count = ((count > numMax) ? numMax : count);
				percetAjust_2p = count * one_percent / 100;
			}
		}, isConfront: true);
		CommomAreaHitConfig commomAreaHitConfig = new CommomAreaHitConfig();
		commomAreaHitConfig.position = tSVector;
		commomAreaHitConfig.hitDamageId = hitId_2p;
		ILRuntimeAPI.CircleAreaHit(_actor, commomAreaHitConfig, adventureAreaEffectDiffuseEvent.hitBoxRadius, 0);
		_perk2pTriggers.Remove(adventureAreaEffectDiffuseEvent.entityID);
	}

	private void PlayFireRing(int hitDamageId, TSVector2 pos = default(TSVector2))
	{
		CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_fire_trigger_s");
		bool iFollow = false;
		int lv;
		if (_perk1pTrigger)
		{
			iFollow = false;
		}
		else if (CanTriggerPerk(500118, out lv, 0))
		{
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.tsTransform.Position, range_3p, (List<LogicEntity> result) =>
			{
				FP fP = FP.MaxValue;
				int index = 0;
				if (result.Count > 0)
				{
					for (int i = 0; i < result.Count; i++)
					{
						FP fP2 = TSVector2.DistanceSquared(result.get_Item(i).tsTransform.Position, _actor.tsTransform.Position);
						if (fP2 < fP)
						{
							fP = fP2;
							index = i;
						}
					}
					pos = result.get_Item(index).tsTransform.Position;
				}
			}, isConfront: true);
			iFollow = false;
		}
		GameObject fireRingPrefab = GetFireRingPrefab(iFollow);
		if (pos == default(TSVector2))
		{
			pos = _actor.tsTransform.Position;
		}
		ILRuntimeAPI.PlayAreaEffect(_actor, fireRingPrefab, pos, default, (AreaEffectEntity entity) =>
		{
			entity.ActiveSelf = true;
			if (CanTriggerPerk(500117, out var _, 0))
			{
				_perk2pTriggers.Add(entity.Id);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500109, out var perkLevel) && !_actor.buffComponent.CheckBuffByBuffTag(buffTag_9))
			{
				if (_perk9TriggerTime <= 0)
				{
					_perk9TriggerTime = _actor.LogicTime;
				}
				else if (_perk9TriggerTime + fixedCd_9 > _actor.LogicTime)
				{
					if (CheckPerkCD(500109, cd_9))
					{
						_actor.buffComponent.AddBuff(buffIdDic_9.get_Item(perkLevel), _actor);
						_perk9TriggerTime = 0;
					}
				}
				else
				{
					_perk9TriggerTime = _actor.LogicTime;
				}
			}
			bool flag = false;
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500111, out var _))
			{
				flag = true;
			}
			bool flag2 = false;
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500113, out var _))
			{
				flag2 = true;
			}
			FP fP = duration;
			string text = "FX/Perk/fx_perk_base_fire_firering_6m_1s_01";
			if (_perk1pTrigger)
			{
				if (flag2)
				{
					fP = duration_1p * 2;
					text = "FX/Perk/fx_perk_base_fire_firering_3m_1s_13q01";
				}
				else
				{
					fP = duration_1p;
					text = "FX/Perk/fx_perk_base_fire_firering_3m_1s_q01";
				}
			}
			else if (flag)
			{
				if (flag2)
				{
					fP = duration_11 * 2;
					text = "FX/Perk/fx_perk_base_fire_firering_9m_1s_13";
				}
				else
				{
					fP = duration_11;
					text = "FX/Perk/fx_perk_base_fire_firering_9m_1s_11";
				}
			}
			else if (flag2)
			{
				fP = duration * 2;
				text = "FX/Perk/fx_perk_base_fire_firering_6m_1s_13";
			}
			entity.duration = fP;
			text = "Assets/AssetBundles/" + text + ".prefab";
			if (_fxPrefabDic.TryGetValue(text, out var value))
			{
				entity.fx = value;
			}
			else
			{
				GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.FX, text, typeof(GameObject)) as GameObject;
				_fxPrefabDic.Add(text, gameObject);
				entity.fx = gameObject;
			}
			AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
			if (logicComponent != null)
			{
				logicComponent.hitDamageId = hitDamageId;
				if (flag2)
				{
					logicComponent.delayClearHittedRecord = true;
					logicComponent.clearHittedRecordDelayTime = fP * 0.5f;
				}
				else
				{
					logicComponent.delayClearHittedRecord = false;
				}
			}
			AreaEffect_DiffuseComponent logicComponent2 = entity.GetLogicComponent<AreaEffect_DiffuseComponent>();
			if (logicComponent2 != null)
			{
				logicComponent2.maxDiffuseTime = fP;
				if (_perk1pTrigger)
				{
					_perk1pTrigger = false;
					logicComponent2.interval = diffuseInterval_1p;
				}
				else if (flag)
				{
					logicComponent2.interval = diffuseInterval_11;
				}
				if (flag2)
				{
					logicComponent2.changeSpeed = true;
					logicComponent2.delay_Change = fP * 0.5f;
					logicComponent2.speed_Change = -diffuseSpeed;
				}
				else
				{
					logicComponent2.changeSpeed = false;
				}
			}
		});
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("AREA_EFFECT_DIFFUSE", OnDiffuseEvent);
		_prefab_FireRing = null;
		_perk10TriggerDic.Clear();
		_perk10TriggerDic = null;
		_perk2pTriggers.Clear();
		_perk2pTriggers = null;
		_perkEffectIdList.Clear();
		_perkEffectIdList = null;
		_fxPrefabDic.Clear();
		_fxPrefabDic = null;
	}

	private GameObject GetFireRingPrefab(bool iFollow)
	{
		if (_prefab_FireRing == null)
		{
			SpawnPool spawnPool = PoolManager.Pools.get_Item("Effect");
			if (spawnPool != null)
			{
				_prefab_FireRing = spawnPool.GetPrefabGo(_fireRingPrefabName);
			}
			if (_prefab_FireRing == null)
			{
				_prefab_FireRing = new GameObject(_fireRingPrefabName);
				AreaEffectEntity areaEffectEntity = InitAreaEntity(_prefab_FireRing);
				InitAttackComponent(areaEffectEntity);
				InitDiffuseComponent(areaEffectEntity);
				if (iFollow)
				{
					InitFollowComponent(areaEffectEntity);
				}
				areaEffectEntity.ActiveSelf = false;
			}
		}
		return _prefab_FireRing;
	}

	private AreaEffectEntity InitAreaEntity(GameObject prefab)
	{
		AreaEffectEntity areaEffectEntity = prefab.AddOrGetComponent<AreaEffectEntity>();
		areaEffectEntity.hitBoxShape = HitBox.Shape.Circle;
		areaEffectEntity.hitBoxInnerRadius = initInnerRadius;
		areaEffectEntity.hitBoxRadius = initInnerRadius + radius;
		areaEffectEntity.UpdateColliderShape();
		return areaEffectEntity;
	}

	private void InitAttackComponent(AreaEffectEntity entity)
	{
		AreaEffect_AttackComponent areaEffect_AttackComponent = entity.AddOrGetMonoLogicComponent<AreaEffect_AttackComponent>();
		areaEffect_AttackComponent.hitDelay = 0;
		areaEffect_AttackComponent.hitInterval = attackInterval;
		areaEffect_AttackComponent.damageImmuneDuration = duration;
	}

	private void InitDiffuseComponent(AreaEffectEntity entity)
	{
		AreaEffect_DiffuseComponent areaEffect_DiffuseComponent = entity.AddOrGetMonoLogicComponent<AreaEffect_DiffuseComponent>();
		areaEffect_DiffuseComponent.interval = diffuseInterval;
		areaEffect_DiffuseComponent.speed = diffuseSpeed;
		areaEffect_DiffuseComponent.radiusTogether = true;
		areaEffect_DiffuseComponent.innerRadiusDiffuseType = AreaEffect_DiffuseComponent.InnerRadiusDiffuseType.SameSpeed;
	}

	private void InitFollowComponent(AreaEffectEntity entity)
	{
		AreaEffect_FollowComponent areaEffect_FollowComponent = entity.AddOrGetMonoLogicComponent<AreaEffect_FollowComponent>();
		areaEffect_FollowComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.Owner;
		areaEffect_FollowComponent.isSlowMove = false;
	}
}
