using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("随机点名玩家(排除AI)", 0)]
[Category("Logic/Entity")]
[Description("随机点名一个玩家,不包括ai;\n单机模式下都是操作者,联机模式下随机返回一位玩家")]
public class RandomSelectPlayerWithoutAI : FlowControlNode
{
	private FlowOutput m_out;

	private int m_playerEntityID;

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			m_playerEntityID = 0;
			if (CommonProcessor.IsMultiplePlayerGameMode(base.mSimContext))
			{
				Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
				Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
				int num = 0;
				while (enumerator.MoveNext())
				{
					SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
					if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mHP > 0)
					{
						num++;
					}
				}
				if (num == 0)
				{
					errorOut.Call(f);
					return;
				}
				uint num2 = DRandom.Random((uint)num);
				enumerator = mRoomMembers.GetEnumerator();
				num = 0;
				while (enumerator.MoveNext())
				{
					SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
					if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityBlackboard && entityWithEntityID2.entityBlackboard.var.mHP > 0)
					{
						if (num == num2)
						{
							m_playerEntityID = enumerator.Current.Value.mEntityID;
							break;
						}
						num++;
					}
				}
			}
			else
			{
				m_playerEntityID = base.mSimContext.sEntityWorldState.status.mLocalPlayerID;
				if (m_playerEntityID == 0)
				{
					Dictionary<MemberPosition, RemoteMember> mRoomMembers2 = CommonProcessor.GetWorldState().mRoomMembers;
					RemoteMember value = null;
					if (mRoomMembers2.TryGetValue(MemberPosition.First, out value))
					{
						m_playerEntityID = value.mEntityID;
					}
				}
			}
			m_out.Call(f);
		});
		AddValueOutput("实体ID", "entityID", () => m_playerEntityID);
	}
}
