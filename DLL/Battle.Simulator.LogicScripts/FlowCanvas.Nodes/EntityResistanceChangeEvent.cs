using System;
using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("控制抗性点数变更事件", 0)]
[Category("Logic/事件")]
[Description("控制抗性点数变更事件, 点数变更的时候触发, 抗性状态变更的时候不会发事件")]
public class EntityResistanceChangeEvent : EventNode
{
	private FlowOutput Output;

	private int entityID;

	private int newCount;

	private int oldCount;

	private int changeValue;

	private int reason;

	private List<int> elementsChanged = new List<int>();

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		Output = AddFlowOutput("out");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("旧点数", "oldCount", () => oldCount);
		AddValueOutput("新点数", "newCount", () => newCount);
		AddValueOutput("变化值", "changeValue", () => changeValue);
		AddValueOutput("变更原因", "原因", () => reason);
		AddValueOutput("变化属性详情", () => elementsChanged);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mResistanceChangeEvent = (Action<int, int, int, List<int>>)Delegate.Combine(simInterface.mResistanceChangeEvent, new Action<int, int, int, List<int>>(ResistanceChangeEventCallback));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mResistanceChangeEvent = (Action<int, int, int, List<int>>)Delegate.Remove(simInterface.mResistanceChangeEvent, new Action<int, int, int, List<int>>(ResistanceChangeEventCallback));
	}

	private void ResistanceChangeEventCallback(int entityID, int oldCount, int newCount, List<int> list)
	{
		this.entityID = entityID;
		this.oldCount = oldCount;
		this.newCount = newCount;
		changeValue = newCount - oldCount;
		reason = 0;
		elementsChanged.Clear();
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			Debug.LogError("实体为空");
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			elementsChanged.Add(list[i]);
		}
		if (entityWithEntityID.hasEntityResistance && entityWithEntityID.entityResistance.element != null)
		{
			reason = entityWithEntityID.entityResistance.enterReason;
		}
		Flow f = new Flow
		{
			returnData = returnData
		};
		Output.Call(f);
	}
}
