using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取当前最远玩家ID", 0)]
[Category("Logic/Spawn")]
[Description("获取当前最远玩家ID")]
public class GetFarestPlayerID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		int playerID = 0;
		AddValueOutput("结果ID", () => playerID);
		AddFlowInput("", delegate(Flow f)
		{
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			long num = long.MinValue;
			playerID = 0;
			_ = entityIDInput.value;
			while (enumerator.MoveNext())
			{
				int mEntityID = enumerator.Current.Value.mEntityID;
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID);
				if (entityWithEntityID != null && entityWithEntityID.hasEntityCamp && RoleCampProcessor.IsPlayer(entityWithEntityID.entityCamp.mRoleTypeCamp) && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mHP > 0)
				{
					long num2 = AIProcessor.GetDistanceBetweenEntities(entityIDInput.value, entityWithEntityID.creationIndex);
					if (num2 > num)
					{
						num = num2;
						playerID = entityWithEntityID.creationIndex;
					}
				}
			}
			if (playerID == 0)
			{
				f.Call(falseOut);
			}
			else
			{
				f.Call(trueOut);
			}
		});
	}
}
