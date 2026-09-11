using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放UI特效(自动回收)(过时)", 0)]
[Category("Render/特效")]
[Description("创建特效,节点填写路径\n例如:Asset/ABResources/Effect/Scene/fx_chuchang_01,只要使用:Effect/Scene/fx_chuchang_01\n时长单位:秒\n这个会直接出生在parent下面")]
public class PlayUIEffectInstantiateInParent : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<string> effectPathVar = AddValueInput<string>("特效路径");
		AddValueInput<float>("持续时长(秒)");
		GameObject effect = null;
		AddValueOutput("特效", () => effect);
		AddFlowInput("", delegate(Flow f)
		{
			GameObject gameObject = GameObject.Find("UICamera/Canvas/UIMain/BattleUIEffectPanel");
			effect = Asset.InstantiateWithoutCache(effectPathVar.GetValue(), gameObject.transform);
			f.Call(output);
		});
	}
}
