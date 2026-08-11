namespace Ase;

public class BulletBattleOnceData
{
	private uint usedTick;

	public BulletBattleOnceData()
	{
		usedTick = 0u;
	}

	public bool IsUsedFrameProperty(uint tick)
	{
		if (usedTick != tick)
		{
			usedTick = tick;
			return true;
		}
		return false;
	}

	public BulletBattleOnceData Clone()
	{
		return new BulletBattleOnceData
		{
			usedTick = usedTick
		};
	}
}
