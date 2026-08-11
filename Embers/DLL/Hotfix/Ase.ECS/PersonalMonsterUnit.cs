using System.Collections.Generic;
using GameFramework;

namespace Ase.ECS;

public class PersonalMonsterUnit : BaseMonsterUnit
{
	private Dictionary<int, List<int>> _targetEntityAttackTime;

	private Dictionary<int, AttackedEntity> _attackedEntities;

	public override void Init(int id, int maxAttackTime)
	{
		base.Init(id, maxAttackTime);
		_attackedEntities = new Dictionary<int, AttackedEntity>();
		if (_targetEntityAttackTime == null)
		{
			_targetEntityAttackTime = new Dictionary<int, List<int>>();
		}
	}

	public override bool CheckAttack(int targetId, int monsterEntityId)
	{
		if (_targetEntityAttackTime.TryGetValue(monsterEntityId, out var value) && value.Contains(targetId))
		{
			return true;
		}
		if (_attackedEntities.TryGetValue(targetId, out var value2))
		{
			if (value2.attackTime < maxAttackTime)
			{
				value2.attackTime++;
				CheckAttackOrAttacked(monsterEntityId, targetId);
				return true;
			}
			return false;
		}
		AttackedEntity attackedEntity = ReferencePool.Acquire<AttackedEntity>();
		attackedEntity.targetId = targetId;
		attackedEntity.attackTime = 1;
		_attackedEntities[targetId] = attackedEntity;
		CheckAttackOrAttacked(monsterEntityId, targetId);
		return true;
	}

	private void CheckAttackOrAttacked(int monsterEntityId, int targetId)
	{
		if (_targetEntityAttackTime.TryGetValue(monsterEntityId, out var value))
		{
			if (!value.Contains(targetId))
			{
				_targetEntityAttackTime[monsterEntityId].Add(targetId);
			}
		}
		else
		{
			List<int> value2 = new List<int> { targetId };
			_targetEntityAttackTime.Add(monsterEntityId, value2);
		}
	}

	public override void CancelAttack(int targetId, int monsterType, int attackEntityId)
	{
		if (!_targetEntityAttackTime.TryGetValue(attackEntityId, out var value) || !value.Contains(targetId))
		{
			return;
		}
		value.Remove(targetId);
		if (_attackedEntities.TryGetValue(targetId, out var value2))
		{
			value2.attackTime--;
			if (value2.attackTime < 0)
			{
				value2.attackTime = 0;
			}
		}
	}

	public override void CancelMonsterAllAttack(int attackEntityId)
	{
		if (!_targetEntityAttackTime.TryGetValue(attackEntityId, out var value))
		{
			return;
		}
		foreach (int item in value)
		{
			if (_attackedEntities.TryGetValue(item, out var value2))
			{
				value2.attackTime--;
				if (value2.attackTime < 0)
				{
					value2.attackTime = 0;
				}
			}
		}
		value.Clear();
		_targetEntityAttackTime.Remove(attackEntityId);
	}

	public override void Clear()
	{
		base.Clear();
		_targetEntityAttackTime.Clear();
		foreach (AttackedEntity value in _attackedEntities.Values)
		{
			ReferencePool.Release(value);
		}
		_attackedEntities.Clear();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		ReferencePool.Release(this);
	}
}
