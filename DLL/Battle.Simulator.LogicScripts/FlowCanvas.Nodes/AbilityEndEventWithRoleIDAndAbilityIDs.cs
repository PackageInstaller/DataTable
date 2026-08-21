using System;
using System.Collections.Generic;
using Config;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能结束事件(技能后三位ID组)", 0)]
[Category("Logic/事件")]
[Description("当技能结束事件时触发,被Ability中断也会触发,且此时已经完成了打断事件;\n如果不是被技能中断,或者衔接的行为是移动、待机、受击等渲染层行为,新的abilityID就输出0;")]
public class AbilityEndEventWithRoleIDAndAbilityIDs : EventNode
{
	private FlowOutput m_output;

	private FlowOutput m_error;

	private Stack<Flow.ReturnData> m_returnData = new Stack<Flow.ReturnData>(16);

	private ValueInput<int> _roleIDInput;

	[Name("ID组(后三位)", 0)]
	public List<int> m_actionIDs = new List<int>();

	private int m_entityID;

	private int m_oldAbilityID;

	private int m_newAbilityID;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<List<int>>().Serialize(ref writer, m_actionIDs, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		m_actionIDs = options.Resolver.GetFormatterWithVerify<List<int>>().Deserialize(ref reader, options);
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityFinishLogicEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mAbilityFinishLogicEvent, new Action<int, int, int>(OnAbilityFinishEventHandler));
	}

	public void OnAbilityFinishEventHandler(int entityID, int oldAbilityID, int newAbilityID)
	{
		int item = oldAbilityID % 1000;
		if (m_actionIDs.Contains(item))
		{
			Flow f = new Flow
			{
				returnData = m_returnData
			};
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null)
			{
				m_error.Call(f);
			}
			else if ((entityWithEntityID.entityConfig.mConfig as RoleConfig).ID == _roleIDInput.value)
			{
				m_entityID = entityID;
				m_oldAbilityID = oldAbilityID;
				m_newAbilityID = newAbilityID;
				m_output.Call(f);
			}
		}
	}

	protected override void RegisterPorts()
	{
		_roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		m_output = AddFlowOutput("Out");
		m_error = AddFlowOutput("Error", "error");
		AddValueOutput("实体ID:", () => m_entityID);
		AddValueOutput("结束的技能ID:", () => m_oldAbilityID);
		AddValueOutput("新的技能ID:", () => m_newAbilityID);
	}
}
