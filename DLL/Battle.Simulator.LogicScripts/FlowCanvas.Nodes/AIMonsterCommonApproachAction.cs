using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI通用怪物追击指令", 0)]
[Category("Logic/AI")]
[Description("AI通用怪物追击指令")]
public class AIMonsterCommonApproachAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<int> originInput = AddValueInput<int>("移动初始概率");
		ValueInput<int> delayIncrementTimeInput = AddValueInput<int>("延时概率增加时间");
		ValueInput<int> incrementInput = AddValueInput<int>("概率增量");
		ValueInput<int> incrementIntervalInput = AddValueInput<int>("概率增加间隔");
		ValueInput<int> resetTimeInput = AddValueInput<int>("概率重置时间");
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
				aICommandSet.mCommands.Add(new AIMonsterCommonApproachCommand
				{
					mParent = aICommandSet,
					mID = actionID.value,
					mTimeout = timeout.value,
					originInput = originInput.value,
					delayIncrementTimeInput = delayIncrementTimeInput.value,
					incrementInput = incrementInput.value,
					incrementIntervalInput = incrementIntervalInput.value,
					resetTimeInput = resetTimeInput.value
				});
			}
			f.Call(output);
		});
	}
}
