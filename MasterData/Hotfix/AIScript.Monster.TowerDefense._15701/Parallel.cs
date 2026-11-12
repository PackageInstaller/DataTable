using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.TowerDefense._15701;

public class Parallel : TowerCharacterParalletBase
{
	private class MarkInfo
	{
		public MonsterAdventureActor target;

		public PlayFX linkFx;

		public FP hitCD;
	}

	private int hitTag_Mark = CommonHelper.StringToHash("Mark");

	private int markHitCount = 3;

	public const int buffId_Mark = 801570050;

	private string linkFxAlias = "157_SuoLian";

	private static readonly FP outDistance = FP.One * 3 / 10;

	private const int perkId_1 = 1570101;

	private const int hitDamageId_P1 = 80157023;

	private const string hittedFx_P1 = "Actor/Character/13701/FX/fx_13701_hit_Fly.prefab";

	private static readonly FP hitWidth_P1 = 2;

	private static readonly FP hitInterval_P1 = 1;

	public const int perkId_2 = 1570102;

	public const int buffId_P2 = 801570030;

	public const string fishOverloadEntityKey_P2 = "157SkillMainP2FishObject";

	private const int perkId_3 = 1570103;

	private const int searchRangeAdd_3 = 3;

	private int buffId_Slow = 801570040;

	private bool _perk3RangeHookInstalled;

	private static readonly Predicate<LogicEntity> perTargetMarkFilter = IsMarkTarget;

	public const int perkId_4 = 1570104;

	public static readonly int damageTag_Trigger_P4 = CommonHelper.StringToHash("157FishAtk");

	public const string areaEffectKey_P4 = "AreaEffect_157_P1_FishAtk";

