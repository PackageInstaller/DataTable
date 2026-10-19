using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Event;

public class MotionStateChangeEvt : BaseEventContent
{
	public Entity entity;

	public MotionState curState;

	public MotionState beforeState;

	public override void ReleaseEvt()
	{
		entity = default;
		curState = MotionState.None;
		beforeState = MotionState.None;
		base.ReleaseEvt();
	}
}
