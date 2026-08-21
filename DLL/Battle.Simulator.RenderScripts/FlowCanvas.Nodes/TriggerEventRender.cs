using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("触发器事件(渲染)", 0)]
[Category("Render/事件")]
[Description("当触发器激活,更新,禁用的时候触发")]
public class TriggerEventRender : EventNode
{
	private FlowOutput enableOutput;

	private FlowOutput disableOutput;

	private FlowOutput updateOutput;

	private int triggerID;

	private new string graphName = string.Empty;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	protected override void RegisterPorts()
	{
		enableOutput = AddFlowOutput("激活");
		updateOutput = AddFlowOutput("更新");
		disableOutput = AddFlowOutput("禁用");
		AddValueOutput("触发器ID", () => triggerID);
	}

	public override void OnGraphStarted()
	{
		graphName = base.graph.name;
		MapTriggerManager mapTriggerManager = (NScene.GetCurrentScene() as BattleScene).GetMapTriggerManager();
		mapTriggerManager.onTriggerEnableHandler = (OnVoidHandler<int, ProtoEntityData>)Delegate.Combine(mapTriggerManager.onTriggerEnableHandler, new OnVoidHandler<int, ProtoEntityData>(OnTriggerEnableHandler));
		mapTriggerManager.onTriggerUpdateHandler = (OnVoidHandler<int, ProtoEntityData>)Delegate.Combine(mapTriggerManager.onTriggerUpdateHandler, new OnVoidHandler<int, ProtoEntityData>(OnTriggerUpdateHandler));
		mapTriggerManager.onTriggerDisableHandler = (OnVoidHandler<int, ProtoEntityData>)Delegate.Combine(mapTriggerManager.onTriggerDisableHandler, new OnVoidHandler<int, ProtoEntityData>(OnTriggerDisableHandler));
	}

	private void OnTriggerDisableHandler(int triggerID, ProtoEntityData data)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (!(battleScene == null) && battleScene.GetTriggerTypes(triggerID).Contains(graphName))
		{
			this.triggerID = triggerID;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			disableOutput.Call(f);
		}
	}

	private void OnTriggerUpdateHandler(int triggerID, ProtoEntityData data)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (!(battleScene == null) && battleScene.GetTriggerTypes(triggerID).Contains(graphName))
		{
			this.triggerID = triggerID;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			updateOutput.Call(f);
		}
	}

	private void OnTriggerEnableHandler(int triggerID, ProtoEntityData data)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (!(battleScene == null) && battleScene.GetTriggerTypes(triggerID).Contains(graphName))
		{
			this.triggerID = triggerID;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			enableOutput.Call(f);
		}
	}
}