	public static FP triggerCD_4 = 1;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1570107] = 25 };

	private Dictionary<long, MarkInfo> _marks = new Dictionary<long, MarkInfo>();

	private Dictionary<long, int> _hitCounter = new Dictionary<long, int>();

	private List<long> _removeCache = new List<long>();

	private CommomAreaHitConfig commonAreaHitConfig;

	private ISpecialEntity _fishOverloadEntity_P2;

	private bool IsPerk3Active => GetPerk(1570103);

	private FP MarkExtraRange
	{
		get
		{
			if (!IsPerk3Active)
			{
				return FP.Zero;
			}
			return 3;
		}
	}

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	private static bool IsMarkTarget(LogicEntity entity)
	{
		if (entity is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.buffComponent != null)
		{
			return monsterAdventureActor.buffComponent.CheckBuffByBuffID(801570050);
		}
		return false;
	}

	private void SyncPerk3RangeHook(bool active)
	{
		if (_perk3RangeHookInstalled != active)
		{
			_perk3RangeHookInstalled = active;
			actor.perTargetExtraSearchRange = (active ? 3 : 0);
			actor.perTargetExtraSearchRangeFilter = (active ? perTargetMarkFilter : null);
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		SyncPerk3RangeHook(IsPerk3Active);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("SPECIAL_ENTITY_FINISH", OnSpecialEntityFinish);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		SyncPerk3RangeHook(active: false);
		foreach (MarkInfo value in _marks.Values)
		{
			StopLinkFx(value);
		}
		_marks.Clear();
		_hitCounter.Clear();
		_removeCache.Clear();
		_fishOverloadEntity_P2?.Finish();
		_fishOverloadEntity_P2 = null;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("SPECIAL_ENTITY_FINISH", OnSpecialEntityFinish);
	}

	private void OnSpecialEntityFinish(IEvent evt)
	{
		if (evt is SpecialEntityFinishEvent specialEntityFinishEvent && specialEntityFinishEvent.entity == _fishOverloadEntity_P2)
		{
			_fishOverloadEntity_P2 = null;
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff adventureActorRemoveBuff && adventureActorRemoveBuff.eventInfo.buffId == 801570050 && adventureActorRemoveBuff.sender is MonsterAdventureActor monsterAdventureActor && _marks.ContainsKey(monsterAdventureActor.Id) && !_removeCache.Contains(monsterAdventureActor.Id))
		{
			_removeCache.Add(monsterAdventureActor.Id);
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff { sender: AdventureActor sender } adventureActorGetBuff && sender == _actor && adventureActorGetBuff.eventInfo.buffId == 801570030 && GetPerk(1570102) && _fishOverloadEntity_P2 == null)
		{
			GameObject fXByAlias = _actor.comboGroup.relatedResourceConfig.GetFXByAlias("157SkillMainP2FishObject");
			_fishOverloadEntity_P2 = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, fXByAlias, _actor.transform.position, Quaternion.identity);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (!isSelf || monster == null)
		{
			return;
		}
		FP centerDistance;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_Trigger_P4))
		{
			FP cd = triggerCD_4;
			if (GetPerk(1570104, cd))
			{
				AdventureActor adventureActor = _actor;
				TSVector2 position = monster.tsTransform.Position;
				centerDistance = default;
				ILRuntimeAPI.PlayAreaEffect(adventureActor, "AreaEffect_157_P1_FishAtk", position, centerDistance);
			}
		}
		if (!CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Mark))
		{
			return;
		}
		long id = monster.Id;
		if (_marks.ContainsKey(id))
		{
			return;
		}
		if (GetSurfaceDistance(monster, out centerDistance) > actor.EffectiveSearchRange + MarkExtraRange)
		{
			_hitCounter.Remove(id);
			return;
		}
		_hitCounter.TryGetValue(id, out var value);
		value++;
		if (value >= markHitCount)
		{
			_hitCounter.Remove(id);
			AddMark(monster);
		}
		else
		{
			_hitCounter.set_Item(id, value);
		}
	}

	private FP GetSurfaceDistance(MonsterAdventureActor target, out FP centerDistance)
	{
		centerDistance = TSVector2.Distance(actor.tsTransform.Position, target.tsTransform.Position);
		return centerDistance - target.GetRadius();
	}

	private void AddMark(MonsterAdventureActor monster)
	{
		monster.buffComponent.AddBuff(801570050, _actor);
		PlayFX playFX = new PlayFX();
		playFX.PlayLinFx(_actor, linkFxAlias, 1f, useCustSource: true, _actor.gameObject, default, default, monster.gameObject, default, default);
		_marks.set_Item(monster.Id, new MarkInfo
		{
			target = monster,
			linkFx = playFX,
			hitCD = hitInterval_P1
		});
	}

	public void OnUpdate()
	{
		bool isPerk3Active = IsPerk3Active;
		SyncPerk3RangeHook(isPerk3Active);
		if (_marks.Count == 0)
		{
			_removeCache.Clear();
			return;
		}
		FP fP = actor.EffectiveSearchRange + (isPerk3Active ? ((FP)3) : FP.Zero) + outDistance;
		foreach (KeyValuePair<long, MarkInfo> mark in _marks)
		{
			MarkInfo value = mark.Value;
			MonsterAdventureActor target = value.target;
			if (target == null || !target.actorHealthInfo.isAlive)
			{
				_removeCache.Add(mark.Key);
				continue;
			}
			if (GetSurfaceDistance(target, out var centerDistance) > fP)
			{
				_removeCache.Add(mark.Key);
				continue;
			}
			if (isPerk3Active)
			{
				UpdateSlowLayers(target, centerDistance);
			}
			if (!GetPerk(1570101))
			{
				continue;
			}
			if (value.hitCD > 0)
			{
				value.hitCD -= _actor.LogicDeltaTime;
				continue;
			}
			if (commonAreaHitConfig == null)
			{
				commonAreaHitConfig = new CommomAreaHitConfig
				{
					hitDamageId = 80157023,
					hittedEffectAlias = "Actor/Character/13701/FX/fx_13701_hit_Fly.prefab"
				};
			}
			TSVector2 tSVector = target.tsTransform.Position - _actor.tsTransform.Position;
			commonAreaHitConfig.position = _actor.tsTransform.Position + tSVector * 0.5f;
			commonAreaHitConfig.direction = tSVector.normalized;
			ILRuntimeAPI.RectangleAreaHit(_actor, commonAreaHitConfig, hitWidth_P1, centerDistance);
			value.hitCD += hitInterval_P1;
		}
		for (int i = 0; i < _removeCache.Count; i++)
		{
			RemoveMark(_removeCache.get_Item(i));
		}
		_removeCache.Clear();
	}

	private void UpdateSlowLayers(MonsterAdventureActor target, FP distance)
	{
		int num = Mathf.Max(0, TSMath.FloorToInt(distance));
		int buffNumByID = target.buffComponent.GetBuffNumByID(buffId_Slow);
		if (num > buffNumByID)
		{
			target.buffComponent.AddBuffNum(buffId_Slow, num - buffNumByID, _actor);
		}
		else if (num < buffNumByID)
		{
			target.buffComponent.RemoveBuffByBuffId(buffId_Slow, buffNumByID - num);
		}
	}

	private void RemoveMark(long id)
	{
		if (_marks.TryGetValue(id, out var value))
		{
			_marks.Remove(id);
			_hitCounter.Remove(id);
			StopLinkFx(value);
			MonsterAdventureActor target = value.target;
			if (target != null)
			{
				target.buffComponent.RemoveBuffByBuffId(801570050);
				target.buffComponent.RemoveBuffByBuffId(buffId_Slow);
			}
			value.hitCD = 0;
		}
	}

	private void StopLinkFx(MarkInfo info)
	{
		if (info?.linkFx != null && info.linkFx.GetFxPlayerToken() != 0L)
		{
			info.linkFx.Stop();
			info.linkFx.Clear();
		}
	}

	public override void OnPersonalPerkUpdate(AdventureActorPersonalPerkUpdateEvent evt)
	{
		base.OnPersonalPerkUpdate(evt);
		if (evt.actorDataId == _actor.dataID && evt.perkId == 1570103)
		{
			bool flag = evt.isNew || evt.newLevel > 0;
			SyncPerk3RangeHook(flag);
			if (!flag)
			{
				ClearSlowLayers();
			}
		}
	}

	private void ClearSlowLayers()
	{
		foreach (MarkInfo value in _marks.Values)
		{
			MonsterAdventureActor target = value.target;
			if (target != null)
			{
				target.buffComponent.RemoveBuffByBuffId(buffId_Slow);
			}
		}
	}
}
