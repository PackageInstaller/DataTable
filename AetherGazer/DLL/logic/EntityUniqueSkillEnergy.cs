using Entitas;

[Sim]
public class EntityUniqueSkillEnergy : IComponent, IComponentReset
{
	public EntityActionStatus mState;

	public int mValue;

	public int mMaxValue;

	public int mAddValue;

	public int mTick;

	public int mRuntime;

	public void Reset(Entity entity)
	{
		mState = EntityActionStatus.None;
		mValue = 0;
		mMaxValue = 0;
		mAddValue = 0;
		mTick = 0;
		mRuntime = 0;
	}
}
