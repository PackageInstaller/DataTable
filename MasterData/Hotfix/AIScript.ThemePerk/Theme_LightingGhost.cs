#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.ThemePerk;

public class Theme_LightingGhost : BaseTheme
{
	private readonly Dictionary<int, TSVector> positionDic = new Dictionary<int, TSVector>
	{
		[1] = new TSVector(-0.6, 1.6, -0.7),
		[2] = new TSVector(0.5, 2.1, -0.5),
		[3] = new TSVector(0.78, 1, -0.3),
		[4] = new TSVector(-1, 1.4, 0),
		[5] = new TSVector(-0.4, 1, -1),
		[6] = new TSVector(0.4, 1.4, -1)
	};

	private const string triggerFxPath = "FX/Perk/fx_perk_base_light_ghost_charge";

	private const int maxCount = 3;

	private readonly FP triggerStateTime = 5;

	private readonly FP triggerInterval = 0.5;

	private const int additionalAttrId_LightingGhost = 3;

	private const string lightingGhostPrefabPath = "Misc/FateCard/Theme_LightingGhost";

	private static readonly int damageTag_LightingGhost = CommonHelper.StringToHash("LightingGhost");

	private static readonly int lightMarkTag = CommonHelper.StringToHash("LightTag");

	private const int perkId_1 = 501301;

	private readonly FP triggerPercentage_1 = 100;

	private readonly FP cd_1 = 2;

	private const int hitDamageId_1 = 501301;

	private const int perkId_2 = 501302;

	private readonly FP triggerPercentage_2 = 100;

	private readonly FP cd_2 = 2;

	private const int hitDamageId_2 = 501302;

	private const int perkId_3 = 501303;

	private readonly FP triggerPercentage_3 = 100;

	private readonly FP cd_3 = 2;

	private const int hitDamageId_3 = 501303;

	private const int perkId_4 = 501304;

	private readonly FP triggerPercentage_4 = 100;

	private readonly FP cd_4 = 2;

	private const int hitDamageId_4 = 501304;

	private const int perkId_8 = 501308;

	private readonly Dictionary<int, int> buffIdDic_8 = new Dictionary<int, int>
	{
		[1] = 130811,
		[2] = 130821,
		[3] = 130831,
		[4] = 130841,
		[5] = 130851
	};

	private const int perkId_9 = 501309;

	private readonly Dictionary<int, int> additionalAttrIdDic_9 = new Dictionary<int, int>
	{
		[1] = 4,
		[2] = 8,
		[3] = 12,
		[4] = 17,
		[5] = 20
	};

	private const int perkId_10 = 501310;

	private readonly Dictionary<int, int> additionalAttrIdDic_10 = new Dictionary<int, int>
	{
		[1] = 38,
		[2] = 316,
		[3] = 324,
		[4] = 316,
		[5] = 318
	};

	private const int perkId_11 = 501311;

	private const int hitDamageId_11 = 501311;

	private const string hitFxPath_11 = "FX/Perk/fx_perk_base_light_ghost_lighting_11";

	private const string hittedFxPath_11 = "";

	private readonly FP hitRaidus_11 = 2;

	private const int minHitTimes_11 = 0;

	private const int maxHitTimes_11 = 3;

	private readonly FP hitInterval_11 = 1;

	private const int perkId_12 = 501312;

	private readonly Dictionary<int, FP> triggerPercentDic_12 = new Dictionary<int, FP>
	{
		[1] = 25,
		[2] = 50,
		[3] = 75,
		[4] = 25,
		[5] = 30
	};

	private const string lightingGhostPrefabPath_12 = "Misc/FateCard/Theme_LightingGhost_12";

	private const int maxCount_12 = 1;

	private const int perkId_13 = 501313;

	private readonly FP cd_13 = 100;

	private readonly Dictionary<int, int> triggerTimesDic_13 = new Dictionary<int, int>
	{
		[1] = 10,
		[2] = 8,
		[3] = 6,
		[4] = 5,
		[5] = 5
	};

	private const int hitDamageId_13 = 501313;

	private const int perkId_14 = 501314;

