using Entitas;

[Sim]
public class EntityActionParrying : IComponent, IComponentReset
{
	public int mAngle;

	public uint mEnableFlag;

	public int mEnableCount;

	public void Reset(Entity entity)
	{
		mAngle = 0;
		mEnableFlag = 0u;
		mEnableCount = 0;
	}

	public void EnableOfAbility(bool enable)
	{
		SetEnableFlag(En_ParryingEnableType.Ability, enable);
	}

	public void SetEnableFlag(En_ParryingEnableType type, bool enable)
	{
		SetEnableFlag((int)type, enable);
	}

	public void SetEnableFlag(int index, bool enable)
	{
		if (enable)
		{
			mEnableFlag = (uint)(1 << index) | mEnableFlag;
		}
		else
		{
			mEnableFlag = (uint)(~(1 << index)) & mEnableFlag;
		}
	}

	public bool IsEnable()
	{
		if (mEnableFlag == 0)
		{
			return mEnableCount > 0;
		}
		return true;
	}

	public bool IsInNodeControl()
	{
		return ((mEnableFlag >> 2) & 1) == 1;
	}
}
