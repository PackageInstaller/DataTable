using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("触发战斗暂停界面", 0)]
[Category("Render/UI")]
[Description("触发战斗暂停界面")]
public class BattlePauseUITriggerEvent : EventNode
{
	protected FlowOutput _output;

	protected BattleResultForLua _result;

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("OUT");
		AddValueOutput("result", () => _result);
	}

	public override void OnGraphStarted()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			battleScene.onShowPauseUI = (Action<BattleResultForLua>)Delegate.Combine(battleScene.onShowPauseUI, new Action<BattleResultForLua>(CallTrigger));
		}
		else
		{
			Debug.Log("不在战斗场景中，无法触发暂停界面");
		}
	}

	private void CallTrigger(BattleResultForLua result)
	{
		_result = result;
		Debug.Log("触发暂停界面: " + result);
		_output.Call(default(Flow));
	}
}
