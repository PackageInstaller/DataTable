using System;
using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("动画事件执行事件(渲染)", 0)]
[Category("Render/事件")]
[Description("动画上配置了【CustomAnimationEvent】时会触发的事件")]
public class CustomAnimationEvent : EventNode
{
	private int _agentID;

	private float _floatValue;

	private int _intValue;

	private string _stringValue;

	private FlowOutput _output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		if (!(NScene.GetCurrentScene() as BattleScene == null))
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager != null)
			{
				agentManager.OnCustomAnimationEvent = (Action<int, AnimationEvent>)Delegate.Combine(agentManager.OnCustomAnimationEvent, new Action<int, AnimationEvent>(FuncHandler));
			}
		}
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (!(NScene.GetCurrentScene() as BattleScene == null))
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager != null)
			{
				agentManager.OnCustomAnimationEvent = (Action<int, AnimationEvent>)Delegate.Remove(agentManager.OnCustomAnimationEvent, new Action<int, AnimationEvent>(FuncHandler));
			}
		}
	}

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("Out", "output");
		AddValueOutput("实体ID", "agentID", () => _agentID);
		AddValueOutput("float值", "floatValue", () => _floatValue);
		AddValueOutput("int值", "intValue", () => _intValue);
		AddValueOutput("string值", "stringValue", () => _stringValue);
	}

	public void FuncHandler(int pAgentID, AnimationEvent pAnimationEvent)
	{
		_agentID = pAgentID;
		_floatValue = pAnimationEvent.floatParameter;
		_intValue = pAnimationEvent.intParameter;
		_stringValue = pAnimationEvent.stringParameter;
		Flow f = new Flow
		{
			returnData = returnData
		};
		_output.Call(f);
	}
}
