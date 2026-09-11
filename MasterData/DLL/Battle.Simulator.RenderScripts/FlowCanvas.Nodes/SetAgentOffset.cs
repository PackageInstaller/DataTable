using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置实体渲染Transform参数", 0)]
[Category("Render/Agent")]
[Description("设置实体渲染Transform参数")]
public class SetAgentOffset : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => agentIDInput.value);
		ValueInput<bool> additivePosInput = AddValueInput<bool>("偏移是否为叠加").SetDefaultAndSerializedValue(v: true);
		ValueInput<Vector3> posInput = AddValueInput<Vector3>("偏移量");
		ValueInput<bool> additiveFwdInput = AddValueInput<bool>("旋转是否为叠加").SetDefaultAndSerializedValue(v: true);
		ValueInput<Vector3> rotateInput = AddValueInput<Vector3>("旋转量");
		ValueInput<bool> additiveScaleInput = AddValueInput<bool>("缩放是否为叠加").SetDefaultAndSerializedValue(v: true);
		ValueInput<Vector3> scaleInput = AddValueInput<Vector3>("缩放量");
		AddFlowInput("设置", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null || agent.Blackboard == null)
			{
				errorOut.Call(f);
			}
			else
			{
				if (!additivePosInput.value)
				{
					agent.Blackboard.DeltaPosition = posInput.value;
				}
				else
				{
					agent.Blackboard.DeltaPosition += posInput.value;
				}
				if (!additiveFwdInput.value)
				{
					agent.Blackboard.DeltaRotate = rotateInput.value;
				}
				else
				{
					agent.Blackboard.DeltaRotate += rotateInput.value;
				}
				if (!additiveScaleInput.value)
				{
					agent.transform.localScale = Vector3.one + scaleInput.value;
				}
				else
				{
					agent.transform.localScale += scaleInput.value;
				}
				output.Call(f);
			}
		});
		AddFlowInput("重置偏移", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null || agent.Blackboard == null)
			{
				errorOut.Call(f);
			}
			else
			{
				agent.Blackboard.DeltaPosition = Vector3.zero;
				agent.Blackboard.OverrideWithDeltaPosition = false;
				output.Call(f);
			}
		});
		AddFlowInput("重置旋转", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null || agent.Blackboard == null)
			{
				errorOut.Call(f);
			}
			else
			{
				agent.Blackboard.DeltaRotate = Vector3.zero;
				agent.Blackboard.OverrideWithDeltaRotate = false;
				output.Call(f);
			}
		});
		AddFlowInput("重置缩放", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null || agent.Blackboard == null)
			{
				errorOut.Call(f);
			}
			else
			{
				agent.transform.localScale = Vector3.one;
				output.Call(f);
			}
		});
	}
}
