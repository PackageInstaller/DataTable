using System.Collections.Generic;
using GameFramework;

namespace Ase.ECS;

public class TeamMonsterUnit : BaseMonsterUnit
{
	private List<int> _attackerList;

	private int _recordAttackCount;

	public override void Init(int id, int maxAttackTime)
	{
		base.Init(id, maxAttackTime);
		_recordAttackCount = 0;
		_attackerList = new List<int>();
	}

	public override bool CheckAttack(int targetId, int monsterEntityId)
	{
		if (_attackerList.Contains(monsterEntityId))
		{
			return true;
		}
		if (_recordAttackCount < maxAttackTime)
		{
			_attackerList.Add(monsterEntityId);
			_recordAttackCount++;
			return true;
		}
		return false;
	}

	public override void CancelAttack(int targetId, int monsterType, int attackEntityId)
	{
		if (_attackerList.Contains(attackEntityId))
		{
			_attackerList.Remove(attackEntityId);
		}
		_recordAttackCount--;
		if (_recordAttackCount < 0)
		{
			_recordAttackCount = 0;
		}
	}

	public override void CancelMonsterAllAttack(int attackEntityId)
	{
		if (_attackerList.Contains(attackEntityId))
		{
			_attackerList.Remove(attackEntityId);
		}
		_recordAttackCount--;
		if (_recordAttackCount < 0)
		{
			_recordAttackCount = 0;
		}
	}

	public override void Clear()
	{
		base.Clear();
		_recordAttackCount = 0;
		_attackerList = null;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		ReferencePool.Release(this);
	}
}
