using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("存活的玩家数量(AI不算)", 0)]
[Category("Logic/Spawn")]
[Description("获取存活的玩家数量")]
public class AlivePlayerNumber : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> flagInput = AddValueInput<bool>("血量为0算存活").SetDefaultAndSerializedValue(v: false);
		AddValueOutput("数量", delegate
		{
			int num = 0;
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
				if (entityWithEntityID != null && (entityWithEntityID.entityBlackboard.var.mHP > 0 || flagInput.value) && !entityWithEntityID.hasEntityAIThink)
				{
					num++;
				}
			}
			return num;
		});
	}
}
