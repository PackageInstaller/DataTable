namespace Ase;

public struct WeaponGunBulletData
{
	private WeaponGunBulletType bulletType;

	public WeaponGunBulletType BulletType => bulletType;

	public void SetBulletType(WeaponGunBulletType bulletType)
	{
		this.bulletType = bulletType;
	}

	public override string ToString()
	{
		return $"子弹类型 : {bulletType}";
	}
}
