using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("接收重置实体事件", 0)]
[Category("Common/Entity")]
[Description("条件为0, 为None时, 表示不使用条件过滤")]
public class EntityResetEventNode : EventNode
{
	private ValueInput<bool> isRenderInput;

	private ValueInput<int> roleIDInput;

	private ValueInput<EntityResetReason> reasonInput;

	private FlowOutput output;

	private int entityID;

	private EntityResetReason entityResetReason;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		if (!isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<EntityResetEvent>(OnEntityResetEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<EntityResetEvent>(OnEntityResetEventRenderHandler);
		}
	}

	private void OnEntityResetEventRenderHandler(EntityResetEvent eventReceived)
	{
		int value = roleIDInput.value;
		if (value != 0)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				return;
			}
			NAgent agent = agentManager.GetAgent(eventReceived.entityID);
			if (agent == null || agent.AgentConfigID != value)
			{
				return;
			}
		}
		EntityResetReason value2 = reasonInput.value;
		if (value2 == EntityResetReason.None || value2 == eventReceived.reason)
		{
			entityID = eventReceived.entityID;
			entityResetReason = eventReceived.reason;
			Flow f = new Flow
			{
				returnData = returnData
			};
			output.Call(f);
		}
	}

	private void OnEntityResetEventHandler(EntityResetEvent eventReceived)
	{
		int value = roleIDInput.value;
		if (value != 0)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(eventReceived.entityID);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig || entityWithEntityID.entityConfig.mId != value)
			{
				return;
			}
		}
		EntityResetReason value2 = reasonInput.value;
		if (value2 == EntityResetReason.None || value2 == eventReceived.reason)
		{
			entityID = eventReceived.entityID;
			entityResetReason = eventReceived.reason;
			Flow f = new Flow
			{
				returnData = returnData
			};
			output.Call(f);
		}
	}

	protected override void RegisterPorts()
	{
		isRenderInput = AddValueInput<bool>("是否渲染");
		roleIDInput = AddValueInput<int>("实体类型ID");
		reasonInput = AddValueInput<EntityResetReason>("原因");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("原因", () => entityResetReason);
		output = AddFlowOutput("Out");
	}
}
