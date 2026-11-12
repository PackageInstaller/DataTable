using System;
using System.Collections;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using Unity.Mathematics;

public class MonsterToughnessInfo : LogicComponent
{
	public delegate void ToughnessValueChangedHandle(long toughness, long toughnessMax);

	public delegate void ToughnessStateChangedHandle(bool breakToughness);

	private AttributeList attributeList;

	private SpecialAttributeList specialAttributeList;

	private bool _isToughnessBroken;

	private bool _isShowToughness;

	private AdventureActor _actor;

	private static readonly List<int> NullDamageTag = new List<int>();

	private AdventureActor _damageSource;

	private readonly List<int> _hitDamageTag = new List<int>(5);

	private readonly List<MonsterAdventureActor> _querySummonedList = new List<MonsterAdventureActor>(10);

	private CoroutineNode _toughnessBrokenStateNode;

	private CoroutineNode toughnessProtectStateNode;

	private CoroutineNode _toIdleByToughnessBrokenNode;

	private CoroutineNode _recoverToughnessNode;

	public long toughnessMax => attributeList?.GetAttributeValue(HotfixEnum.effectAttributeType.TOUGHNESS_MAX).AsLong() ?? 0;

	public long toughness
	{
		get
		{
			return specialAttributeList?.GetAttributeValue(HotfixEnum.specialAttributeType.TOUGHNESS_V).AsLong() ?? 0;
		}
		set
		{
			if ((!IsInit || toughness > 0 || toughnessCanRecover) && toughness != value && specialAttributeList != null)
			{
				FDP value2 = FDP.FromLong(math.max(0L, value));
				specialAttributeList.SetAttributeValue(attributeList, HotfixEnum.specialAttributeType.TOUGHNESS_V, HotfixEnum.parameterType.BASE_VALUE, value2);
			}
		}
	}

	public FP toughnessPercentage
	{
		get
		{
			if (toughness == 0L || toughnessMax == 0L)
			{
				return 0f;
			}
			return (FP)toughness / (FP)toughnessMax;
		}
	}

	public bool lockToughness { get; set; }

	public bool inToughnessProtectState { get; private set; }

	public FP toughnessBrokenTime { get; set; }

	public bool toughnessCanRecover { get; set; }

	public bool isToughnessBroken
	{
		get
		{
			return _isToughnessBroken;
		}
		private set
		{
			if (value != _isToughnessBroken)
			{
				_isToughnessBroken = value;
				OnToughnessSataeChange();
			}
		}
	}

	public bool haveToughness
	{
		get
		{
			if (toughnessMax > 0)
			{
				return toughness > 0;
			}
			return false;
		}
	}

	public bool isInRecover { get; private set; }

	public bool isShowToughness
	{
		get
		{
			return _isShowToughness;
		}
		set
		{
			if (_isShowToughness != value)
			{
				_isShowToughness = value;
				MonoSingleton<LuaManager>.Instance.FireEntityEvent("ToughnessShowStateChanged", _actor.Id, _isShowToughness);
			}
		}
	}

	public bool isUseDefaultBrokenState { get; set; }

	public bool IsInit { get; private set; }

	public event ToughnessValueChangedHandle ToughnessValueChangedEvent;

	public event ToughnessStateChangedHandle ToughnessStateChangedEvent;

	protected override void OnInit()
	{
		base.OnInit();
		_actor = Entity as AdventureActor;
		if (_actor != null)
		{
			attributeList = _actor.attributeList;
			specialAttributeList = _actor.specialAttributeList;
			attributeList.ValueChangedEvent += OnAttributeValueChanged;
			specialAttributeList.ValueChangedEvent += OnSpecialValueChanged;
		}
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		IsInit = false;
		_damageSource = null;
		_hitDamageTag.Clear();
	}

	protected override void OnShutdown()
	{
		base.OnShutdown();
		if (attributeList != null)
		{
			attributeList.ValueChangedEvent -= OnAttributeValueChanged;
		}
		if (specialAttributeList != null)
		{
			specialAttributeList.ValueChangedEvent -= OnSpecialValueChanged;
		}
		attributeList = null;
		specialAttributeList = null;
	}

	private void OnAttributeValueChanged(HotfixEnum.effectAttributeType attributeType, HotfixEnum.parameterType parameterType, FDP oldValue, FDP afterValue)
	{
		if (attributeType == HotfixEnum.effectAttributeType.TOUGHNESS_MAX && IsInit && !(oldValue == afterValue))
		{
			ToughnessValueChangedEvent?.Invoke(toughness, toughnessMax);
			CheckToughnessBroken();
			if (toughness > toughnessMax)
			{
				toughness = toughnessMax;
			}
		}
	}

	private void OnSpecialValueChanged(HotfixEnum.specialAttributeType attributeType, HotfixEnum.parameterType parameterType, FDP oldValue, FDP afterValue)
	{
		if (attributeType == HotfixEnum.specialAttributeType.TOUGHNESS_V && IsInit && !(oldValue == afterValue))
		{
			ToughnessValueChangedEvent?.Invoke(toughness, toughnessMax);
			CheckToughnessBroken();
			if (toughness > 0 && !_actor.beSuperArmor)
			{
				_actor.EnableSuperArmor();
			}
		}
	}

