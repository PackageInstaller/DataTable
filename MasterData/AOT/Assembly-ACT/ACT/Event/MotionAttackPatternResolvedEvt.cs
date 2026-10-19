using ACT.Battle;

namespace ACT.Event;

public class MotionAttackPatternResolvedEvt : BaseEventContent
{
	public MotionAttackSourceInfo source;

	public int resolvedEnemyCount;

	public int damagedEnemyCount;

	public int killedEnemyCount;

	public override void ReleaseEvt()
	{
		source = default;
		resolvedEnemyCount = 0;
		damagedEnemyCount = 0;
		killedEnemyCount = 0;
	}
}
