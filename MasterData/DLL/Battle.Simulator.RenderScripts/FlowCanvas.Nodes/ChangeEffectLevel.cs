using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("改变特效等级", 0)]
[Category("Render/函数")]
[Description("修改传入的特效的显示等级,需要预先配置好 EffectGoLevel 组件;\n特效参数为持有 EffectGoLevel 的 GameObject")]
public class ChangeEffectLevel : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<GameObject> effectVar = AddValueInput<GameObject>("特效");
		ValueInput<int> effectLevelVar = AddValueInput<int>("特效等级");
		AddFlowInput("In", delegate(Flow f)
		{
			EffectGoLevel component = effectVar.value.GetComponent<EffectGoLevel>();
			if (component != null)
			{
				component.PlayLevel(effectLevelVar.value);
			}
			output.Call(f);
		});
	}
}
