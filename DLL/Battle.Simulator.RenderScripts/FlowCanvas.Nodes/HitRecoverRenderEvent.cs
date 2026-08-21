using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("受击状态事件(渲染)", 0)]
[Category("Render/事件")]
[Description("受击状态事件")]
public class HitRecoverRenderEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

	private int _entityID;

	private E_HitRecoverStatus _hitRecoverStatus;

	private RoleType _camp;

	private bool _isLocalPlayer;

	private int _casterID;

	private bool _isLocalPlayerAttack;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		logicTickEventOutput = AddFlowOutput("输出");
		AddValueOutput("攻击者ID", () => _casterID);
		AddValueOutput("受击者ID：", () => _entityID);
		AddValueOutput("受击状态：", () => _hitRecoverStatus);
		AddValueOutput("阵营", () => _camp);
		AddValueOutput("是不是本地玩家受击", () => _isLocalPlayer);
		AddValueOutput("是不是本地玩家攻击", () => _isLocalPlayerAttack);
	}

	public override void OnGraphStarted()
	{
		base.mSimContext.SimToPresentationEventSystem.AddHandler<EntityHitRecoverStatusEvent>(OnHitRecoverStatusEventHandler);
	}

	public void OnHitRecoverStatusEventHandler(EntityHitRecoverStatusEvent hitRecoverEvent)
	{
		_entityID = hitRecoverEvent.mEntityID;
		_hitRecoverStatus = hitRecoverEvent.mHitRecoverStatus;
		AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		NAgent agent = agentManager.GetAgent(_entityID);
		_camp = (RoleType)agent.Camp;
		_isLocalPlayer = agentManager.mPlayerAgentID == _entityID;
		_casterID = (agent.Blackboard as BBHumanoid).m_NextSimFrameData.HitRecoverCasterID;
		_isLocalPlayerAttack = agentManager.mPlayerAgentID == _casterID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		logicTickEventOutput.Call(f);
	}
}
