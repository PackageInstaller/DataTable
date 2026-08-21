using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI通用怪物对峙指令", 0)]
[Category("Logic/AI")]
[Description("AI通用怪物对峙指令")]
public class AIMonsterStalemateAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("对峙ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<int> moveTimeInput = AddValueInput<int>("移动时间");
		ValueInput<int> speedFactorInput = AddValueInput<int>("速度百分比");
		ValueInput<int> minWaitTimeInput = AddValueInput<int>("最小停步时间");
		ValueInput<int> deltaProbabilityInput = AddValueInput<int>("移动概率增量");
		ValueInput<Int> startAngleInput = AddValueInput<Int>("起始角度");
		ValueInput<Int> endAngleInput = AddValueInput<Int>("结束角度");
		ValueInput<int> intervalInput = AddValueInput<int>("判定间隔").SetDefaultAndSerializedValue(1000);
		AddFlowOutput("移动中");
		AddFlowOutput("待机中");
		AddFlowInput("", delegate(Flow f)
		{
			if (((SimEntity)f.userData).entityAIThink.mAICommandSet.TryGetValue(commandSetID.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				if (aICommandSet.mCommands == null)
				{
					aICommandSet.mCommands = new List<AICommand>();
				}
				aICommandSet.mCommands.Add(new AIMonsterStalemateCommand
				{
					mParent = aICommandSet,
					mID = actionID.value,
					mTimeout = timeout.value,
					moveTimeInput = moveTimeInput.value,
					speedFactorInput = speedFactorInput.value,
					minWaitTimeInput = minWaitTimeInput.value,
					deltaProbabilityInput = deltaProbabilityInput.value,
					startAngleInput = startAngleInput.value.i,
					endAngleInput = endAngleInput.value.i,
					intervalInput = intervalInput.value
				});
			}
		});
	}
}
