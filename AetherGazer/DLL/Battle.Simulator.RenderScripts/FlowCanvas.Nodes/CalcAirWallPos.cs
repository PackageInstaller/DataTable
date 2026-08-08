using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("计算空气墙位置", 0)]
[Category("Render/Asset")]
[Description("根据角色位置和空气墙宽度计算空气墙那个面片应该出现的位置")]
public class CalcAirWallPos : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> airWallPos = AddValueInput<Int3>("空气墙位置");
		ValueInput<Int3> airWallForward = AddValueInput<Int3>("空气墙朝向");
		ValueInput<Int3> airWallSize = AddValueInput<Int3>("空气墙大小");
		Int3 position = Int3.zero;
		Int3 forward = Int3.zero;
		AddValueOutput("位置", () => position);
		AddValueOutput("朝向", () => forward);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			Int3 @int;
			try
			{
				int mPlayerAgentID = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().mPlayerAgentID;
				@int = (Int3)(NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(mPlayerAgentID).Position;
			}
			catch (Exception)
			{
				Debug.Log("找不到玩家位置, 返回0");
				@int = Int3.zero;
			}
			if (Int3.DotXZLong(@int - airWallPos.value, airWallForward.value) > 0)
			{
				forward = -airWallForward.value;
				Int3 int2 = forward;
				position = airWallPos.value - int2.NormalizeTo(airWallSize.value.z / 2 - 750);
			}
			else
			{
				forward = airWallForward.value;
				Int3 int3 = forward;
				position = airWallPos.value - int3.NormalizeTo(airWallSize.value.z / 2 - 750);
			}
			output.Call(f);
		});
	}
}
