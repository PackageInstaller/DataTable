using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置Animator变量", 0)]
[Category("Render/Anime")]
[Description("设置Animator变量")]
public class SetAnimatorValue : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		ValueInput<string> varNameInput = AddValueInput<string>("变量名");
		ValueInput<float> valueInput = AddValueInput<float>("值");
		ValueInput<float> timeInput = AddValueInput<float>("时长");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null)
			{
				Debug.LogError("设置Animator变量 " + agentIDInput.value + " 为空");
				output.Call(f);
			}
			else
			{
				Animator animator = agent.Animator;
				if (animator == null)
				{
					Debug.LogError("设置Animator变量 " + agentIDInput.value + " animator 为空");
					output.Call(f);
				}
				else
				{
					animator.SetFloat(varNameInput.value, valueInput.value, timeInput.value, Time.deltaTime);
					output.Call(f);
				}
			}
		});
	}
}
