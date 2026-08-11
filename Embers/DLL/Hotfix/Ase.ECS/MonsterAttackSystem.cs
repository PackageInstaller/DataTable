using System.Collections.Generic;
using GameFramework;

namespace Ase.ECS;

public class MonsterAttackSystem : BaseSystem
{
	private Dictionary<int, BaseMonsterUnit> _monsterUnits;

	protected override bool IsLogicSystem => true;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_monsterUnits = new Dictionary<int, BaseMonsterUnit>();
		DRMonsterAttack[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRMonsterAttack>();
		foreach (DRMonsterAttack dRMonsterAttack in allDataRow)
		{
			BaseMonsterUnit baseMonsterUnit = null;
			switch (dRMonsterAttack.MonsterUnitEnum)
			{
			case MonsterUnitEnum.Personal:
				baseMonsterUnit = ReferencePool.Acquire<PersonalMonsterUnit>();
				break;
			case MonsterUnitEnum.Team:
				baseMonsterUnit = ReferencePool.Acquire<TeamMonsterUnit>();
				break;
			}
			if (baseMonsterUnit != null)
			{
				baseMonsterUnit.Init(dRMonsterAttack.Id, dRMonsterAttack.MaxCount);
				_monsterUnits.Add(baseMonsterUnit.Id, baseMonsterUnit);
			}
		}
	}

	public bool RequestAttackById(int monsterEntityId, int monsterAttackCtrlId, int targetId)
	{
		BaseMonsterUnit baseMonsterUnit = TryGetMonsterUnit(monsterAttackCtrlId);
		if (baseMonsterUnit == null)
		{
			return false;
		}
		if (CheckAttackSuccess(baseMonsterUnit, targetId, monsterEntityId))
		{
			return true;
		}
		return false;
	}

	public void ReleaseAttackById(int monsterAttackCtrlId, int targetId, int attackEntityId)
	{
		TryGetMonsterUnit(monsterAttackCtrlId)?.CancelAttack(targetId, monsterAttackCtrlId, attackEntityId);
	}

	public void ReleaseAttack(int attackEntityId, int monsterAttackCtrlId)
	{
		TryGetMonsterUnit(monsterAttackCtrlId)?.CancelMonsterAllAttack(attackEntityId);
	}

	private BaseMonsterUnit TryGetMonsterUnit(int monsterAttackCtrlId)
	{
		if (_monsterUnits.TryGetValue(monsterAttackCtrlId, out var value))
		{
			return value;
		}
		return null;
	}

	private bool CheckAttackSuccess(BaseMonsterUnit unit, int targetId, int monsterEntityId)
	{
		return unit.CheckAttack(targetId, monsterEntityId);
	}

	public override void OnDispose()
	{
		base.OnDispose();
		foreach (BaseMonsterUnit value in _monsterUnits.Values)
		{
			value.Clear();
			value.OnDispose();
		}
		_monsterUnits.Clear();
	}
}
