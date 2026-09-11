using System;
using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("霸体值崩溃事件", 0)]
[Category("Logic/事件")]
[Description("架势崩溃事件, 实体类型ID填0, 表示所有角色都可以")]
public class PostureBreakEvent : EventNode
{
	private ValueInput<int> roleIDInput;

	private FlowOutput output;

	private int entityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		output = AddFlowOutput("");
		AddValueOutput("实体ID", () => entityID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mPostureBreakEvent = (Action<int>)Delegate.Combine(simInterface.mPostureBreakEvent, new Action<int>(OnPostureBreakEventHandle));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mPostureBreakEvent = (Action<int>)Delegate.Remove(simInterface.mPostureBreakEvent, new Action<int>(OnPostureBreakEventHandle));
	}

	private void OnPostureBreakEventHandle(int entityID)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || entityWithEntityID.entityBlackboard.var.mHP <= 0)
		{
			Debug.Log(entityID + " 已经死了");
			return;
		}
		int value = roleIDInput.value;
		if (value != 0)
		{
			if (entityWithEntityID.ENTITY_CONFIG_ID == value)
			{
				Flow f = new Flow
				{
					returnData = returnData
				};
				this.entityID = entityID;
				output.Call(f);
			}
		}
		else
		{
			Flow f2 = new Flow
			{
				returnData = returnData
			};
			this.entityID = entityID;
			output.Call(f2);
		}
	}
}
