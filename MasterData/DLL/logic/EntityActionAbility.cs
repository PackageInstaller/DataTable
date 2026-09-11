using Entitas;

[Sim]
public class EntityActionAbility : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public int mAbilityID;

	public int mHitIndex;

	public int mOffsetIndex;

	public int mTargetID;

	public int mKartunTime;

	public bool mIsPressing;

	public int mCurLockIndex;

	public int mCasterID;

	public bool mEnableAbilityMovement = true;

	public int mAbilitySpeed = 100;

	public int mLogicTime;

	public int mCurrentStateIndex;

	public int mCurTurnIndex;

	private int mAttackApproachSpeed;

	public bool mInUltimateAvoidFrame;

	public int mTimeStep;

	public bool mCanBeParry;

	public int MAttackApproachSpeed
	{
		get
		{
			return mAttackApproachSpeed;
		}
		set
		{
			mAttackApproachSpeed = value;
		}
	}

	public bool TryGetTurnDirectionAndIndex(out int direction, out int index)
	{
		direction = mCurTurnIndex >> 8;
		if (direction != 0)
		{
			direction = ((direction != 1) ? 1 : (-1));
		}
		index = mCurTurnIndex & 0xFF;
		return direction != 0;
	}

	public void SetTurnDirectionAndIndex(int direction, int index)
	{
		if (direction == 0)
		{
			mCurTurnIndex = index;
		}
		else
		{
			mCurTurnIndex = (((direction < 0) ? 1 : 2) << 8) | index;
		}
	}

	public void Reset(Entity entity)
	{
		mStatus = EntityActionStatus.E_ACTIVE;
		mHitIndex = 0;
		mOffsetIndex = 0;
		mCurrentStateIndex = 0;
		mCanBeParry = false;
	}
}
