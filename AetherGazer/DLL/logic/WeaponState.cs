public class WeaponState : SimPersistentState
{
	public int mBulletsRemain;

	public int mBulletsRemainInWeapon;

	public WeaponStatus mWeaponStatus;

	public Int3 mDirection;

	public int mTargetEntity;

	public override void OnEnterPool()
	{
		mDirection = Int3.zero;
		mBulletsRemain = 0;
		mBulletsRemainInWeapon = 0;
		mTargetEntity = 0;
	}

	public static WeaponState Claim()
	{
		return FrameObjectPool<WeaponState>.Claim();
	}

	public override void Release()
	{
		FrameObjectPool<WeaponState>.Release(this);
	}
}
