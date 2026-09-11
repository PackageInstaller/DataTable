using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("破防事件", 0)]
[Category("Common/事件")]
[Description("破防事件, 角色ID为0表示没有过滤条件")]
public class EntityBreakEventNode : EventNode
{
	private ValueInput<bool> _isRenderInput;

	private ValueInput<int> _roleIDInput;

	private FlowOutput breakOutput;

	private FlowOutput breakEndOutput;

	private FlowOutput cdEndOutput;

	private int _entityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_isRenderInput = AddValueInput<bool>("是否渲染");
		AddValueOutput("实体ID", () => _entityID);
		_roleIDInput = AddValueInput<int>("实体类型ID");
		breakOutput = AddFlowOutput("开始崩溃");
		breakEndOutput = AddFlowOutput("崩溃结束");
		cdEndOutput = AddFlowOutput("cd结束");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.GetValue())
		{
			base.mSimContext.SimEventSystem.AddHandler<EntityBreakEvent>(OnEventHandler);
		}
		else if (base.mSimContext.SimToPresentationEventSystem != null)
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<EntityBreakEvent>(OnRenderEventHandler);
		}
	}

	private void OnRenderEventHandler(EntityBreakEvent eventReceived)
	{
		if (_roleIDInput.value != 0)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				return;
			}
			NAgent agent = agentManager.GetAgent(eventReceived.entityID);
			if (agent == null || _roleIDInput.value != agent.AgentConfigID)
			{
				return;
			}
		}
		_entityID = eventReceived.entityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		if (eventReceived.state == BreakState.breakState)
		{
			breakOutput.Call(f);
		}
		if (eventReceived.state == BreakState.breakCDState)
		{
			breakEndOutput.Call(f);
		}
		if (eventReceived.state == BreakState.delay)
		{
			cdEndOutput.Call(f);
		}
	}

	private void OnEventHandler(EntityBreakEvent eventReceived)
	{
		if (_roleIDInput.value != 0)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(eventReceived.entityID);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig || _roleIDInput.value != entityWithEntityID.entityConfig.mId)
			{
				return;
			}
		}
		_entityID = eventReceived.entityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		if (eventReceived.state == BreakState.breakState)
		{
			breakOutput.Call(f);
		}
		if (eventReceived.state == BreakState.breakCDState)
		{
			breakEndOutput.Call(f);
		}
		if (eventReceived.state == BreakState.delay)
		{
			cdEndOutput.Call(f);
		}
	}
}
