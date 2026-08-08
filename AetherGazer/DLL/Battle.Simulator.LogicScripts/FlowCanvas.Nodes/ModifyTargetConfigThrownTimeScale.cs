using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改抛掷物时间缩放(TimelineID)", 0)]
[Category("Logic/抛掷物")]
[Description("修改当前场上存在的对应【timelineID】的子弹的时间缩放")]
public class ModifyTargetConfigThrownTimeScale : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> timelineIDInput = AddValueInput<int>("TimelineID");
		ValueInput<int> timeScaleInput = AddValueInput<int>("时间缩放");
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("", delegate(Flow f)
		{
			List<ThrownState> mThrowns = CommonProcessor.GetWorldState().mThrowns;
			int value = timelineIDInput.value;
			int value2 = timeScaleInput.value;
			for (int num = mThrowns.Count - 1; num >= 0; num--)
			{
				if (mThrowns[num].mAbilityID == value)
				{
					mThrowns[num].mTimeScale = value2;
				}
			}
			output.Call(f);
		});
	}
}
