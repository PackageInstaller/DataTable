using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class EntityDefenceComponent : BaseComponent
{
	private List<DefendDir> _defendsList;

	private int _effectId;

	private float _interval;

	private bool _isPlayEffect;

	private string _pointKey;

	private float _time;

	public float subHarmValue;

	public float subTenacityValue;

	public override void OnInit(object data)
	{
		base.OnInit(data);
		_defendsList = new List<DefendDir>();
		subHarmValue = 0f;
		subTenacityValue = 0f;
		_time = 0f;
		_isPlayEffect = true;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (!_isPlayEffect)
		{
			_time = Mathf.Clamp(_time - deltaTime, 0f, _interval);
			if (_time == 0f)
			{
				_isPlayEffect = true;
			}
		}
	}

	public void SetDefendValue(float subHarmValue, float subTenacityValue, float defendStartAngle, float defendEndAngle, int effectId, float interval, string pointKey)
	{
		RecycleDefend();
		List<DefendDir> list = CollectionPool<List<DefendDir>, DefendDir>.Get();
		this.subHarmValue = subHarmValue;
		this.subTenacityValue = subTenacityValue;
		_effectId = effectId;
		_interval = interval;
		_pointKey = pointKey;
		if (defendStartAngle > defendEndAngle)
		{
			DefendDir item = CreateDefendData(0f, defendEndAngle);
			list.Add(item);
			_defendsList.Add(item);
			DefendDir item2 = CreateDefendData(defendStartAngle, 359f);
			list.Add(item2);
			_defendsList.Add(item2);
		}
		else
		{
			DefendDir item3 = CreateDefendData(defendStartAngle, defendEndAngle);
			list.Add(item3);
			_defendsList.Add(item3);
		}
	}

	private void RecycleDefend()
	{
		for (int i = 0; i < _defendsList.Count; i++)
		{
			RecycleDefend(_defendsList[i]);
		}
		_defendsList.Clear();
		subHarmValue = 0f;
		subTenacityValue = 0f;
		_interval = 0f;
		_effectId = 0;
		_isPlayEffect = true;
		_time = 0f;
	}

	private void RecycleDefend(DefendDir defendDir)
	{
		ReferencePool.Release(defendDir);
	}

	private DefendDir CreateDefendData(float min, float max)
	{
		DefendDir defendDir = ReferencePool.Acquire<DefendDir>();
		defendDir.min = min;
		defendDir.max = max;
		defendDir.isUsed = true;
		return defendDir;
	}

	public void RemoveDefence()
	{
		RecycleDefend();
	}

	private bool CheckAttackDefend(float angle)
	{
		for (int i = 0; i < _defendsList.Count; i++)
		{
			if (_defendsList[i].isUsed)
			{
				if (_defendsList[i].min <= angle && _defendsList[i].max >= angle)
				{
					if (_isPlayEffect)
					{
						mBaseEntity.GetSystem<EffectSystem>().PlayEffect(mBaseEntity, mBaseEntity, EffectType.FOLLOW_BONE, _effectId, _pointKey, Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero, followParentDispose: true);
						_time = _interval;
						_isPlayEffect = false;
					}
					return true;
				}
			}
			else
			{
				_defendsList.Remove(_defendsList[i]);
			}
		}
		return false;
	}

	public bool CheckAttackAngle(Vector3 attackerPos, Vector3 bulletPos, bool isNear)
	{
		float num = 0f;
		num = ((!isNear) ? TSUtil.TargetFwdAngleToSelf(mBaseEntity.transform.position, mBaseEntity.transform.eulerAngles.y, bulletPos) : TSUtil.TargetFwdAngleToSelf(mBaseEntity.transform.position, mBaseEntity.transform.eulerAngles.y, attackerPos));
		num -= 180f;
		num = TSUtil.Harf2Full(num);
		num = ((Mathf.Abs(num - 360f) <= 1f) ? 359f : num);
		return CheckAttackDefend(num);
	}

	public bool EntityReduceDamageProbability(BaseEntity attackEntity)
	{
		float num = 0f;
		num = mBaseEntity.RandomFloat(0f, 1f);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"防御随机 ： {num}", mBaseEntity);
		}
		if (num < mBaseEntity.GetProperty("ReduceDamageProbability"))
		{
			return true;
		}
		return false;
	}

	private void ClearData()
	{
		RecycleDefend();
		_defendsList.Clear();
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		ClearData();
	}
}
