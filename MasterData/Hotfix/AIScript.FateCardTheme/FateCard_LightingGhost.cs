#define LOG_DEBUG
#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.FateCardTheme;

public class FateCard_LightingGhost : BaseFateCardTheme
{
	private readonly int damageId = 986311;

	private readonly FP cd = 2;

	private const int maxCount = 3;

	private readonly FP triggerStateTime = 5;

	private readonly FP triggerInterval = 0.5;

	private const string lightingGhostPrefabPath = "FateCard_LightingGhost";

	private const string triggerFxPath = "light_ghost_charge";

	private readonly Dictionary<int, TSVector> positionDic = new Dictionary<int, TSVector>
	{
		[1] = new TSVector(-0.6, 1.6, -0.7),
		[2] = new TSVector(0.5, 2.1, -0.5),
		[3] = new TSVector(0.78, 1, -0.3),
		[4] = new TSVector(-1, 1.4, 0),
		[5] = new TSVector(-0.4, 1, -1),
		[6] = new TSVector(0.4, 1.4, -1)
	};

	private static readonly int damageTag_LightingGhost = CommonHelper.StringToHash("LightingGhost");

	private const int hitDamageId_11 = 986312;

	private const string hitFxPath_11 = "light_ghost_lighting_11";

	private const string hittedFxPath_11 = "";

	private readonly FP hitRaidus_11 = 2;

	private const int minHitTimes_11 = 0;

	private const int maxHitTimes_11 = 3;

	private readonly FP hitInterval_11 = 1;

	private const int addMaxCount_Task3 = 1;

	private readonly FP hitInterval_Task3 = 0.5;

	private readonly FP searchTargetRadius_Task3 = 8;

	private const int hitDamageId_Task3 = 986313;

	private const string hitFxPath_Task3 = "light_ghost_lightning_18";

	private bool _inTriggerState;

	private Dictionary<int, LightingGhostEntity> _lightingGhostDic;

	private int _currentMaxCount;

	private CoroutineNode _triggerStateCor;

	private Dictionary<string, GameObject> _lightingGhostPrefabDic;

	private CommomAreaHitConfig _areaHitConfig;

	private CoroutineNode _intervalHitCor;

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_LightingGhost OnEnable");
		base.OnEnable();
		_currentMaxCount = 3;
		if (CanExcuteB)
		{
			_currentMaxCount++;
		}
		if (CanExcuteB)
		{
			_intervalHitCor = StartLogicCoroutine(IntervalHit_ProB());
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("SPECIAL_ENTITY_FINISH", OnSpecialEntityFinish);
	}

	public override void OnDisable()
	{
		base.OnDisable();
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
		if (_triggerStateCor != null)
		{
			StopLogicCoroutine(_triggerStateCor);
		}
		_triggerStateCor = null;
		if (_intervalHitCor != null)
		{
			StopLogicCoroutine(_intervalHitCor);
			_intervalHitCor = null;
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("SPECIAL_ENTITY_FINISH", OnSpecialEntityFinish);
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_LightingGhost OnTrigger");
		if (!_inTriggerState && CheckTimeout(cd) && GenerateLightingGhost(damageId))
		{
			TriggerTheme();
		}
	}

	private bool GenerateLightingGhost(int hitDamageId, bool dontEnterTriggerState = false)
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
		string text = "FateCard_LightingGhost";
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
		if (!string.IsNullOrEmpty("light_ghost_charge"))
		{
			CommonUtils.PlayOneOffFx(_actor, "light_ghost_charge");
		}
		lightingGhostEntity.offset = value;
		lightingGhostEntity.hitDamageId = hitDamageId;
		_lightingGhostDic.Add(nextLightingGhostIndex, lightingGhostEntity);
		if (!dontEnterTriggerState && _lightingGhostDic.Count >= _currentMaxCount)
		{
			EnterTriggerState();
		}
		return true;
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnHitPost(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		AdventureActor actor = _evt.from as AdventureActor;
		if (monsterAdventureActor != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_LightingGhost) && CanExcuteA)
		{
			StartLogicCoroutine(AreaHit_Perk11(actor, monsterAdventureActor));
		}
	}

	private IEnumerator AreaHit_Perk11(AdventureActor actor, AdventureActor target)
	{
		int totalHitTimes = TSRandom.Range(0, 4);
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
			_areaHitConfig.fxAlias = "light_ghost_lighting_11";
			_areaHitConfig.hitDamageId = 986312;
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

	private IEnumerator SingleHit_PerkTask3(int index)
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
						ILRuntimeAPI.HitActor(actor, target, 986313, null, "light_ghost_lightning_18", attackFxPlayOnTarget: true, HitBox.FeatureFlag.None, null, default, HitBox.HurtAnimType.Small, 0, gameObject);
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

	private IEnumerator IntervalHit_ProB()
	{
		FP hitInterval = hitInterval_Task3;
		while (true)
		{
			if (_lightingGhostDic != null && _lightingGhostDic.Count > 0 && !_inTriggerState)
			{
				if (hitInterval > 0)
				{
					hitInterval -= LogicDeltaTime;
				}
				else
				{
					ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.tsTransform.Position, searchTargetRadius_Task3, (List<LogicEntity> result) =>
					{
						if (result.Count > 0)
						{
							AdventureActor target = result.get_Item(TSRandom.Range(0, result.Count)) as AdventureActor;
							for (int i = 0; i < _lightingGhostDic.Count; i++)
							{
								ILRuntimeAPI.HitActor(_actor, target, 986313, null, "light_ghost_lightning_18", attackFxPlayOnTarget: true, HitBox.FeatureFlag.None, null, -1, HitBox.HurtAnimType.Small, 0, _lightingGhostDic.Values.ToList().get_Item(i).gameObject);
							}
							hitInterval = hitInterval_Task3;
						}
						else
						{
							hitInterval = 0;
						}
					}, isConfront: true);
				}
			}
			yield return null;
		}
	}

	private void OnSpecialEntityFinish(IEvent evt)
	{
		LightingGhostEntity lightingGhostEntity = (evt as SpecialEntityFinishEvent).entity as LightingGhostEntity;
		if (!(lightingGhostEntity == null))
		{
			FinishLightingGhost(lightingGhostEntity.Id);
		}
	}

	private void FinishLightingGhost(long entityId)
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
		}
	}

	private int GetNextLightingGhostIndex()
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

	private GameObject GetLightingGhostPrefab(string path)
	{
		if (_lightingGhostPrefabDic == null)
		{
			_lightingGhostPrefabDic = new Dictionary<string, GameObject>(3);
		}
		if (!_lightingGhostPrefabDic.ContainsKey(path))
		{
			GameObject bulletByAlias = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(_actor, path, forceUseCommonConfig: true);
			_lightingGhostPrefabDic.Add(path, bulletByAlias);
		}
		return _lightingGhostPrefabDic.get_Item(path);
	}

	private void EnterTriggerState()
	{
		if (_triggerStateCor != null)
		{
			StopLogicCoroutine(_triggerStateCor);
		}
		_triggerStateCor = StartLogicCoroutine(TriggerStateLogic());
	}

	private IEnumerator TriggerStateLogic()
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

	private int GetAttackLightingGhostCount()
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

	private bool TriggerAttackLightingGhost()
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
}
