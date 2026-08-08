using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas;

[Name("设置特效时间缩放比例", 0)]
[Category("Render/Control")]
[Description("挂载特效，使用速度百分比来改变特效的播放速度")]
public class SetEffectTimeScale : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> effectNameInput = AddValueInput<GameObject>("特效名称", "effectName");
		ValueInput<float> timeScale = AddValueInput<float>("时间缩放比例(百分数)", "speedPercent");
		FlowOutput trueOutput = AddFlowOutput("Out", "out");
		FlowOutput errorOutput = AddFlowOutput("Error", "error");
		AddFlowInput("In", "in", delegate(Flow f)
		{
			GameObject value = effectNameInput.value;
			EffectController component;
			if (value == null)
			{
				Debug.LogError("节点： 设置特效时间缩放比例 ===> 找不到特效Go ");
				errorOutput.Call(f);
			}
			else if (value.TryGetComponent<EffectController>(out component))
			{
				component.SetTimeScale(timeScale.value / 100f);
				trueOutput.Call(f);
			}
			else
			{
				errorOutput.Call(f);
			}
		});
	}
}
