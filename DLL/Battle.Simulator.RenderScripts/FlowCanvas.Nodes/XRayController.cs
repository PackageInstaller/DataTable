using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("透视控制器(全局,根据layer分层控制)", 0)]
[Category("Render/透视")]
[Description("全局,根据layer分层控制对应层的描边颜色和厚度(0-1),该控制器挂载在主控角色身上,stop为把颜色设置为透明+描边设置为0")]
public class XRayController : FlowNode
{
	private ColorOutlineControl control;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		FlowOutput stopOut = AddFlowOutput("stopOut");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<Color> OutLineColorInput = AddValueInput<Color>("OutLineColor");
		ValueInput<float> OutLineWidthInput = AddValueInput<float>("OutLineWidth");
		ValueInput<int> OutLineLayerInput = AddValueInput<int>("OutLineLayer");
		AddFlowInput("InitOrUpdate", delegate(Flow f)
		{
			if (control == null)
			{
				NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetPlayerAgent();
				if (playerAgent == null)
				{
					errorOut.Call(f);
					return;
				}
				control = U3DUtil.Get<ColorOutlineControl>(playerAgent.gameObject);
				if (control == null)
				{
					errorOut.Call(f);
					return;
				}
			}
			control.outlineColor = OutLineColorInput.value;
			control.outlineWidth = Math.Clamp(OutLineWidthInput.value, 0f, 1f);
			control.outlineLayer = Math.Clamp(OutLineLayerInput.value, 0, 3);
			output.Call(f);
		});
		AddFlowInput("Stop", delegate(Flow f)
		{
			if (control == null)
			{
				errorOut.Call(f);
			}
			else
			{
				control.outlineColor = Color.clear;
				control.outlineWidth = 0f;
				control.outlineLayer = Math.Clamp(OutLineLayerInput.value, 0, 3);
				stopOut.Call(f);
			}
		});
	}
}
