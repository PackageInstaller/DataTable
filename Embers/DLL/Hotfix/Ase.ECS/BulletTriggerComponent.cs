using System.Collections.Generic;
using Cinemachine.Utility;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class BulletTriggerComponent : BaseComponent
{
	private const string volume_body = "body";

	private const string volume_fast = "fast";

	private const string volume_morph = "morph";

	protected BulletData _bulletData;

	private float _bulletLastImpact = -1f;

	private float _timer;

	private float _delayTimer;

	private bool _isEnd;

	private float _stopTimer;

	private int _triggerCount = 999;

	private BulletTriggerData _triggerData;

	private float _triggerInterval;

	private BulletTriggerTypeEnum _triggerTypeEnum;

	private bool oriTriggerable;

	private float stopTime = float.MaxValue;

	private bool Triggerable;

	private List<BaseEntity> triggerEntities = new List<BaseEntity>();

	private List<int> onceTriggerEntities = new List<int>();

	private bool isOnceTrigger;

	private HitVolume volume;

	private BulletMorphGroup bulletMorphGroup;

	private HitVolume morphVolume;

	public int TriggerCount => _triggerCount;

	public override void OnAwake(object data = null)
	{
		_bulletData = GetData<BulletData>("bulletData");
		_triggerCount = ((_bulletData.cfg.TriggerCount < 0) ? int.MaxValue : _bulletData.cfg.TriggerCount);
		_triggerInterval = ((_bulletData.cfg.Interval < 0f) ? 0f : _bulletData.cfg.Interval);
		_triggerTypeEnum = _bulletData.cfg.BulletTriggerTypeEnum;
		oriTriggerable = _bulletData.cfg.OriginTriggerAble;
		Triggerable = oriTriggerable;
		isOnceTrigger = _bulletData.cfg.BulletTriggerTypeEnum == BulletTriggerTypeEnum.HitTrigger && _bulletData.cfg.TriggerCd == 0f;
		stopTime = ((_bulletData.cfg.StopTriggerTime <= 0f) ? stopTime : _bulletData.cfg.StopTriggerTime);
		_triggerData = ReferencePool.Acquire<BulletTriggerData>();
		_triggerData.Init(_triggerInterval);
		if (stopTime > 0f)
		{
			_ = stopTime;
			_ = _bulletData.cfg.TriggerDelay;
		}
		InitBulletVolume();
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
	}

	private void InitBulletVolume()
	{
		volume = HitVolume.Create(mBaseEntity, "body", VolumeData.Create(Vector3.zero, Vector3.zero, _bulletData.cfg.PrimitiveEnum, GetConfigPrimitiviParam()));
		bulletMorphGroup = ReferencePool.Acquire<BulletMorphGroup>();
		bulletMorphGroup.Init(_bulletData.cfg);
	}

	public HitVolume CreateBulletVolume(string key, List<float> volumes = null)
	{
		if (volumes == null)
		{
			volumes = GetConfigPrimitiviParam();
		}
		return HitVolume.Create(mBaseEntity, "body", VolumeData.Create(Vector3.zero, Vector3.zero, _bulletData.cfg.PrimitiveEnum, volumes));
	}

	public HitVolume ResetBulletVolume(List<float> volumes = null)
	{
		volume = CreateBulletVolume("body", volumes);
		return volume;
	}

	public virtual List<float> GetConfigPrimitiviParam()
	{
		if (mBaseEntity is AlertBulletEntity)
		{
			List<float> list = new List<float>(_bulletData.cfg.PrimitiveParam);
			int num = list.Count;
			PrimitiveEnum primitiveEnum = _bulletData.cfg.PrimitiveEnum;
			if ((uint)(primitiveEnum - 1) > 2u && (uint)(primitiveEnum - 4) <= 1u)
			{
				num--;
			}
			for (int i = 0; i < num; i++)
			{
				list[i] *= _bulletData.alert_hitColliderScale;
			}
			return list;
		}
		return _bulletData.cfg.PrimitiveParam;
	}

	private void OnEditorBulletVolumeUpdate(float deltaTime)
	{
	}

	private void OnEditorAlretBulletVolumeUpdate(float deltaTime)
	{
	}

	private void OnBulletVolumeUpdate(float deltaTime)
	{
		if (volume != null)
		{
			volume.OnUpdate(deltaTime);
		}
		BulletMorphGroup obj = bulletMorphGroup;
		if (obj == null || !obj.IsMorphing)
		{
			return;
		}
		bulletMorphGroup.Update(deltaTime);
		BulletMorphedData morphedData = bulletMorphGroup.GetMorphedData();
		if (morphedData == null || morphedData.values == null)
		{
			return;
		}
		if (morphVolume != null)
		{
			ReferencePool.Release(morphVolume);
		}
		morphVolume = CreateBulletVolume("morph", morphedData.values);
		Vector3 position = mBaseEntity.transform.position + mBaseEntity.transform.rotation * morphedData.position;
		Vector3 euler = mBaseEntity.transform.eulerAngles + Vector3.up * morphedData.angle;
		morphVolume.OnUpdateTransform(position, Quaternion.Euler(euler));
		if (bulletMorphGroup.IsMorphEffect)
		{
			BulletViewComponent component = mBaseEntity.GetComponent<BulletViewComponent>();
			if (component != null)
			{
				component.SetPosition(position);
				component.SetRotation(Quaternion.Euler(euler));
				component.SetLocalScale(morphedData.localScale);
			}
		}
	}

	public void DoTriggerUpdate(float deltaTime)
	{
		if (mBaseEntity.IsSurvival)
		{
			OnBulletVolumeUpdate(deltaTime);
			OnEditorBulletVolumeUpdate(deltaTime);
			if (CheckIsAbleTrigger() && CheckTriggerTimer(deltaTime))
			{
				DoCollisionFixedUpdate(deltaTime);
			}
		}
	}

	private void DoCollisionFixedUpdate(float deltaTime)
	{
		GetTriggerEntities();
		_triggerData.DoUpdateBefore(deltaTime);
		_triggerData.OnEnterBefore(ref triggerEntities);
		_triggerData.OnEnter();
		DoTriggerFixedUpdate(deltaTime);
		_triggerData.OnExit();
		for (int i = 0; i < _triggerData.ExitingDatas.Count; i++)
		{
			OnExit(_triggerData.ExitingDatas[i]);
		}
	}

	private void DoTriggerFixedUpdate(float deltaTime)
	{
		if (_triggerTypeEnum == BulletTriggerTypeEnum.IntervalTrigger)
		{
			DoIntervalTriggerUpdate();
		}
		else
		{
			DoFixedTriggerUpdate();
		}
	}

	private void DoFixedTriggerUpdate()
	{
		List<FrameCollisionData> handleList = _triggerData.ImpactingDatas;
		if (_triggerTypeEnum == BulletTriggerTypeEnum.HitTrigger)
		{
			handleList = _triggerData.EnteringDatas;
			SiftHitTriggerFrameCollision(ref handleList);
		}
		for (int i = 0; i < handleList.Count; i++)
		{
			FrameCollisionData value = handleList[i];
			if (value._entity.IsSurvival && value._lastImpact + value._interval < _triggerData.Timer)
			{
				if (!CheckIsAbleTrigger())
				{
					break;
				}
				if (mBaseEntity.GetComponent<BulletHitJudgmentComponent>().CheckEntityHitJudgment(value._entity))
				{
					value._lastImpact = _triggerData.Timer;
					handleList[i] = value;
				}
			}
		}
	}

	private void SiftHitTriggerFrameCollision(ref List<FrameCollisionData> handleList)
	{
		for (int num = handleList.Count - 1; num >= 0; num--)
		{
			if (handleList[num]._entity.GetComponent<HitComponent>() != null && handleList[num]._entity.GetComponent<HitComponent>().CheckIfInHitCd(mBaseEntity.Id))
			{
				handleList.RemoveAt(num);
			}
		}
	}

	private void DoIntervalTriggerUpdate()
	{
		bool flag = false;
		float bulletLastImpact = _bulletLastImpact;
		float timer = _triggerData.Timer;
		for (int i = 0; i < _triggerData.ImpactingDatas.Count; i++)
		{
			FrameCollisionData frameCollisionData = _triggerData.ImpactingDatas[i];
			if (frameCollisionData._entity.IsSurvival && _bulletLastImpact + _triggerInterval < timer)
			{
				if (!CheckIsAbleTrigger())
				{
					break;
				}
				if (mBaseEntity.GetComponent<BulletHitJudgmentComponent>().CheckEntityHitJudgment(frameCollisionData._entity) && !flag && frameCollisionData._entity.LogicType != EntityLogicType.Display)
				{
					bulletLastImpact = timer;
					flag = true;
				}
			}
		}
		_bulletLastImpact = bulletLastImpact;
	}

	private void OnExit(FrameCollisionData collisionData)
	{
		if (_bulletData.cfg.IsRemoveTheBuff)
		{
			BuffSystem system = mBaseEntity.GetSystem<BuffSystem>();
			if (system == null)
			{
				return;
			}
			for (int i = 0; i < _bulletData.cfg.AddBuff.Count; i++)
			{
				BaseEntity entity = collisionData._entity;
				if (entity != null)
				{
					system.FinishEntityBuff(entity.Id, _bulletData.cfg.AddBuff[i]);
				}
			}
		}
		mBaseEntity.GetComponent<BulletRayComponent>()?.ExitHit(collisionData._entity);
	}

	private void OnAlertExit(FrameCollisionData collisionData)
	{
		if (collisionData._entity != null)
		{
			mBaseEntity.GetSystem<AlertHitInfoSystem>()?.ExitAlertHitInfo(mBaseEntity, collisionData._entity);
		}
	}

	public void RemoveExtraAddBuff()
	{
		BulletData bulletData = _bulletData;
		if (bulletData == null || !bulletData.cfg.IsRemoveTheBuff)
		{
			return;
		}
		BuffSystem system = mBaseEntity.GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		for (int i = 0; i < _triggerData.ImpactingDatas.Count; i++)
		{
			BaseEntity entity = _triggerData.ImpactingDatas[i]._entity;
			if (entity != null)
			{
				for (int j = 0; j < _bulletData.cfg.AddBuff.Count; j++)
				{
					system.FinishEntityBuff(entity.Id, _bulletData.cfg.AddBuff[j]);
				}
			}
		}
	}

	public void ToggleTriggerAble(bool triggerable)
	{
		Triggerable = triggerable;
	}

	public void ResetTriggerAble()
	{
		ToggleTriggerAble(oriTriggerable);
	}

	private bool CheckIsAbleTrigger()
	{
		if (_triggerCount <= 0)
		{
			if (!_isEnd)
			{
				DoHandleZeroTriggerCount();
			}
			return false;
		}
		if (!Triggerable)
		{
			return false;
		}
		return true;
	}

	public void ReduceTriggerCount(BaseEntity triggerEntity)
	{
		_triggerCount--;
		if (_triggerCount > 0)
		{
			return;
		}
		BulletMoveComponent component = mBaseEntity.GetComponent<BulletMoveComponent>();
		if (component == null || component.MovementTrajectoryData == null)
		{
			return;
		}
		Vector3 lastFramePosition = component.MovementTrajectoryData.LastFramePosition;
		Vector3 position = mBaseEntity.transform.position;
		Vector3 position2 = triggerEntity.transform.position;
		Vector3 vector = position - lastFramePosition;
		Vector3 lhs = position2 - lastFramePosition;
		if (!(vector.sqrMagnitude < Mathf.Epsilon))
		{
			float value = Vector3.Dot(lhs, vector) / vector.sqrMagnitude;
			value = Mathf.Clamp01(value);
			Vector3 vector2 = lastFramePosition + value * vector;
			if (!vector2.IsNaN())
			{
				component.SetPosition(vector2);
				mBaseEntity.GetComponent<BulletViewComponent>()?.SetPosition(vector2);
				HitVolumeLog.BulletHitPointLog(vector2);
			}
		}
	}

	private bool CheckTriggerTimer(float deltaTime)
	{
		_timer += deltaTime;
		if (stopTime <= 0f && _bulletData.cfg.TriggerDelay <= 0f)
		{
			return true;
		}
		if (_bulletData.cfg.TriggerDelay <= 0f)
		{
			if (_timer < stopTime)
			{
				return true;
			}
			return false;
		}
		if (stopTime <= 0f)
		{
			if (_timer < _bulletData.cfg.TriggerDelay)
			{
				return false;
			}
			return true;
		}
		if (stopTime > 0f && stopTime <= _bulletData.cfg.TriggerDelay)
		{
			return true;
		}
		if (_timer < _bulletData.cfg.TriggerDelay)
		{
			return false;
		}
		if (_timer < stopTime)
		{
			return true;
		}
		return false;
	}

	private bool CheckIsAbleTriggerTimer(float deltaTime)
	{
		if (_delayTimer < _bulletData.cfg.TriggerDelay)
		{
			_stopTimer += deltaTime;
			_delayTimer += deltaTime;
			return false;
		}
		if (_stopTimer > stopTime)
		{
			return false;
		}
		_stopTimer += deltaTime;
		return true;
	}

	public void ExtraTrigger()
	{
		GetTriggerEntities();
		if (triggerEntities.Count > 0)
		{
			for (int i = 0; i < triggerEntities.Count; i++)
			{
				mBaseEntity.GetComponent<BulletHitJudgmentComponent>().CheckEntityHitJudgment(triggerEntities[i]);
			}
		}
	}

	private void GetTriggerEntities()
	{
		triggerEntities.Clear();
		List<BaseEntity> hostileList = CollectionPool<List<BaseEntity>, BaseEntity>.Get();
		mBaseEntity.GetSystem<EntitySystem>().FindAllSurvivalEntities(mBaseEntity.Parent, in hostileList, containSelf: true);
		HitVolume bulletVolume = GetBulletVolume();
		Vector3 b = Vector3.zero;
		bool flag = false;
		if (!_bulletData.cfg.IsMelee)
		{
			BulletMoveComponent component = mBaseEntity.GetComponent<BulletMoveComponent>();
			if (component != null && component.MovementTrajectoryData != null)
			{
				b = component.MovementTrajectoryData.LastFramePosition;
				b.y = 0f;
				flag = true;
			}
		}
		VolumeSystem system = mBaseEntity.GetSystem<VolumeSystem>();
		foreach (BaseEntity item in hostileList)
		{
			if (item.LogicType == EntityLogicType.Display || (isOnceTrigger && onceTriggerEntities.Contains(item.Id)) || item.GetComponent<HitColliderComponent>() == null || !system.IsIntersect(bulletVolume, item.Id))
			{
				continue;
			}
			onceTriggerEntities.Add(item.Id);
			if (!flag || triggerEntities.Count == 0)
			{
				triggerEntities.Add(item);
				continue;
			}
			float num = Vector3.Distance(new Vector3(item.transform.position.x, 0f, item.transform.position.z), b);
			for (int num2 = triggerEntities.Count - 1; num2 >= 0; num2--)
			{
				if (Vector3.Distance(new Vector3(triggerEntities[num2].transform.position.x, 0f, triggerEntities[num2].transform.position.z), b) <= num)
				{
					triggerEntities.Insert(num2 + 1, item);
					break;
				}
				if (num2 == 0)
				{
					triggerEntities.Insert(0, item);
				}
			}
		}
		CollectionPool<List<BaseEntity>, BaseEntity>.Release(hostileList);
	}

	public HitVolume GetBulletVolume()
	{
		if (morphVolume != null)
		{
			return morphVolume;
		}
		return volume;
	}

	private void DoHandleZeroTriggerCount()
	{
		mBaseEntity.GetComponent<BulletLifeComponent>().DoHandleZeroTriggerCount();
		mBaseEntity.GetComponent<BulletDisplayComponent>()?.OnDisplay("ZeroTriggerCount");
		_isEnd = true;
	}

	public void OnNormalDead()
	{
		RemoveExtraAddBuff();
		foreach (FrameCollisionData item in _triggerData?.ImpactingDatas)
		{
			if (item._entity != null)
			{
				item._entity.GetSystem<AlertHitInfoSystem>()?.ExitAlertHitInfo(mBaseEntity, item._entity);
			}
		}
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
	}

	public override void OnDispose()
	{
		_bulletData = null;
		triggerEntities.Clear();
		triggerEntities = null;
		onceTriggerEntities.Clear();
		if (volume != null)
		{
			ReferencePool.Release(volume);
			volume = null;
		}
		if (morphVolume != null)
		{
			ReferencePool.Release(morphVolume);
			morphVolume = null;
		}
		if (bulletMorphGroup != null)
		{
			ReferencePool.Release(bulletMorphGroup);
			bulletMorphGroup = null;
		}
		_triggerData.OnDispose();
		_stopTimer = 0f;
		_delayTimer = 0f;
		base.OnDispose();
	}

	public void DoAlertTriggerUpdate(float deltaTime)
	{
		if (mBaseEntity.IsSurvival)
		{
			OnBulletVolumeUpdate(deltaTime);
			OnEditorAlretBulletVolumeUpdate(deltaTime);
			if (CheckIsAbleTrigger() && CheckTriggerTimer(deltaTime))
			{
				DoAlertCollisionFixedUpdate(deltaTime);
			}
		}
	}

	private void DoAlertCollisionFixedUpdate(float deltaTime)
	{
		GetAlertTriggerEntities();
		_triggerData.DoUpdateBefore(deltaTime);
		_triggerData.OnEnterBefore(ref triggerEntities);
		_triggerData.OnEnter();
		DoAlertTriggerFixedUpdate(deltaTime);
		_triggerData.OnExit();
		for (int i = 0; i < _triggerData.ExitingDatas.Count; i++)
		{
			OnAlertExit(_triggerData.ExitingDatas[i]);
		}
	}

	private void DoAlertTriggerFixedUpdate(float deltaTime)
	{
		if (_triggerTypeEnum == BulletTriggerTypeEnum.IntervalTrigger)
		{
			DoShadowIntervalTriggerUpdate();
		}
		else
		{
			DoAlertFixedTriggerUpdate();
		}
	}

	private void GetAlertTriggerEntities()
	{
		triggerEntities.Clear();
		List<BaseEntity> hostileList = CollectionPool<List<BaseEntity>, BaseEntity>.Get();
		mBaseEntity.GetSystem<EntitySystem>().FindAllSurvivalEntities(mBaseEntity.Parent, in hostileList, containSelf: true);
		HitVolume bulletVolume = GetBulletVolume();
		VolumeSystem system = mBaseEntity.GetSystem<VolumeSystem>();
		foreach (BaseEntity item in hostileList)
		{
			if (item.GetComponent<HitColliderComponent>() != null && system.IsAlertIntersect(bulletVolume, item.Id))
			{
				triggerEntities.Add(item);
			}
		}
		CollectionPool<List<BaseEntity>, BaseEntity>.Release(hostileList);
	}

	private void DoAlertFixedTriggerUpdate()
	{
		List<FrameCollisionData> list = _triggerData.ImpactingDatas;
		if (_triggerTypeEnum == BulletTriggerTypeEnum.HitTrigger)
		{
			list = _triggerData.EnteringDatas;
		}
		for (int i = 0; i < list.Count; i++)
		{
			FrameCollisionData value = list[i];
			if (value._entity.IsSurvival && value._lastImpact + value._interval < _triggerData.Timer)
			{
				if (!CheckIsAbleTrigger())
				{
					break;
				}
				if (mBaseEntity.GetComponent<BulletHitJudgmentComponent>().CheckEntityShadowHitJudgment(value._entity))
				{
					value._lastImpact = _triggerData.Timer;
					list[i] = value;
				}
			}
		}
	}

	private void DoShadowIntervalTriggerUpdate()
	{
		bool flag = false;
		float bulletLastImpact = _bulletLastImpact;
		float timer = _triggerData.Timer;
		for (int i = 0; i < _triggerData.ImpactingDatas.Count; i++)
		{
			FrameCollisionData frameCollisionData = _triggerData.ImpactingDatas[i];
			if (frameCollisionData._entity.IsSurvival && _bulletLastImpact + _triggerInterval < timer)
			{
				if (!CheckIsAbleTrigger())
				{
					break;
				}
				if (mBaseEntity.GetComponent<BulletHitJudgmentComponent>().CheckEntityShadowHitJudgment(frameCollisionData._entity) && !flag)
				{
					bulletLastImpact = timer;
					flag = true;
				}
			}
		}
		_bulletLastImpact = bulletLastImpact;
	}
}