	public void InitComponent()
	{
		lockToughness = false;
		inToughnessProtectState = false;
		isToughnessBroken = false;
		isInRecover = false;
		isShowToughness = true;
		isUseDefaultBrokenState = true;
		if (toughnessMax > 0)
		{
			_actor.EnableSuperArmor();
		}
		IsInit = true;
	}

	public bool DamageToToughness(AdventureActor from, long damage, IList<int> hitDamageTag = null)
	{
		if (toughnessMax <= 0)
		{
			return false;
		}
		if (lockToughness || inToughnessProtectState)
		{
			ToughnessValueChangedEvent?.Invoke(toughness, toughnessMax);
			return false;
		}
		if (isToughnessBroken)
		{
			return false;
		}
		if (isInRecover)
		{
			return false;
		}
		_damageSource = from;
		if (hitDamageTag != null)
		{
			_hitDamageTag.AddRange(hitDamageTag);
		}
		toughness -= damage;
		_damageSource = null;
		_hitDamageTag.Clear();
		return isToughnessBroken;
	}

	private void CheckToughnessBroken()
	{
		if (IsInit && toughness <= 0 && !isToughnessBroken)
		{
			isToughnessBroken = true;
		}
	}

	private void OnToughnessSataeChange()
	{
		if (isToughnessBroken)
		{
			if (_toIdleByToughnessBrokenNode != null)
			{
				_actor.StopLogicCoroutine(_toIdleByToughnessBrokenNode);
				_toIdleByToughnessBrokenNode = null;
			}
			_actor.InterruptSuperArmor();
			_actor.InterruptImmuneControl();
			if (isUseDefaultBrokenState && !_actor.useSpecialLostControlClip)
			{
				_actor.PlayHurtAnim();
			}
			if (!string.IsNullOrEmpty(AdventureModuleController.Config.ToughnessBrokenFxPath))
			{
				AdventureFXManager.PlayFX(AdventureModuleController.Config.ToughnessBrokenFxPath, 1f, _actor.transform.position, _actor.transform.rotation);
			}
			_actor.buffComponent.AddBuff(AdventureModuleController.Config.ToughnessBrokenState_BuffId, _actor);
			ClearScene();
			DispatchEvent();
			if (_toughnessBrokenStateNode != null)
			{
				_actor.StopLogicCoroutine(_toughnessBrokenStateNode);
			}
			_toughnessBrokenStateNode = _actor.StartLogicCoroutine(ToughnessBrokenState(), runImmediately: true);
		}
		else
		{
			if (_toughnessBrokenStateNode != null)
			{
				_actor.StopLogicCoroutine(_toughnessBrokenStateNode);
			}
			_toughnessBrokenStateNode = null;
			_toIdleByToughnessBrokenNode = _actor.StartLogicCoroutine(ToIdleByToughnessBroken(), runImmediately: true);
			_actor.buffComponent.RemoveBuffByBuffId(AdventureModuleController.Config.ToughnessBrokenState_BuffId);
			DispatchEvent();
		}
		void DispatchEvent()
		{
			MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent = MonsterToughnessStateChangeEvent.Generate();
			monsterToughnessStateChangeEvent.sender = _actor;
			monsterToughnessStateChangeEvent.actor = _actor;
			monsterToughnessStateChangeEvent.source = _damageSource ?? _actor;
			monsterToughnessStateChangeEvent.hitDamageTag = _hitDamageTag ?? NullDamageTag;
			monsterToughnessStateChangeEvent.isToughnessBroken = isToughnessBroken;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(monsterToughnessStateChangeEvent);
			ToughnessStateChangedEvent?.Invoke(isToughnessBroken);
		}
	}

	private IEnumerator ToughnessBrokenState()
	{
		FP durationTime = toughnessBrokenTime;
		while (durationTime > 0)
		{
			durationTime -= LockStepManager.deltaTime;
			yield return null;
		}
		CheckRecoverToughness();
		CheckEnterToughnessProtectState();
		isToughnessBroken = false;
		_toughnessBrokenStateNode = null;
	}

	private IEnumerator ToIdleByToughnessBroken()
	{
		AdventureActor actor = _actor;
		if (actor is MonsterAdventureActor monster)
		{
			monster.ToughnessBrokenToIdle = true;
			FP duration = AdventureModuleController.Config.ToughnessBroken_IdleDuration;
			while (duration > 0)
			{
				duration -= LockStepManager.deltaTime;
				yield return null;
			}
			monster.ToughnessBrokenToIdle = false;
		}
	}

	private void CheckRecoverToughness()
	{
		if (toughnessCanRecover && !isInRecover)
		{
			if (_recoverToughnessNode != null)
			{
				_actor.StopLogicCoroutine(_recoverToughnessNode);
			}
			_recoverToughnessNode = _actor.StartLogicCoroutine(RecoverToughness(), runImmediately: true);
		}
	}