	private readonly Dictionary<int, FP> triggerPercentDic_14 = new Dictionary<int, FP>
	{
		[1] = 20,
		[2] = 40,
		[3] = 60,
		[4] = 40,
		[5] = 45
	};

	private const string dropFxPath = "Misc/FateCard/Theme_LightingGhost_Drop_14";

	private const int hitDamageId_14 = 501314;

	private const int perkId_15 = 501315;

	private const int generateCount_15 = 3;

	private const int hitDamageId_15 = 501315;

	private readonly Dictionary<int, FP> triggerCDDic_15 = new Dictionary<int, FP>
	{
		[1] = 15,
		[2] = 12,
		[3] = 9,
		[4] = 8,
		[5] = 5
	};

	private const string triggerFxPath_15 = "FX/Perk/fx_perk_base_light_ghost_out_15";

	private const int perkId_Task1 = 501316;

	private const int minStrengthenCount_Task1 = 1;

	private const int maxStrengthenCount_Task1 = 3;

	private const string lightingGhostPrefabPath_Task1 = "Misc/FateCard/Theme_LightingGhost_16";

	private const int hitDamageId_Task1 = 501316;

	private const int perkId_Task2 = 501317;

	private const int buffId_Task2 = 131711;

	private readonly FP durationTime_Task2 = 5;

	private const int hitDamageId_Task2 = 501317;

	private readonly FP hitInterval_Task2 = 1;

	private const string hittedFxPath_Task2 = "FX/Perk/fx_perk_base_light_ghost_hit_17";

	private readonly List<int> buffIdList_Damage_Task2 = new List<int> { 3011, 131712 };

	private const int perkId_Task3 = 501318;

	private const int addMaxCount_Task3 = 1;

	private readonly FP hitInterval_Task3 = 0.5;

	private readonly FP searchTargetRadius_Task3 = 8;

	private const int hitDamageId_Task3 = 501318;

	private const string hitFxPath_Task3 = "FX/Perk/fx_perk_bullet_light_ghost_lightning_18";

	private Dictionary<string, GameObject> _lightingGhostPrefabDic;

	private int _currentMaxCount;

	private Dictionary<int, LightingGhostEntity> _lightingGhostDic;

	private bool _inTriggerState;

	private HitBox.HitBoxFeatureData _featureData;

	private CommomAreaHitConfig _areaHitConfig;

	private int _triggerTimes_13;

	private List<long> _dropIdList_14;

	private CoroutineNode _triggerStateCor;

	private CoroutineNode _perkCor_15;

	private Dictionary<int, CoroutineNode> _perkCorDic_Task3;

