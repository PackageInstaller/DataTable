using Config;
using Entitas;

[Sim]
public class EntityHitRecover : IComponent
{
	public E_HitRecover mHitRecover = E_HitRecover.OnEnter;

	public int mHitRecoverTime = 200;

	public int mHitRecoverActionID;

	public Int3 mLookAtDirection = Int3.one;

	public Int3 mHitDirection = Int3.zero;

	public int mHitSpeed;

	public int mHitAcceleration;

	public HitCheckInfo mHitInfo;

	public int mHitUpSpeed;

	public bool mEnableMovement = true;

	public int mHitOffsetTime;

	public E_HitRecoverStatus mHitRecoverStatus;

	public int mCanProcessVerticalTime;

	public int mHitAbilityID;

	public int mHitCount;

	public int mHitHorizontalSpeedOnFloat;

	public int mCurrentStateIndex;

	public int mTimeScale = 100;

	public int mLoop = 1;

	public int mTimeStep;

	public int mCasterID;

	public Int3 mLastOffsetMove = Int3.zero;
}