	private IEnumerator RecoverToughness()
	{
		toughness = toughnessMax;
		isInRecover = true;
		FP recoverTime = AdventureModuleController.Config.ToughnessBroken_RecoverTime;
		while (recoverTime > 0)
		{
			recoverTime -= LockStepManager.deltaTime;
			yield return null;
		}
		isInRecover = false;
		_recoverToughnessNode = null;
	}

	private void CheckEnterToughnessProtectState()
	{
		if (toughnessCanRecover)
		{
			if (toughnessProtectStateNode != null)
			{
				_actor.StopLogicCoroutine(toughnessProtectStateNode);
			}
			toughnessProtectStateNode = _actor.StartLogicCoroutine(ToughnessProtectState(), runImmediately: true);
		}
	}

	private IEnumerator ToughnessProtectState()
	{
		FP lockTime = AdventureModuleController.Config.ToughnessProtectTime;
		if (lockTime > 0)
		{
			inToughnessProtectState = true;
			while (lockTime > 0)
			{
				lockTime -= LockStepManager.deltaTime;
				yield return null;
			}
			inToughnessProtectState = false;
		}
		toughnessProtectStateNode = null;
	}

	private void ClearScene()
	{
		_querySummonedList.Clear();
		foreach (LogicEntity monsterActor in ModuleController<AdventureModuleController>.Instance.levelInstance.monsterActors)
		{
			if (monsterActor != _actor && monsterActor.IsSummoned(out var summoner, out var _) && summoner == _actor)
			{
				_querySummonedList.Add(monsterActor as MonsterAdventureActor);
			}
		}
		List<MonsterAdventureActor> querySummonedList = _querySummonedList;
		if (querySummonedList != null && querySummonedList.Count > 0)
		{
			foreach (MonsterAdventureActor querySummoned in _querySummonedList)
			{
				if (!querySummoned.monsterInfo.CheckTag(AdventureModuleController.Config.ToughnessBroken_IgnoreClearTag))
				{
					if (querySummoned.state != ActorState.Spawn)
					{
						ClearSceneByActor(querySummoned);
						querySummoned.DestroySelf();
					}
					else
					{
						_actor.StartLogicCoroutine(WaitForDestroySummoned(querySummoned));
					}
				}
			}
		}
		ClearSceneByActor(_actor);
	}

	private IEnumerator WaitForDestroySummoned(MonsterAdventureActor summoned)
	{
		if (!(summoned == null))
		{
			while (summoned.state == ActorState.Spawn)
			{
				yield return null;
			}
			ClearSceneByActor(summoned);
			summoned.DestroySelf();
		}
	}

	private void ClearSceneByActor(AdventureActor actor)
	{
		if (actor == null)
		{
			return;
		}
		List<AdventureWeapon> list = actor.shootBehaviour.QueryOwnedAliveWeapons();
		if (list != null && list.Count > 0)
		{
			foreach (AdventureWeapon item in list)
			{
				if (!item.CheckWeaponTag(AdventureModuleController.Config.ToughnessBroken_IgnoreClearTag) && !item.CheckBulletTag(AdventureModuleController.Config.ToughnessBroken_IgnoreClearTag))
				{
					item.Finish(cancel: true);
				}
			}
		}
		List<AreaEffectEntity> areaEffectsByOwner = SceneSingleton<AreaEffectManager>.Instance.GetAreaEffectsByOwner(actor);
		if (areaEffectsByOwner == null || areaEffectsByOwner.Count <= 0)
		{
			return;
		}
		foreach (AreaEffectEntity item2 in areaEffectsByOwner)
		{
			if (!item2.CheckTag(AdventureModuleController.Config.ToughnessBroken_IgnoreClearTag))
			{
				item2.Finish();
			}
		}
	}

	private void SetOriginLongValue(HotfixEnum.effectAttributeType type, long val, FDP ratio)
	{
		attributeList?.SetOriginLongValue(type, val, ratio);
	}

	private void SetOriginLongValueAdjust(HotfixEnum.effectAttributeType type, long val, FDP ratio, int adjustRatio, long adjustFix)
	{
		attributeList?.SetOriginLongValueAdjust(type, val, ratio, adjustRatio, adjustFix);
	}

	public void SetOriginAttributeData(MonsterValueTemplete attributeConfig, MonsterValueTempleteAdjust templeteAdjustInfo, FDP ratio)
	{
		if (templeteAdjustInfo != null)
		{
			SetOriginLongValueAdjust(HotfixEnum.effectAttributeType.TOUGHNESS_MAX, attributeConfig.Toughness, ratio, templeteAdjustInfo.ToughnessRatio, templeteAdjustInfo.ToughnessFix);
		}
		else
		{
			SetOriginLongValue(HotfixEnum.effectAttributeType.TOUGHNESS_MAX, attributeConfig.Toughness, ratio);
		}
		toughness = toughnessMax;
	}

	[Obsolete]
	public void SetOriginAttributeData(Nova.Hotfix.Attribute attributeConfig, FDP ratio)
	{
		SetOriginLongValue(HotfixEnum.effectAttributeType.TOUGHNESS_MAX, attributeConfig.Toughness, ratio);
		toughness = toughnessMax;
	}
}
