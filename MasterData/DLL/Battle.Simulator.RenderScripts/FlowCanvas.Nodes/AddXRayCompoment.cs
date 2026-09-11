using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("给实体添加或删除透视组件", 0)]
[Category("Render/透视")]
[Description("给实体添加或删除透视组件(本质是禁用不移除),layer范围为[0,3]")]
public class AddXRayCompoment : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<int> entityIDInput = AddValueInput<int>("entityID");
		ValueInput<int> layerInput = AddValueInput<int>("layer");
		ValueInput<bool> isEnable = AddValueInput<bool>("启用");
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(entityIDInput.value);
			if (agent == null)
			{
				errorOut.Call(f);
			}
			else
			{
				ColorOutline colorOutline = U3DUtil.Get<ColorOutline>(agent.gameObject);
				colorOutline.enabled = isEnable.value;
				colorOutline.rendererLayer = Math.Clamp(layerInput.value, 0, 3);
				output.Call(f);
			}
		});
	}
}
