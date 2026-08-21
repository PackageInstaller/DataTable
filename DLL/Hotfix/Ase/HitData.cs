using GameFramework;

namespace Ase;

public class HitData : IReference
{
	private int _exactAttackerId;

	private int _attackerId;

	private int _defenderId;

	private BaseWeaknessData _weaknessData;

	private int _bulletId;

	private int _belongSkillId;

	private int siteLevel;

	private bool isSubDamageSuccess;

	public int ExactAttackerId => _exactAttackerId;

	public int AttackerId => _attackerId;

	public int DefenderId => _defenderId;

	public int BulletId => _bulletId;

	public BaseWeaknessData WeaknessData => _weaknessData;

	public int SiteLevel => siteLevel;

	public bool IsSubDamageSuccess => isSubDamageSuccess;

	public int BelongSkillId => _belongSkillId;

	public static HitData Create(int fromId, int exactAttackerId, int defenderId, int bulletId, int skillId, int siteLevel, bool isSubDamageSuccess)
	{
		HitData hitData = ReferencePool.Acquire<HitData>();
		hitData._attackerId = fromId;
		hitData._exactAttackerId = exactAttackerId;
		hitData._defenderId = defenderId;
		hitData._bulletId = bulletId;
		hitData._belongSkillId = skillId;
		hitData.siteLevel = siteLevel;
		hitData.isSubDamageSuccess = isSubDamageSuccess;
		return hitData;
	}

	public void SetHitData(int defenderId, BaseWeaknessData weaknessData)
	{
		_defenderId = defenderId;
		_weaknessData = weaknessData;
	}

	public void Clear()
	{
		_attackerId = 0;
		_weaknessData = null;
	}

	public void Dispose()
	{
		ReferencePool.Release(this);
	}

	public override string ToString()
	{
		return $"HitData = [{_attackerId} ]";
	}
}
