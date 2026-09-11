using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置QTE射击按钮目标阵营", 0)]
[Category("Render/UI")]
[Description("设置射击选择目标的阵营")]
public class QTEShootSelectCamp : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<TargetCampType> campInput = AddValueInput<TargetCampType>("目标阵营");
		ValueInput<GameObject> go = AddValueInput<GameObject>("射击按钮预制体");
		FlowOutput outPut = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			if (go.value == null)
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
					component.targetCamp = campInput.value;
					outPut.Call(f);
				}
			}
		});
	}
}
