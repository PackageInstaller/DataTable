using System.Collections.Generic;
using GameFramework;

namespace Ase.ECS;

public class BulletTriggerData : IReference, IPrimitiveCollision
{
	private float _triggerInterval;

	private float _timer;

	private List<BaseEntity> _lastFrameHit = new List<BaseEntity>();

	private List<BaseEntity> _currentFrameHit = new List<BaseEntity>();

	private List<BaseEntity> _toBeRemoved = new List<BaseEntity>();

	private List<FrameCollisionData> _enteringDatas = new List<FrameCollisionData>();

	private List<FrameCollisionData> _impactingDatas = new List<FrameCollisionData>();

	private List<FrameCollisionData> _exitingDatas = new List<FrameCollisionData>();

	public List<FrameCollisionData> EnteringDatas => _enteringDatas;

	public List<FrameCollisionData> ImpactingDatas => _impactingDatas;

	public List<FrameCollisionData> ExitingDatas => _exitingDatas;

	public float Timer => _timer;

	public void Init(float interval)
	{
		_triggerInterval = interval;
		_timer = 0f;
	}

	public virtual void DoUpdateBefore(float deltaTime)
	{
		_timer += deltaTime;
	}

	public void OnEnterBefore(ref List<BaseEntity> triggerEntities)
	{
		_currentFrameHit = triggerEntities;
	}

	public void OnEnter()
	{
		ClearEnteringData();
		ClearExitingDatas();
		foreach (BaseEntity item in _currentFrameHit)
		{
			if (!_lastFrameHit.Contains(item))
			{
				FrameCollisionData collisionData = new FrameCollisionData
				{
					_entity = item,
					_interval = _triggerInterval,
					_lastImpact = -1f
				};
				collisionData.sn = collisionData.GetSN();
				HandleImpactingData(collisionData);
				_lastFrameHit.Add(item);
			}
		}
		foreach (BaseEntity item2 in _lastFrameHit)
		{
			if (_currentFrameHit.Contains(item2))
			{
				continue;
			}
			for (int i = 0; i < _impactingDatas.Count; i++)
			{
				if (item2 == _impactingDatas[i]._entity)
				{
					HandleExitingData(_impactingDatas[i]);
					break;
				}
			}
			if (_toBeRemoved.IndexOf(item2) == -1)
			{
				_toBeRemoved.Add(item2);
			}
		}
	}

	private void HandleImpactingData(FrameCollisionData collisionData)
	{
		_enteringDatas.Add(collisionData);
		_impactingDatas.Add(collisionData);
	}

	public void OnExit()
	{
		foreach (BaseEntity item in _toBeRemoved)
		{
			_lastFrameHit.Remove(item);
		}
		_toBeRemoved.Clear();
		_currentFrameHit.Clear();
	}

	private void HandleExitingData(FrameCollisionData collisionData)
	{
		if (_exitingDatas.IndexOf(collisionData) == -1)
		{
			_exitingDatas.Add(collisionData);
		}
		_impactingDatas.Remove(collisionData);
	}

	private void ClearEnteringData()
	{
		for (int i = 0; i < _enteringDatas.Count; i++)
		{
			_enteringDatas[i].Clear();
		}
		_enteringDatas.Clear();
	}

	private void ClearImpactingData()
	{
		for (int i = 0; i < _impactingDatas.Count; i++)
		{
			_impactingDatas[i].Clear();
		}
		_impactingDatas.Clear();
	}

	private void ClearExitingDatas()
	{
		for (int i = 0; i < _exitingDatas.Count; i++)
		{
			_exitingDatas[i].Clear();
		}
		_exitingDatas.Clear();
	}

	private void ClearFrameCollision()
	{
		_lastFrameHit.Clear();
		_currentFrameHit.Clear();
		_toBeRemoved.Clear();
	}

	public void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public void Clear()
	{
		ClearFrameCollision();
		ClearEnteringData();
		ClearImpactingData();
		ClearExitingDatas();
	}
}
