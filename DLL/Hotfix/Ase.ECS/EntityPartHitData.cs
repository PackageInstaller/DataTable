namespace Ase.ECS;

public class EntityPartHitData
{
	private int index;

	private float hpRatio;

	private int stateId;

	private float hpThreshold;

	private float processRatio;

	private int processCount;

	private int damage;

	public void Init(int index, float hpRatio, int stateId, float processRatio)
	{
		this.index = index;
		this.hpRatio = hpRatio;
		this.stateId = stateId;
		this.processRatio = processRatio;
	}

	public void RefreshHpThreshold(float maxHp)
	{
		hpThreshold = maxHp * (hpRatio + (float)processCount * processRatio);
		_ = BattleCommonLog.Open_EntityPartHitLog;
	}

	public void AddHitDamage(int damage)
	{
		this.damage += damage;
		_ = BattleCommonLog.Open_EntityPartHitLog;
	}

	public bool CheckState()
	{
		return (float)damage >= hpThreshold;
	}

	public void RefreshState()
	{
		damage = 0;
		processCount++;
	}

	public int GetStateId()
	{
		return stateId;
	}

	public void ResetDamage(int value = 0)
	{
		damage = value;
	}

	public void ResetProcessCount(int value = 0)
	{
		processCount = value;
	}
}
