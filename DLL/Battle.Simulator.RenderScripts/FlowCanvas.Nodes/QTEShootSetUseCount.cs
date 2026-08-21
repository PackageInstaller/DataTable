using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置QTE射击次数", 0)]
[Category("Render/UI")]
[Description("设置QTE射击特效")]
public class QTEShootSetUseCount : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> go = AddValueInput<GameObject>("射击按钮预制体");
		ValueInput<bool> CanUseOpenInput = AddValueInput<bool>("是否显示可使用次数");
		ValueInput<int> UseCountInput = AddValueInput<int>("可使用次数");
		FlowOutput outPut = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			if (NScene.GetCurrentScene() as BattleScene == null || go.value == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				QTEShootScript component = go.value.GetComponent<QTEShootScript>();
				if (component == null)
				{
					errorOutput.Call(f);
				}
				else
				{
					component.SetUseCount(CanUseOpenInput.value, UseCountInput.value);
					outPut.Call(f);
				}
			}
		});
	}
}
