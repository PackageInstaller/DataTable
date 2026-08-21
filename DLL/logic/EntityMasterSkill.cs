using Entitas;

[Sim]
public class EntityMasterSkill : IComponent, IComponentReset
{
	public EntityActionStatus mState;

	public int mValue;

	public int mMaxValue;

	public int mCD;

	public int mMaxCD;

	public int mConsumeValue;

	public int mConsumeCD;

	public int mConfigID;

	public void Reset(Entity entity)
	{
		mState = EntityActionStatus.None;
		mValue = 0;
		mMaxValue = 0;
		mCD = 0;
		mMaxCD = 0;
		mConsumeValue = 0;
		mConsumeCD = 0;
		mConfigID = 0;
	}
}