	public override void OnEnable()
	{
		base.OnEnable();
		Clear();
		_currentMaxCount = 3;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501318, out var _))
		{
			_currentMaxCount++;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501315, out var perkLevel2))
		{
			_perkCor_15 = StartLogicCoroutine(CheckLogic_Perk15(triggerCDDic_15.get_Item(perkLevel2)));
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("SPECIAL_ENTITY_FINISH", OnSpecialEntityFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		if (!_inTriggerState && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501301, out var _) && CheckPerkCDTimeout(501301, cd_1) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_1 && GenerateLightingGhost(501301))
		{
			TriggerPerk(501301);
		}
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		if (_inTriggerState)
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501302, out var _) && CheckPerkCDTimeout(501302, cd_2) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_2 && GenerateLightingGhost(501302))
		{
			TriggerPerk(501302);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501313, out var perkLevel2))
		{
			_triggerTimes_13++;
			if (CheckPerkCDTimeout(501313, cd_13) && _triggerTimes_13 >= triggerTimesDic_13.get_Item(perkLevel2) && GenerateLightingGhost(501313))
			{
				_triggerTimes_13 = 0;
				TriggerPerk(501313);
			}
		}
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		if (!_inTriggerState && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501303, out var _) && CheckPerkCDTimeout(501303, cd_3) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_3 && GenerateLightingGhost(501303))
		{
			TriggerPerk(501303);
		}
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		if (!_inTriggerState && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501304, out var _) && CheckPerkCDTimeout(501304, cd_4) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_4 && GenerateLightingGhost(501304))
		{
			TriggerPerk(501304);
		}
	}

	protected IEnumerator CheckLogic_Perk15(FP cd)
	{
		while (true)
		{
			if (_inTriggerState || GetAttackLightingGhostCount() > 0 || !CheckPerkCDTimeout(501315, cd))
			{
				yield return null;
				continue;
			}
			if (!string.IsNullOrEmpty("FX/Perk/fx_perk_base_light_ghost_out_15"))
			{
				CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_light_ghost_out_15");
			}
			int num = ((3 >= _currentMaxCount) ? _currentMaxCount : 3);
			for (int i = 0; i < num; i++)
			{
				GenerateLightingGhost(501315);
			}
			TriggerPerk(501315);
		}
	}

	protected bool GenerateLightingGhost(int hitDamageId, bool strengthen = false, bool dontEnterTriggerState = false)
	{
		if (_inTriggerState)
		{
			return false;
		}
		if (_lightingGhostDic == null)
		{
			_lightingGhostDic = new Dictionary<int, LightingGhostEntity>(5);
		}
		else if (!dontEnterTriggerState && _lightingGhostDic.Count >= _currentMaxCount)
		{
			EnterTriggerState();
			return false;
		}
		LightingGhostEntity.LightingGhostType lightingGhostType = LightingGhostEntity.LightingGhostType.Normal;
		int perkLevel;
		if (strengthen)
		{
			lightingGhostType = LightingGhostEntity.LightingGhostType.Strengthen;
		}
		else if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501312, out perkLevel) && GetLightingGhostCountByType(LightingGhostEntity.LightingGhostType.Timid) < 1 && TSRandom.Range(FP.Zero, 100) <= triggerPercentDic_12.get_Item(perkLevel))
		{
			lightingGhostType = LightingGhostEntity.LightingGhostType.Timid;
		}
		string text = null;
		switch (lightingGhostType)
		{
		case LightingGhostEntity.LightingGhostType.Normal:
			text = "Misc/FateCard/Theme_LightingGhost";
			break;
		case LightingGhostEntity.LightingGhostType.Strengthen:
			text = "Misc/FateCard/Theme_LightingGhost_16";
			break;
		case LightingGhostEntity.LightingGhostType.Timid:
			text = "Misc/FateCard/Theme_LightingGhost_12";
			break;
		}
		if (string.IsNullOrEmpty(text))
		{
			return false;
		}
		GameObject lightingGhostPrefab = GetLightingGhostPrefab(text);
		if (lightingGhostPrefab == null)
		{
			return false;
		}
		int nextLightingGhostIndex = GetNextLightingGhostIndex();
		if (!positionDic.TryGetValue(nextLightingGhostIndex, out var value))
		{
			NovaLogger.Error($"电鬼位置偏移未配置,槽位索引:{nextLightingGhostIndex}");
		}
		TSVector jVector = _actor.tsTransform.Position3D + value;
		LightingGhostEntity lightingGhostEntity = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, lightingGhostPrefab, jVector.ToVector(), _actor.transform.rotation) as LightingGhostEntity;
		if (lightingGhostEntity == null)
		{
			return false;
		}
		if (!string.IsNullOrEmpty("FX/Perk/fx_perk_base_light_ghost_charge"))
		{
			CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_light_ghost_charge");
		}
		lightingGhostEntity.offset = value;
		lightingGhostEntity.hitDamageId = hitDamageId;
		_lightingGhostDic.Add(nextLightingGhostIndex, lightingGhostEntity);
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501318, out var _))
		{
			if (_perkCorDic_Task3 == null)
			{
				_perkCorDic_Task3 = new Dictionary<int, CoroutineNode>(5);
			}
			if (_perkCorDic_Task3.ContainsKey(nextLightingGhostIndex))
			{
				StopLogicCoroutine(_perkCorDic_Task3.get_Item(nextLightingGhostIndex));
				_perkCorDic_Task3.Remove(nextLightingGhostIndex);
			}
			_perkCorDic_Task3.Add(nextLightingGhostIndex, StartLogicCoroutine(SingleHit_PerkTask3(nextLightingGhostIndex)));
		}
		if (!dontEnterTriggerState && _lightingGhostDic.Count >= _currentMaxCount)
		{
			EnterTriggerState();
		}
		return true;
	}

	protected void EnterTriggerState()
	{
		if (_triggerStateCor != null)
		{
			StopLogicCoroutine(_triggerStateCor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501316, out var _))
		{
			int num = TSRandom.Range(1, 4);
			for (int i = 0; i < num; i++)
			{
				LightingGhostEntity firstLightingGhostByType = GetFirstLightingGhostByType(LightingGhostEntity.LightingGhostType.Normal);
				if (!(firstLightingGhostByType != null))
				{
					break;
				}
				firstLightingGhostByType.Finish();
				GenerateLightingGhost(501316, strengthen: true, dontEnterTriggerState: true);
			}
		}
		_triggerStateCor = StartLogicCoroutine(TriggerStateLogic());
	}

	protected IEnumerator TriggerStateLogic()
	{
		_inTriggerState = true;
		FP duration = triggerStateTime;
		FP interval = 0;
		while (duration > 0 && GetAttackLightingGhostCount() > 0)
		{
			if (!(interval > 0))
			{
				interval = ((!TriggerAttackLightingGhost()) ? ((FP)0) : triggerInterval);
			}
			else
			{
				interval -= LogicDeltaTime;
			}
			duration -= LogicDeltaTime;
			yield return null;
		}
		_inTriggerState = false;
	}

	protected void OnSpecialEntityFinish(IEvent evt)
	{
		LightingGhostEntity lightingGhostEntity = (evt as SpecialEntityFinishEvent).entity as LightingGhostEntity;
		if (!(lightingGhostEntity == null))
		{
			FinishLightingGhost(lightingGhostEntity.Id);
		}
	}

	protected void FinishLightingGhost(long entityId)
	{
		if (_lightingGhostDic == null)
		{
			return;
		}
		int num = -1;
		foreach (int key in _lightingGhostDic.Keys)
		{
			LightingGhostEntity lightingGhostEntity = _lightingGhostDic.get_Item(key);
			if (lightingGhostEntity != null && lightingGhostEntity.Id == entityId)
			{
				num = key;
				break;
			}
		}
		if (num > 0)
		{
			_lightingGhostDic.Remove(num);
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501318, out var _) && _perkCorDic_Task3 != null && _perkCorDic_Task3.ContainsKey(num))
			{
				StopLogicCoroutine(_perkCorDic_Task3.get_Item(num));
				_perkCorDic_Task3.Remove(num);
			}
		}
	}

	protected GameObject GetLightingGhostPrefab(string path)
	{
		if (_lightingGhostPrefabDic == null)
		{
			_lightingGhostPrefabDic = new Dictionary<string, GameObject>(3);
		}
		if (!_lightingGhostPrefabDic.ContainsKey(path))
		{
			string assetName = "Assets/AssetBundles/" + path + ".prefab";
			GameObject value = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
			_lightingGhostPrefabDic.Add(path, value);
		}
		return _lightingGhostPrefabDic.get_Item(path);
	}

	protected int GetNextLightingGhostIndex()
	{
		int num = 1;
		for (int i = 0; i < _lightingGhostDic.Count; i++)
		{
			if (!_lightingGhostDic.ContainsKey(num))
			{
				break;
			}
			num++;
		}
		return num;
	}

	protected LightingGhostEntity GetFirstLightingGhostByType(LightingGhostEntity.LightingGhostType type)
	{
		if (_lightingGhostDic == null)
		{
			return null;
		}
		foreach (LightingGhostEntity value in _lightingGhostDic.Values)
		{
			if (value.type == type)
			{
				return value;
			}
		}
		return null;
	}

	protected int GetAttackLightingGhostCount()
	{
		if (_lightingGhostDic == null)
		{
			return 0;
		}
		int num = 0;
		foreach (LightingGhostEntity value in _lightingGhostDic.Values)
		{
			if (value.type == LightingGhostEntity.LightingGhostType.Normal || value.type == LightingGhostEntity.LightingGhostType.Strengthen)
			{
				num++;
			}
		}
		return num;
	}

	protected int GetLightingGhostCountByType(LightingGhostEntity.LightingGhostType type)
	{
		if (_lightingGhostDic == null)
		{
			return 0;
		}
		int num = 0;
		foreach (LightingGhostEntity value in _lightingGhostDic.Values)
		{
			if (value.type == type)
			{
				num++;
			}
		}
		return num;
	}

	protected bool TriggerAttackLightingGhost()
	{
		if (_lightingGhostDic == null)
		{
			return false;
		}
		foreach (LightingGhostEntity value in _lightingGhostDic.Values)
		{
			if ((value.type == LightingGhostEntity.LightingGhostType.Normal || value.type == LightingGhostEntity.LightingGhostType.Strengthen) && !value.InTriggerState)
			{
				return value.TryTrigger();
			}
		}
		return false;
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		MonsterAdventureActor obj = _evt.to as MonsterAdventureActor;
		_ = _evt.from;
		if (!(obj != null))
		{
			return;
		}
		if (_lightingGhostDic != null && _lightingGhostDic.Count > 0)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501309, out var perkLevel))
			{
				AdventureActor.AddToAttr(additionalAttrIdDic_9.get_Item(perkLevel), _actor, _lightingGhostDic.Count);
			}
			else
			{
				AdventureActor.AddToAttr(3, _actor, _lightingGhostDic.Count);
			}
		}
		if (CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_LightingGhost) && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501310, out var perkLevel2))
		{
			AdventureActor.AddToAttr(additionalAttrIdDic_10.get_Item(perkLevel2), _actor);
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnHitPost(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		AdventureActor actor = _evt.from as AdventureActor;
		if (monsterAdventureActor != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_LightingGhost))
		{
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501308, out var perkLevel))
			{
				monsterAdventureActor.buffComponent?.AddBuff(buffIdDic_8.get_Item(perkLevel), _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501311, out var perkLevel2))
			{
				StartLogicCoroutine(AreaHit_Perk11(actor, monsterAdventureActor));
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501317, out perkLevel2))
			{
				StartLogicCoroutine(SingleHit_PerkTask2(actor, monsterAdventureActor));
			}
		}
	}

	protected override void OnMonsterKilled(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnMonsterKilled(_evt);
		if (!ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501314, out var perkLevel))
		{
			return;
		}
		if (_dropIdList_14 == null)
		{
			_dropIdList_14 = new List<long>();
		}
		if (TSRandom.Range(FP.Zero, 100) <= triggerPercentDic_14.get_Item(perkLevel))
		{
			long num = ILRuntimeAPI.PlayDrop(_evt.to as AdventureActor, "Misc/FateCard/Theme_LightingGhost_Drop_14");
			if (num > 0)
			{
				_dropIdList_14.Add(num);
			}
		}
	}

	protected void OnDropFinish(IEvent evt)
	{
		if (!ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501314, out var _))
		{
			return;
		}
		AdventureDropFinishEvent adventureDropFinishEvent = evt as AdventureDropFinishEvent;
		if (_dropIdList_14 != null && _dropIdList_14.Contains(adventureDropFinishEvent.entityID))
		{
			if (adventureDropFinishEvent.isPickUp)
			{
				GenerateLightingGhost(501314);
			}
			_dropIdList_14.Remove(adventureDropFinishEvent.entityID);
		}
	}

	protected IEnumerator AreaHit_Perk11(AdventureActor actor, AdventureActor target)
	{
		int totalHitTimes = TSRandom.Range(0, 4);
		if (CommonUtils.CheckElementMark(CommonDefine.Water, target))
		{
			totalHitTimes = 3;
		}
		int hitTimes = 0;
		TSVector2 position = target.tsTransform.Position;
		long targetId = target.Id;
		while (hitTimes < totalHitTimes)
		{
			if (_areaHitConfig == null)
			{
				_areaHitConfig = new CommomAreaHitConfig();
			}
			_areaHitConfig.position = position;
			_areaHitConfig.fxAlias = "FX/Perk/fx_perk_base_light_ghost_lighting_11";
			_areaHitConfig.hitDamageId = 501311;
			_areaHitConfig.hittedEffectAlias = "";
			_areaHitConfig.damageImmuneDuration = -1;
			ILRuntimeAPI.CircleAreaHit(actor, _areaHitConfig, hitRaidus_11, 0);
			hitTimes++;
			FP interval = hitInterval_11;
			while (interval > 0)
			{
				if (target.Id == targetId && !target.IsDead())
				{
					position = target.tsTransform.Position;
				}
				interval -= LogicDeltaTime;
				yield return null;
			}
		}
	}

	protected IEnumerator SingleHit_PerkTask2(AdventureActor actor, AdventureActor target)
	{
		target.buffComponent.AddBuff(131711, _actor);
		FP duration = durationTime_Task2;
		FP hitInterval = hitInterval_Task2;
		long targetId = target.Id;
		while (duration > 0)
		{
			if (target.Id != targetId || target.IsDead())
			{
				yield break;
			}
			if (hitInterval > 0)
			{
				hitInterval -= LogicDeltaTime;
			}
			else
			{
				if (_featureData == null)
				{
					_featureData = new HitBox.HitBoxFeatureData();
				}
				_featureData.buffIdsForTarget = buffIdList_Damage_Task2;
				ILRuntimeAPI.HitActor(actor, target, 501317, "FX/Perk/fx_perk_base_light_ghost_hit_17", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.AddBuffForTarget, _featureData);
				hitInterval = hitInterval_Task2;
			}
			duration -= LogicDeltaTime;
			yield return null;
		}
		target.buffComponent.RemoveBuffByBuffId(131711);
	}

	protected IEnumerator SingleHit_PerkTask3(int index)
	{
		FP hitInterval = 0;
		while (_lightingGhostDic != null && _lightingGhostDic.ContainsKey(index))
		{
			LightingGhostEntity lightingGhost = _lightingGhostDic.get_Item(index);
			if (lightingGhost.InTriggerState)
			{
				break;
			}
			if (hitInterval > 0)
			{
				hitInterval -= LogicDeltaTime;
			}
			else
			{
				ILRuntimeAPI.SearchByRangeAndPosition(_actor, lightingGhost.tsTransform.Position, searchTargetRadius_Task3, (List<LogicEntity> result) =>
				{
					if (result.Count > 0)
					{
						AdventureActor actor = _actor;
						AdventureActor target = result.get_Item(TSRandom.Range(0, result.Count)) as AdventureActor;
						GameObject gameObject = lightingGhost.gameObject;
						ILRuntimeAPI.HitActor(actor, target, 501318, null, "FX/Perk/fx_perk_bullet_light_ghost_lightning_18", attackFxPlayOnTarget: true, HitBox.FeatureFlag.None, null, default, HitBox.HurtAnimType.Small, 0, gameObject);
						hitInterval = hitInterval_Task3;
					}
					else
					{
						hitInterval = 0;
					}
				}, isConfront: true);
			}
			yield return null;
		}
	}

	protected void Clear()
	{
		if (_triggerStateCor != null)
		{
			StopLogicCoroutine(_triggerStateCor);
		}
		_triggerStateCor = null;
		if (_perkCor_15 != null)
		{
			StopLogicCoroutine(_perkCor_15);
		}
		_perkCor_15 = null;
		if (_perkCorDic_Task3 != null)
		{
			foreach (CoroutineNode value in _perkCorDic_Task3.Values)
			{
				if (value != null)
				{
					StopLogicCoroutine(value);
				}
			}
			_perkCorDic_Task3.Clear();
		}
		if (_lightingGhostDic != null)
		{
			List<int> list = _lightingGhostDic.Keys.ToList();
			for (int i = 0; i < list.Count; i++)
			{
				int key = list.get_Item(i);
				_lightingGhostDic.get_Item(key)?.Finish();
			}
			_lightingGhostDic.Clear();
		}
		_triggerTimes_13 = 0;
		_dropIdList_14?.Clear();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("SPECIAL_ENTITY_FINISH", OnSpecialEntityFinish);
		Clear();
	}
}
