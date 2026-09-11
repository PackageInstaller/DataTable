public sealed class UniqueSkillEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mStep;

	public int mCasterID;

	public int mTargetID;

	public bool mIsCooperating;

	public int mParam;

	public UniqueSkillEvent(int pStep, int pCasterID, int pTargetID, bool pIsCooperating, int pParam)
	{
		mStep = pStep;
		mCasterID = pCasterID;
		mTargetID = pTargetID;
		mIsCooperating = pIsCooperating;
		mParam = pParam;
	}

	public UniqueSkillEvent()
	{
	}

	public static UniqueSkillEvent Claim(int pStep, int pCasterID, int pTargetID, bool pIsCooperating, int pParam)
	{
		UniqueSkillEvent uniqueSkillEvent = FrameObjectPool<UniqueSkillEvent>.Claim();
		uniqueSkillEvent.mStep = pStep;
		uniqueSkillEvent.mCasterID = pCasterID;
		uniqueSkillEvent.mTargetID = pTargetID;
		uniqueSkillEvent.mIsCooperating = pIsCooperating;
		uniqueSkillEvent.mParam = pParam;
		return uniqueSkillEvent;
	}

	public override void OnEnterPool()
	{
		mStep = 0;
		mCasterID = 0;
		mTargetID = 0;
		mIsCooperating = false;
		mParam = 0;
	}

	public override void Release()
	{
		FrameObjectPool<UniqueSkillEvent>.Release(this);
	}
}
