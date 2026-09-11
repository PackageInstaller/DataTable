using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建傀儡", 0)]
[Category("Logic/Spawn")]
[Description("按等级创建怪物")]
public class CreatePuppet : CallableFunctionNode<int, int, int, Int3>
{
	public override int Invoke(int entityID, int configID, Int3 offset)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		if (!entityWithEntityID.hasEntityPuppetHost)
		{
			entityWithEntityID.AddEntityPuppetHost(new List<int>(4));
		}
		Int3 spawnPoint = IntMath.Transform(offset, entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityPositon.mPosition);
		SimEntity simEntity = SpawnProcessor.SpawnUnit(0L, spawnPoint, entityWithEntityID.entityPositon.mForward, Int3.up, RoleType.Puppet, 0, isLocalPlayer: false, configID, 0, MemberPosition.None);
		simEntity.entityBlackboard.var.mAttributeID = entityWithEntityID.entityBlackboard.var.mAttributeID;
		simEntity.AddEntityPuppet(entityID, 0, newMIsClose: false);
		entityWithEntityID.entityPuppetHost.mPuppets.Add(simEntity.creationIndex);
		return simEntity.creationIndex;
	}
}
