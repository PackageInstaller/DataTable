using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取当前玩家AgentID(pure)", 0)]
[Category("Render/Agent")]
[Description("获取当前玩家ID")]
public class GetPlayerAgentIDPure : PureFunctionNode<int>
{
	public override int Invoke()
	{
		try
		{
			return (NScene.GetCurrentScene() as BattleScene).GetAgentManager().mPlayerAgentID;
		}
		catch (Exception)
		{
			Debug.Log("获取当前玩家AgentID 失败");
			return 0;
		}
	}
}
