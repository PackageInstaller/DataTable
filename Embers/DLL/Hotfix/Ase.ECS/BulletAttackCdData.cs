using GameFramework;

namespace Ase.ECS;

public class BulletAttackCdData : IReference
{
	private float _fixedCd;

	private float _cdTimer;

	public static BulletAttackCdData Create(DRBullet drBullet)
	{
		BulletAttackCdData bulletAttackCdData = ReferencePool.Acquire<BulletAttackCdData>();
		bulletAttackCdData._fixedCd = drBullet.TriggerCd;
		bulletAttackCdData._cdTimer = 0f;
		return bulletAttackCdData;
	}

	public void UpdateCd(float deltaTime)
	{
		_cdTimer += deltaTime;
	}

	public bool IsInCd()
	{
		if (_cdTimer >= _fixedCd)
		{
			_cdTimer = 0f;
			return false;
		}
		return true;
	}

	public void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public void Clear()
	{
		_fixedCd = 0f;
		_cdTimer = 0f;
	}
}
