using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("渲染挂件执行操作码", 0)]
[Category("Render/事件")]
[Description("渲染层挂件接收到推送过来的操作码执行的事件")]
public class Agent2PendantCmdHandler : EventNode
{
	private FlowOutput mOut;

	private int m_agentID;

	private int m_pendantID;

	private RenderPendant m_ghost;

	private int m_code;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	public override void OnGraphStarted()
	{
		RenderPendant.AgentPushCommandToGhost = (Action<int, int>)Delegate.Combine(RenderPendant.AgentPushCommandToGhost, new Action<int, int>(EventHandler));
	}

	public override void OnGraphStoped()
	{
		m_ghost = null;
		if (RenderPendant.AgentPushCommandToGhost != null)
		{
			RenderPendant.AgentPushCommandToGhost = (Action<int, int>)Delegate.Remove(RenderPendant.AgentPushCommandToGhost, new Action<int, int>(EventHandler));
		}
	}

	protected override void RegisterPorts()
	{
		mOut = AddFlowOutput("Out", "output");
		AddValueOutput("实体ID", "AgentID", () => m_agentID);
		AddValueOutput("渲染挂件索引", "pendantID", () => m_pendantID);
		AddValueOutput("渲染挂件", "ghost", () => m_ghost);
		AddValueOutput("操作码", "code", () => m_code);
	}

	private void EventHandler(int agentID, int code)
	{
		NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID);
		if (!(agent != null))
		{
			return;
		}
		m_agentID = agentID;
		m_code = code;
		Flow f = new Flow
		{
			returnData = mReturnData
		};
		mOut.Call(f);
		List<IPendant>.Enumerator enumerator = agent.gameObject.GetComponent<ComponentPendant>().GetPendants().GetEnumerator();
		while (enumerator.MoveNext())
		{
			m_ghost = enumerator.Current as RenderPendant;
			if (m_ghost != null)
			{
				m_pendantID = m_ghost.PendantID;
				mOut.Call(f);
			}
		}
	}
}
