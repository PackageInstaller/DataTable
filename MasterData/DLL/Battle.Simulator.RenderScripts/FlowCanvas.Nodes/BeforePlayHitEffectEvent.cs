using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("播放受击特效前处理(渲染+注意说明)", 0)]
[Category("Render/事件")]
[Description("触发于播放受击特效前.\n需要配合【修改受击特效(渲染+注意说明)】节点使用.\n【角色ID】为-1则不过滤.\n【传出的角色ID】为处理中角色ID.\n")]
public class BeforePlayHitEffectEvent : EventNode
{
	private ValueInput<int> m_roleIDVar;

	private int m_curRoleID;

	private int m_agentID;

	private string m_path;

	private bool m_isLockRotation;

	private FlowOutput flowOutput;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	protected override void RegisterPorts()
	{
		m_roleIDVar = AddValueInput<int>("实体类型ID(-1不过滤)", "BeforePlayHitEffectEvent_In_RoleID").SetDefaultAndSerializedValue(-1);
		AddValueOutput("实体类型ID(当前)", "BeforePlayHitEffectEvent_Out_RoleID", () => m_curRoleID);
		AddValueOutput("受击者AgentID", "BeforePlayHitEffectEvent_Out_AgentID", () => m_agentID);
		AddValueOutput("特效路径", "BeforePlayHitEffectEvent_Out_EffectPath", () => m_path);
		AddValueOutput("锁住旋转", "BeforePlayHitEffectEvent_Out_IsLockRotation", () => m_isLockRotation);
		flowOutput = AddFlowOutput("输出");
	}

	public override void OnGraphStarted()
	{
		AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		if (agentManager != null)
		{
			agentManager.BeforePlayHitEffect = (Action<PlayHitEffectData>)Delegate.Combine(agentManager.BeforePlayHitEffect, new Action<PlayHitEffectData>(OnReceivedEventHandler));
		}
	}

	private void OnReceivedEventHandler(PlayHitEffectData playHitEffectData)
	{
		NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(playHitEffectData.DefenseID);
		if (!(agent == null) && (m_roleIDVar.GetValue() == -1 || m_roleIDVar.GetValue() == agent.AgentConfigID))
		{
			m_curRoleID = agent.AgentConfigID;
			m_agentID = playHitEffectData.DefenseID;
			m_path = playHitEffectData.EffectPath;
			m_isLockRotation = playHitEffectData.IsLockRotaion;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			flowOutput.Call(f);
		}
	}
}
