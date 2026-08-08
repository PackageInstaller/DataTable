using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI闪避指令", 0)]
[Category("Logic/AI")]
[Description("AI闪避指令")]
public class AIAvoidAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<bool> isSingleClick = AddValueInput<bool>("是否单次点击", "isSingleClick").SetDefaultAndSerializedValue(v: false);
		ValueInput<int> avoidBackProbability = AddValueInput<int>("非移动闪避概率(百分比)", "avoidBackProbability").SetDefaultAndSerializedValue(0);
		AddValueOutput("指令ID", () => actionID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (((SimEntity)f.userData).entityAIThink.mAICommandSet.TryGetValue(commandSetID.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				if (aICommandSet.mCommands == null)
				{
					aICommandSet.mCommands = new List<AICommand>();
				}
				aICommandSet.mCommands.Add(new AIAvoidCommand
				{
					mParent = aICommandSet,
					mID = actionID.value,
					mTimeout = timeout.value,
					mIsSingleClick = isSingleClick.value,
					mAvoidBackProbability = avoidBackProbability.value
				});
			}
			f.Call(output);
		});
	}
}
