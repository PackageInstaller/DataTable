using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("添加水面漂浮脚本(渲染)", 0)]
[Category("Render/Agent")]
[Description("注意,该节点会给实体的第一个子object添加WaterFloaterControl脚本")]
public class SaillingWaterFloater : FlowNode
{
	private FlowOutput _Output;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_Output = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		ValueInput<int> agentIDInput = AddValueInput<int>("agentID");
		ValueInput<float> timeDelayInput = AddValueInput<float>("TimeDelay");
		ValueInput<float> yOffsetInput = AddValueInput<float>("YOffset");
		ValueInput<float> verticalScaleInput = AddValueInput<float>("VerticalScale").SetDefaultAndSerializedValue(1f);
		ValueInput<bool> shakeEnableInput = AddValueInput<bool>("ShakeEnable");
		ValueInput<float> shakeScaleInput = AddValueInput<float>("ShakeScale").SetDefaultAndSerializedValue(1f);
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null)
			{
				Debug.LogError("输入实体不存在");
				_Error.Call(f);
			}
			else
			{
				WaterFloaterControl waterFloaterControl = U3DUtil.Get<WaterFloaterControl>(agent.gameObject);
				WaterFloaterManager componentInChildren = (NScene.GetCurrentScene() as BattleScene).sceneSetting.gameObject.GetComponentInChildren<WaterFloaterManager>();
				if (componentInChildren == null)
				{
					Debug.LogError("场景内没有WaterFloaterManager的预制体");
					_Error.Call(f);
				}
				else
				{
					waterFloaterControl.Init(componentInChildren.transform);
					waterFloaterControl.timeDelay = timeDelayInput.value;
					waterFloaterControl.yOffset = yOffsetInput.value;
					waterFloaterControl.verticalScale = ((verticalScaleInput.value < 0f) ? 0f : verticalScaleInput.value);
					waterFloaterControl.shakeEnable = shakeEnableInput.value;
					waterFloaterControl.shakeScale = ((shakeScaleInput.value < 0f) ? 0f : shakeScaleInput.value);
					_Output.Call(f);
				}
			}
		});
	}
}
