using GameFramework;

namespace Ase.ECS;

public abstract class BaseMonsterUnit : IReference
{
	protected int unitId;

	protected int maxAttackTime;

	public int Id => unitId;

	public virtual void Init(int id, int maxAttackTime)
	{
		unitId = id;
		this.maxAttackTime = maxAttackTime;
	}

	public abstract bool CheckAttack(int targetId, int monsterEntityId);

	public abstract void CancelAttack(int targetId, int monsterType, int attackEntityId);

	public abstract void CancelMonsterAllAttack(int attackEntityId);

	public virtual void Clear()
	{
		unitId = 0;
		maxAttackTime = 0;
	}

	public virtual void OnDispose()
	{
	}
}
