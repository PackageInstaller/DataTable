using Entitas;

[Sim]
[IgnoreClone]
public class EntityExposedValue : IComponent
{
	public long mValue;

	public long mMaxValue;

	public long mReducedValue;

	public int mTick;

	public int mRuntime;

	public uint mResistEnter;

	public bool mManualEnter;

	public void SetResistEnterFlag(int index, bool isEnable)
	{
		if (isEnable)
		{
			mResistEnter = (uint)(1 << index) | mResistEnter;
		}
		else
		{
			mResistEnter = (uint)(~(1 << index)) & mResistEnter;
		}
	}
}
