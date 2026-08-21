using System.Collections.Generic;
using GameFramework;
using UnityEngine.Pool;

namespace Ase.ECS;

public class FrameFrozenSystem : BaseSystem
{
	private int _serialId;

	private Dictionary<int, FrozenFrameData> _frameData = new Dictionary<int, FrozenFrameData>();

	private Dictionary<int, List<int>> _frameDataDic = new Dictionary<int, List<int>>();

	private readonly List<int> _removeList = new List<int>();

	protected override bool IsLogicSystem => true;

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		foreach (int key in _frameData.Keys)
		{
			_frameData[key].FrozenTime -= 0.033f;
			if (_frameData[key].FrozenTime <= 0f)
			{
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance.WriteAuthorityEntityId($"冻帧结束：{_frameData[key].TargetEntityId}", _frameData[key].TargetEntity);
				}
				_frameData[key].EndFrozen();
				_removeList.Add(key);
			}
		}
		foreach (int remove in _removeList)
		{
			_frameData.Remove(remove);
		}
		_removeList.Clear();
	}

	public int AddFrozenAndChaseFrame(float speed, int priority, BaseEntity entity, int frozenFrame, int frozenTarget, List<int> hitSfx, bool isIgnoreStateEndFrozen = false)
	{
		if (frozenTarget == 0)
		{
			return entity.Id;
		}
		if (_frameData.TryGetValue(entity.Id, out var value))
		{
			if (value.Priority > priority)
			{
				return entity.Id;
			}
			value.EndFrozen();
			_frameData.Remove(entity.Id);
		}
		FrozenFrameData frozenFrameData = ReferencePool.Acquire<FrozenFrameData>();
		frozenFrameData.RegisterTargetEntity(entity, frozenTarget, priority);
		frozenFrameData.InitData(frozenFrame, ++_serialId, isIgnoreStateEndFrozen);
		RegisterFrozenData(frozenFrameData.TargetEntityId, frozenFrameData.localId);
		List<EffectEntity> frozenEffectEntities = GetSystem<EntitySystem>().GetFrozenEffectEntities(entity);
		List<EffectEntity> list = ((hitSfx != null) ? frozenEffectEntities.Where((EffectEntity effectEntity) => hitSfx.Contains(effectEntity.ConfigId)).ToList() : frozenEffectEntities);
		if (frozenTarget == 4 || frozenTarget == 2 || frozenTarget == 3)
		{
			foreach (EffectEntity item in list)
			{
				frozenFrameData.AddFrozenEntity(speed, item, 2);
			}
		}
		List<EffectEntity> list2 = ((hitSfx != null) ? frozenEffectEntities.Where((EffectEntity effectEntity) => !hitSfx.Contains(effectEntity.ConfigId)).ToList() : frozenEffectEntities);
		if (frozenTarget == 2 || frozenTarget == 3)
		{
			foreach (EffectEntity item2 in list2)
			{
				frozenFrameData.AddFrozenEntity(speed, item2, 4);
			}
		}
		if (frozenTarget == 1 || frozenTarget == 3)
		{
			frozenFrameData.AddFrozenEntity(speed, entity, 1);
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"添加冻帧信息，冻帧时间：{frozenFrameData.FrozenTime}", entity);
		}
		_frameData.Add(frozenFrameData.TargetEntityId, frozenFrameData);
		return frozenFrameData.TargetEntityId;
	}

	private void RegisterFrozenData(int entityId, int frozenDataId)
	{
		if (!_frameDataDic.ContainsKey(entityId))
		{
			List<int> list = CollectionPool<List<int>, int>.Get();
			list.Add(frozenDataId);
			_frameDataDic.Add(entityId, list);
			return;
		}
		Dictionary<int, List<int>> frameDataDic = _frameDataDic;
		if (frameDataDic[entityId] == null)
		{
			List<int> list2 = (frameDataDic[entityId] = CollectionPool<List<int>, int>.Get());
		}
		_frameDataDic[entityId].Add(frozenDataId);
	}

	public int AddFrozenAndChaseFrame(int priority, BaseEntity entity, BuffDataDamage buffDataDamage)
	{
		if (buffDataDamage == null)
		{
			return 0;
		}
		if (buffDataDamage.bulletAttackData == null)
		{
			return 0;
		}
		if (buffDataDamage.bulletAttackData.bulletData == null)
		{
			return 0;
		}
		int frozenFrame = buffDataDamage.bulletAttackData.bulletData.cfg.FrozenFrame;
		if (frozenFrame == 0)
		{
			return entity.Id;
		}
		int frozenTarget = buffDataDamage.bulletAttackData.bulletData.cfg.FrozenTarget;
		float frozenSpeed = buffDataDamage.bulletAttackData.bulletData.cfg.FrozenSpeed;
		List<int> hitSfx = buffDataDamage.bulletAttackData.bulletData.cfg.HitSfx;
		return AddFrozenAndChaseFrame(frozenSpeed, priority, entity, frozenFrame, frozenTarget, hitSfx);
	}

	public void EndFrozenFrame(int frozenId, bool isStateBreak = false)
	{
		if (_frameData.TryGetValue(frozenId, out var value) && (!isStateBreak || !value.IsIgnoreStateEndFrozen))
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId("提前结束冻帧：设置时间为0", value.TargetEntity);
			}
			value.FrozenTime = 0f;
		}
	}

	public void EndFrozenFrame(int entityId, int frozentype)
	{
		foreach (FrozenFrameData value in _frameData.Values)
		{
			if (value.TargetEntityId == entityId)
			{
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance.WriteAuthorityEntityId($"提前结束冻帧类型：{frozentype}", value.TargetEntity);
				}
				value.EndFrozen(frozentype);
			}
		}
	}

	public void StateBreakEntityFrozenFrame(BaseEntity baseEntity, bool isStateBreak)
	{
		if (!_frameDataDic.TryGetValue(baseEntity.Id, out var value))
		{
			return;
		}
		if (value != null)
		{
			for (int i = 0; i < value.Count; i++)
			{
				EndFrozenFrame(value[i], isStateBreak);
			}
			value.Clear();
			CollectionPool<List<int>, int>.Release(value);
		}
		_frameDataDic.Remove(baseEntity.Id);
	}

	public override void OnPauseBefore()
	{
		foreach (int key in _frameData.Keys)
		{
			_frameData[key].EndFrozen();
		}
		_frameData.Clear();
	}

	public override void OnDispose()
	{
		Dictionary<int, FrozenFrameData>.Enumerator enumerator = _frameData.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.OnDispose();
		}
		enumerator.Dispose();
		_frameData.Clear();
		base.OnDispose();
	}
}
