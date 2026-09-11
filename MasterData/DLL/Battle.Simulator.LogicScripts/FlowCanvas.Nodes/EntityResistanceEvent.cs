using System;
using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("控制抗性事件", 0)]
[Category("Logic/事件")]
[Description("控制抗性事件, 开始免控和停止的时候触发")]
public class EntityResistanceEvent : EventNode
{
	private FlowOutput startOut;

	private FlowOutput endOut;

	private int entityID;

	private int element;

	private List<int> elements = new List<int>();

	private int reason;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		startOut = AddFlowOutput("开始");
		endOut = AddFlowOutput("结束");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("属性", () => element);
		AddValueOutput("点数属性详情", () => elements);
		AddValueOutput("开始/结束原因", "原因", () => reason);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mResistanceEvent = (Action<int, bool>)Delegate.Combine(simInterface.mResistanceEvent, new Action<int, bool>(ResistanceEventCallback));
	}

	private void ResistanceEventCallback(int entityID, bool reState)
	{
		this.entityID = entityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			Debug.LogError("实体为空");
		}
		else if (reState)
		{
			elements.Clear();
			if (entityWithEntityID.hasEntityResistance)
			{
				if (entityWithEntityID.entityResistance.element != null)
				{
					for (int i = 0; i < entityWithEntityID.entityResistance.maxValue && i < entityWithEntityID.entityResistance.element.Count; i++)
					{
						elements.Add(entityWithEntityID.entityResistance.element[i]);
					}
				}
				element = entityWithEntityID.entityResistance.reStateEle;
				reason = entityWithEntityID.entityResistance.enterReason;
			}
			startOut.Call(f);
		}
		else
		{
			elements.Clear();
			if (entityWithEntityID.hasEntityResistance)
			{
				element = entityWithEntityID.entityResistance.reStateEle;
				reason = entityWithEntityID.entityResistance.exitReason;
			}
			endOut.Call(f);
		}
	}
}
