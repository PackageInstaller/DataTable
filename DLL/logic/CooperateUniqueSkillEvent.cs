public sealed class CooperateUniqueSkillEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mStep;

	public int mCooperateEntityID1;

	public int mCooperateEntityID2;

	public int mCooperateEntityID3;

	public int mCooperateUniqueSkillID;

	public int mParam;

	public CooperateUniqueSkillEvent(int pStep, int pEntityID1, int pEntityID2, int pEntityID3, int pCooperateUniqueSkillID, int pParam)
	{
		mStep = pStep;
		mCooperateEntityID1 = pEntityID1;
		mCooperateEntityID2 = pEntityID2;
		mCooperateEntityID3 = pEntityID3;
		mCooperateUniqueSkillID = pCooperateUniqueSkillID;
		mParam = pParam;
	}

	public CooperateUniqueSkillEvent()
	{
	}

	public static CooperateUniqueSkillEvent Claim(int pStep, int pEntityID1, int pEntityID2, int pEntityID3, int pCooperateUniqueSkillID, int pParam)
	{
		CooperateUniqueSkillEvent cooperateUniqueSkillEvent = FrameObjectPool<CooperateUniqueSkillEvent>.Claim();
		cooperateUniqueSkillEvent.mStep = pStep;
		cooperateUniqueSkillEvent.mCooperateEntityID1 = pEntityID1;
		cooperateUniqueSkillEvent.mCooperateEntityID2 = pEntityID2;
		cooperateUniqueSkillEvent.mCooperateEntityID3 = pEntityID3;
		cooperateUniqueSkillEvent.mCooperateUniqueSkillID = pCooperateUniqueSkillID;
		cooperateUniqueSkillEvent.mParam = pParam;
		return cooperateUniqueSkillEvent;
	}

	public override void OnEnterPool()
	{
		mStep = 0;
		mCooperateEntityID1 = 0;
		mCooperateEntityID2 = 0;
		mCooperateEntityID3 = 0;
		mCooperateUniqueSkillID = 0;
		mParam = 0;
	}

	public override void Release()
	{
		FrameObjectPool<CooperateUniqueSkillEvent>.Release(this);
	}
}
