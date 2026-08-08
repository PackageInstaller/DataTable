using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建特效(UI上,自动回收)(过时)", 0)]
[Category("Render/特效")]
[Description("创建特效,节点填写路径\n例如:Asset/ABResources/Effect/Scene/fx_chuchang_01,只要使用:Effect/Scene/fx_chuchang_01\n时长单位:秒")]
public class PlayUIEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		FlowOutput abnormalOutput = AddFlowOutput("异常");
		ValueInput<string> effectPathVar = AddValueInput<string>("特效路径");
		ValueInput<float> timeVar = AddValueInput<float>("持续时长(秒)");
		GameObject effect = null;
		AddFlowInput("In", delegate(Flow f)
		{
			GameObject gameObject = GameObject.Find("UICamera/Canvas/UIMain/BattleUIEffectPanel");
			if (gameObject == null)
			{
				Debug.Log("====>>>> 找不到");
				abnormalOutput.Call(f);
			}
			else
			{
				EffectController effectController = CommonEffectClipPlayer.PlayEffect(gameObject.transform, effectPathVar.GetValue(), string.Empty, Vector3.zero, Vector3.one, Vector3.zero, Vector3.forward, isAttach: true, isLoop: false, 1f, 0f, timeVar.GetValue());
				if (effectController != null)
				{
					effect = effectController.gameObject;
				}
				output.Call(f);
			}
		});
		AddValueOutput("特效", () => effect);
	}
}
