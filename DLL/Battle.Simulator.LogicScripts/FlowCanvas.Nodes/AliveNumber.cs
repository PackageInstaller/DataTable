using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("存活的玩家数量", 0)]
[Category("Logic/Spawn")]
[Description("获取存活的玩家数量")]
public class AliveNumber : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("数量", delegate
		{
			int num = 0;
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
				if (entityWithEntityID != null && entityWithEntityID.entityBlackboard.var.mHP > 0)
				{
					num++;
				}
			}
			return num;
		});
	}
}
