using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("场景加载事件", 0)]
[Category("Render/事件")]
[Description("场景加载事件, 在场景加载完成之后, 游戏开始之前触发, 可以用来缓存一些资源")]
public class BattleSceneLoadEvent : EventNode
{
	private FlowOutput output;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("");
	}

	public override void OnGraphStarted()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			battleScene.onBattleSceneLoad = (Action)Delegate.Combine(battleScene.onBattleSceneLoad, new Action(OnReceivedEventHandler));
		}
	}

	private void OnReceivedEventHandler()
	{
		Flow f = new Flow
		{
			returnData = mReturnData
		};
		output.Call(f);
	}
}
