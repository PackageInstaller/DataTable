using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("绑定跟踪实体", "Action", new string[] { "bind", "track", "entity", "target", "retarget", "aim" })]
public class ActionBindTrackEntity : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.owner.IsTrajectory())
		{
			memory.owner.GetCompAim().aimEntity = memory.target.entity;
		}
	}
}
