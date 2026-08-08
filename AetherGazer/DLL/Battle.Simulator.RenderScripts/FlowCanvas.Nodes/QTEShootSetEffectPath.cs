using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置QTE射击特效", 0)]
[Category("Render/UI")]
[Description("设置QTE射击特效")]
public class QTEShootSetEffectPath : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> go = AddValueInput<GameObject>("射击按钮预制体");
		ValueInput<bool> StandbyOpenInput = AddValueInput<bool>("是否开启QTE可使用特效");
		ValueInput<string> StandbyEffectPathInput = AddValueInput<string>("待机特效");
		ValueInput<string> OutLockEffectPathInput = AddValueInput<string>("解锁特效");
		ValueInput<string> EffectPathInput = AddValueInput<string>("屏幕内特效");
		ValueInput<string> OutSideEffectPathInput = AddValueInput<string>("屏幕外特效");
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
					component.SetEffectPath(EffectPathInput.value, OutSideEffectPathInput.value, StandbyOpenInput.value, StandbyEffectPathInput.value, OutLockEffectPathInput.value);
					outPut.Call(f);
				}
			}
		});
	}
}
