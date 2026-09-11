using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建空气墙", 0)]
[Category("Logic/Trigger")]
[Description("创建空气墙")]
public class CreateAirWall : CallableFunctionNode<int, Int3, Int3, Int3>
{
	public override int Invoke(Int3 position, Int3 forward, Int3 size)
	{
		SimEntity simEntity = SpawnProcessor.CreateEmptyEntity();
		simEntity.AddEntityPositon(position, forward, IntMath.AngleOfVector(forward), Int3.up, newIsTeleport: false);
		simEntity.AddEntityRemotePlayer(0, 0, newMIsLocalPlayer: false);
		SimBox simBox = SimShapeProcessor.CreateSimBox(simEntity.creationIndex, position, size, forward, RoleType.Bunker);
		simEntity.AddEntityShape(Int3.zero, ShapePartType.Body, simBox, uint.MaxValue, int.MaxValue, default(ShapePartInfo));
		RecastGraphProcessor.RecastGraphCut(RecastGraphProcessor.mSimContext, simEntity, simBox);
		base.parentNode.mSimContext.PostEvent(new EntitySpawnedEvent(simEntity.creationIndex, position, forward, size));
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(SpawnProcessor.GetLocalPlayerID());
		AirWallEnableEvent airWallEnableEvent = AirWallEnableEvent.Claim();
		airWallEnableEvent.pos = simEntity.entityPositon.mPosition;
		airWallEnableEvent.playerPos = entityWithEntityID.entityPositon.mPosition;
		airWallEnableEvent.id = simEntity.creationIndex;
		airWallEnableEvent.enable = true;
		airWallEnableEvent.forward = simEntity.entityPositon.mForward;
		base.parentNode.mSimContext.PostEvent(airWallEnableEvent);
		return simEntity.creationIndex;
	}
}
