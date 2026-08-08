using System;
using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修正值崩溃事件", 0)]
[Category("Logic/事件")]
[Description("修正值事件, 实体类型ID填0, 表示所有角色都可以")]
public class ExposedValueBreakEvent : EventNode
{
	private ValueInput<int> m_roleIDInput;

	private FlowOutput m_output;

	private int m_entityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		m_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		m_output = AddFlowOutput("Out", "output");
		AddValueOutput("实体ID", "entityID", () => m_entityID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mExposedValueBreakEvent = (Action<int>)Delegate.Combine(simInterface.mExposedValueBreakEvent, new Action<int>(OnExposedValueBreakEventHandler));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mExposedValueBreakEvent = (Action<int>)Delegate.Remove(simInterface.mExposedValueBreakEvent, new Action<int>(OnExposedValueBreakEventHandler));
	}

	private void OnExposedValueBreakEventHandler(int entityID)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || entityWithEntityID.entityBlackboard.var.mHP <= 0)
		{
			Debug.Log(entityID + " 已经死了");
			return;
		}
		int value = m_roleIDInput.value;
		if (value != 0)
		{
			if (entityWithEntityID.ENTITY_CONFIG_ID == value)
			{
				Flow f = new Flow
				{
					returnData = returnData
				};
				m_entityID = entityID;
				m_output.Call(f);
			}
		}
		else
		{
			Flow f2 = new Flow
			{
				returnData = returnData
			};
			m_entityID = entityID;
			m_output.Call(f2);
		}
	}
}
