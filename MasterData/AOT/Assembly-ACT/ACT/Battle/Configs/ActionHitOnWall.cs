using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行命中时墙", "Action", new string[] { "hit", "on", "wall", "damage", "attack" })]
public class ActionHitOnWall : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.evt is EvtHitWall evtHitWall)
		{
			CmdHit hit = memory.target.entity.GetCompPhysics().HitOnWallParameterCalc(evtHitWall.hitWallNum, evtHitWall.changeDir);
			memory.target.entity.GetHit(hit);
		}
	}
}
