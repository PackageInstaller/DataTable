using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("是否启用空气墙", 0)]
[Category("Logic/Trigger")]
[Description("启用空气墙")]
public class EnableAirwall : CallableActionNode<int, bool>
{
	public override void Invoke(int entityID, bool isEnable)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		SimEntity entityWithEntityID2 = base.parentNode.mSimContext.GetEntityWithEntityID(SpawnProcessor.GetLocalPlayerID());
		if (!isEnable)
		{
			RecastGraphProcessor.DisableRecastGraphCut(base.parentNode.mSimContext, entityWithEntityID);
		}
		else if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
		{
			RecastGraphProcessor.RecastGraphCut(base.parentNode.mSimContext, entityWithEntityID, entityWithEntityID.entityShape.mShape as SimBox);
		}
		if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
		{
			entityWithEntityID.entityShape.mWeight = (isEnable ? int.MaxValue : (-1));
			entityWithEntityID.entityShape.mShape.IsEnable = isEnable;
			AirWallEnableEvent airWallEnableEvent = AirWallEnableEvent.Claim();
			airWallEnableEvent.pos = entityWithEntityID.entityPositon.mPosition;
			airWallEnableEvent.playerPos = entityWithEntityID2.entityPositon.mPosition;
			airWallEnableEvent.id = entityID;
			airWallEnableEvent.enable = isEnable;
			airWallEnableEvent.forward = entityWithEntityID.entityPositon.mForward;
			base.parentNode.mSimContext.PostEvent(airWallEnableEvent);
		}
		else
		{
			Debug.Log("无效的空气墙" + entityID);
			XLogger.Debug("无效的空气墙" + entityID);
		}
	}
}
