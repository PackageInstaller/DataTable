using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置玩家位置和朝向", 0)]
[Category("Logic/PosAndRot")]
[Description("设置实体位置和朝向,传进来的是一个列表")]
public class SetPlayersPositionAndForward : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<Int3>> spawnPoints = AddValueInput<List<Int3>>("位置");
		ValueInput<List<Int3>> spawnForward = AddValueInput<List<Int3>>("朝向");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
			_ = spawnPoints.value;
			_ = spawnForward.value;
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				int mEntityID = enumerator.Current.Value.mEntityID;
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID);
				if (entityWithEntityID != null)
				{
					if (entityWithEntityID.hasEntityPositon)
					{
						entityWithEntityID.entityPositon.mPosition = spawnPoints.value[(int)enumerator.Current.Key];
						entityWithEntityID.entityPositon.mForward = spawnForward.value[(int)enumerator.Current.Key];
					}
					SimShapeProcessor.UpdateShapeWorldPosition(entityWithEntityID);
				}
			}
			output.Call(f);
		});
	}
}
