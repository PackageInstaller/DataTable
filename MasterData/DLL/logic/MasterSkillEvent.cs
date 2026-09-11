public sealed class MasterSkillEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mCasterID;

	public int mConfigID;

	public override void OnEnterPool()
	{
		mCasterID = 0;
		mConfigID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<MasterSkillEvent>.Release(this);
	}

	public static MasterSkillEvent Claim(int pCasterID, int pConfigID)
	{
		MasterSkillEvent masterSkillEvent = FrameObjectPool<MasterSkillEvent>.Claim();
		masterSkillEvent.mCasterID = pCasterID;
		masterSkillEvent.mConfigID = pConfigID;
		return masterSkillEvent;
	}
}
