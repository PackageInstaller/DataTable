using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[Serializable]
[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_攻击")]
[RequireComponent(typeof(AreaEffectEntity))]
public class AreaEffect_AttackComponent : AreaEffect_Component, IHitBoxContext
{
	public int hitDamageId;

	public List<int> hitDamageIdList;

	public FP hitDelay = 0;

	public bool hitImmediately = true;

	public FP hitInterval = 1;

	public HitBox.FeatureFlag hitFlags;

	public HitBox.HitBoxFeatureData hitFeatureData;

	public GameObject hitEffectPrefab;

	public HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small;

	public GameObject hittedEffectPrefab;

	public bool isHittedEffectScale = true;

	public bool effectIgnoreTimeScale = true;

	public FP damageImmuneDuration;

	public bool delayClearHittedRecord;

	public FP clearHittedRecordDelayTime = 0;

	public bool haveFeedbackEffect;

	public bool blockBullet;

	public TargetFilterCriteriaInfo blockBulletCriteriaInfo;

	public GameObject blockFinishFx;

	public AdventurePlayerFeedbackEffectConfigureData playerfeedbackEffectConfigureData;

	public bool triggerEnter;

	public TargetFilterCriteriaInfo triggerEnterCriteriaInfo;

	public bool finish_TriggerEnter;

	[Space]
	public bool triggerStay;

	public TargetFilterCriteriaInfo triggerStayCriteriaInfo;

	public FP time_TriggerStay = 1;

	public bool finish_TriggerStay;

	[Space]
	public bool triggerExit;

	public TargetFilterCriteriaInfo triggerExitCriteriaInfo;

	public bool finish_TriggerExit;

	private FP _hitTime;

	protected int _hitIndex;

	private FP _clearTime;

	private Dictionary<long, FP> _triggerStayDic;

	private readonly Dictionary<long, FP> _hittedEntities = new Dictionary<long, FP>(10);

	protected override void OnSetup()
	{
		base.OnSetup();
		_hitIndex = 1;
		_clearTime = clearHittedRecordDelayTime;
	}

	protected override void OnStartLogic()
	{
		base.OnStartLogic();
		if (hitDelay <= 0)
		{
			if (hitImmediately)
			{
				Hit();
			}
			_hitTime = hitInterval;
		}
		else
		{
			_hitTime = hitDelay;
		}
	}

	protected override void OnLogicUpdate(FP logicDeltaTime)
	{
		base.OnLogicUpdate(logicDeltaTime);
		if (_hitTime > 0)
		{
			_hitTime -= logicDeltaTime;
			if (_hitTime <= 0)
			{
				Hit();
				if (hitInterval > 0)
				{
					_hitTime = hitInterval;
				}
			}
		}
		if (delayClearHittedRecord && clearHittedRecordDelayTime > 0)
		{
			_clearTime -= logicDeltaTime;
			if (_clearTime <= 0)
			{
				_context.ClearHittedRecord();
				_clearTime = clearHittedRecordDelayTime;
			}
		}
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		_hittedEntities?.Clear();
		_triggerStayDic?.Clear();
	}

	public virtual void Hit()
	{
		if (hitEffectPrefab != null)
		{
			AdventureFXPlayer.PlayFX(hitEffectPrefab, (float)_context.logicTimeScale, _context.cTrans.position, _context.cTrans.transform.rotation, _context.transform.localScale.x);
		}
		int num = GetHitDamageId();
		_context.Hit(num, hitFlags, hitFeatureData, hurtAnimType, hittedEffectPrefab, isHittedEffectScale, effectIgnoreTimeScale, damageImmuneDuration, haveFeedbackEffect, playerfeedbackEffectConfigureData, this);
		if (blockBullet)
		{
			_context.BlockBullet(blockBulletCriteriaInfo, blockFinishFx);
		}
		_hitIndex++;
	}

	private void Damage(AdventureActor target)
	{
		if (hitEffectPrefab != null)
		{
			AdventureFXPlayer.PlayFX(hitEffectPrefab, (float)_context.logicTimeScale, _context.cTrans.position, _context.cTrans.rotation);
		}
		int num = GetHitDamageId();
		_context.Damage(target, num, hitFlags, hitFeatureData, hurtAnimType, hittedEffectPrefab, isHittedEffectScale, effectIgnoreTimeScale, damageImmuneDuration, haveFeedbackEffect, playerfeedbackEffectConfigureData, this);
		_hitIndex++;
	}

	protected int GetHitDamageId()
	{
		if (hitDamageIdList == null || hitDamageIdList.Count <= 0 || _hitIndex >= hitDamageIdList.Count)
		{
			return hitDamageId;
		}
		return hitDamageIdList.get_Item(_hitIndex);
	}

	protected override void OnDeterministicCollisionEnter(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		if (triggerEnter && entity is AdventureActor adventureActor && _context.CheckTarget(adventureActor, triggerEnterCriteriaInfo))
		{
			_triggerStayDic?.Remove(adventureActor.Id);
			Damage(adventureActor);
			if (finish_TriggerEnter)
			{
				FinishAreaEffect = true;
			}
		}
	}

	protected override void OnDeterministicCollisionStay(LogicEntity entity)
	{
		base.OnDeterministicCollisionStay(entity);
		if (!triggerStay || !(entity is AdventureActor adventureActor) || !_context.CheckTarget(adventureActor, triggerStayCriteriaInfo))
		{
			return;
		}
		if (time_TriggerStay <= 0)
		{
			TriggerStay(adventureActor);
			return;
		}
		if (_triggerStayDic == null)
		{
			_triggerStayDic = new Dictionary<long, FP>(10);
		}
		if (_triggerStayDic.ContainsKey(adventureActor.Id))
		{
			_triggerStayDic.get_Item(adventureActor.Id) += _context.LogicDeltaTime;
		}
		else
		{
			_triggerStayDic.Add(adventureActor.Id, _context.LogicDeltaTime);
		}
		if (_triggerStayDic.get_Item(adventureActor.Id) >= time_TriggerStay)
		{
			TriggerStay(adventureActor);
			_triggerStayDic.set_Item(adventureActor.Id, (FP)0);
		}
	}

	private void TriggerStay(AdventureActor target)
	{
		Damage(target);
		if (finish_TriggerExit)
		{
			FinishAreaEffect = true;
		}
	}

	protected override void OnDeterministicCollisionExit(LogicEntity entity)
	{
		base.OnDeterministicCollisionExit(entity);
		if (triggerExit && entity is AdventureActor target && _context.CheckTarget(target, triggerExitCriteriaInfo))
		{
			Damage(target);
			if (finish_TriggerExit)
			{
				FinishAreaEffect = true;
			}
		}
	}

	public void ClearHittedRecord()
	{
		_hittedEntities.Clear();
	}

	public FP QueryHitBoxContextTime()
	{
		if (_context == null)
		{
			return default;
		}
		if (_context.shareSameDamageImmuneDuration)
		{
			return LockStepManager.time;
		}
		return _context.LogicTime;
	}

	public TSVector2 QueryHitBoxContextPosition()
	{
		if (_context == null)
		{
			return default;
		}
		return _context.QueryHitBoxContextPosition();
	}

	public TSVector2 QueryHitBoxContextDirection()
	{
		if (_context == null)
		{
			return default;
		}
		return _context.QueryHitBoxContextDirection();
	}

	public bool QueryActorHitedTimeout(long entityId, FP timeout)
	{
		if (_context == null)
		{
			return false;
		}
		if (!((!_context.shareSameDamageImmuneDuration) ? _hittedEntities.TryGetValue(entityId, out var value) : SceneSingleton<AreaEffectManager>.Instance.QueryActorHitedTimeoutByGroup(_context, entityId, out value)))
		{
			return true;
		}
		return QueryHitBoxContextTime() > value + timeout;
	}

	public void SetActorHitedTime(long entityId, FP time)
	{
		if (!(_context == null))
		{
			if (_context.shareSameDamageImmuneDuration)
			{
				SceneSingleton<AreaEffectManager>.Instance.SetActorHitedTimeToGroup(_context, entityId, time);
			}
			else
			{
				_hittedEntities.set_Item(entityId, time);
			}
		}
	}

	public bool CheckHitable(HitBox hitBox, LogicEntity entity)
	{
		if (_context == null)
		{
			return false;
		}
		bool flag = _context.CheckHitable(hitBox, entity);
		if (entity is AdventureActor adventureActor && checkTargetWithTag && _checkTagHashCode != 0)
		{
			if (flag)
			{
				return adventureActor.CheckTag(_checkTagHashCode);
			}
			return false;
		}
		return flag;
	}

	public bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity entity, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (_context == null)
		{
			return false;
		}
		return _context.OnHitActor(hitBox, uniqueAttackId, onceAttackTargetCount, entity, ref raycastHit, out damaged, hurtEffectPrefab, isHittedEffectScale, effectIgnoreTimeScale);
	}

	public bool OnHitShield(HitBox hitBox, AdventureWeapon shield, ref DeterministicRaycastHit raycastHit)
	{
		if (_context == null)
		{
			return false;
		}
		return _context.OnHitShield(hitBox, shield, ref raycastHit);
	}

	public bool OnHitObstacle(HitBox hitBox, AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		if (_context == null)
		{
			return false;
		}
		return _context.OnHitObstacle(hitBox, obstacle, ref raycastHit);
	}

	public bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity entity, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (_context == null)
		{
			return false;
		}
		return _context.OnHitDestructibleObstacle(hitBox, uniqueAttackId, onceAttackTargetCount, entity, ref raycastHit, out damaged, hurtEffectPrefab, isHittedEffectScale, effectIgnoreTimeScale);
	}
}
