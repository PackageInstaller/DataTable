using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是本地玩家(逻辑)", 0)]
[Category("Logic/PosAndRot")]
[Description("判断传入的实体ID是否是本地玩家")]
public class IsLocalPlayer : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_true;

	private FlowOutput m_remotePlayer;

	private FlowOutput m_ai;

	private FlowOutput m_false;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_true = AddFlowOutput("本地玩家", "true");
		m_remotePlayer = AddFlowOutput("其他玩家", "remotePlayer");
		m_ai = AddFlowOutput("AI队友", "ai");
		m_false = AddFlowOutput("都不是", "false");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (m_entityIDInput.GetValue() == CommonProcessor.GetWorldState().mLocalPlayerID)
			{
				m_true.Call(f);
			}
			else
			{
				Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
				while (enumerator.MoveNext())
				{
					if (m_entityIDInput.GetValue() == enumerator.Current.Value.mEntityID)
					{
						if (CommonProcessor.IsMultiplePlayerGameMode(base.mSimContext))
						{
							m_remotePlayer.Call(f);
						}
						else
						{
							m_ai.Call(f);
						}
						return;
					}
				}
				m_false.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("本地玩家实体ID", "localPlayerEntityID", () => CommonProcessor.GetWorldState().mLocalPlayerID);
	}
}
