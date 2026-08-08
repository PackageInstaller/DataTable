using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI队友跟随指令", 0)]
[Category("Logic/AI")]
[Description("AI队友跟随指令")]
public class AIFollowPlayerCommand : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<int> followDistanceBasePartInput = AddValueInput<int>("跟随距离基础值");
		ValueInput<int> followDistanceRandomPtInput = AddValueInput<int>("跟随距离随机值");
		ValueInput<int> lerpMinDistanceInput = AddValueInput<int>("插值距离最小值");
		ValueInput<int> lerpMaxDistanceInput = AddValueInput<int>("插值距离最大值");
		ValueInput<int> speedFactorMiniInput = AddValueInput<int>("最小速度阈值");
		ValueInput<int> speedFactorMaxiInput = AddValueInput<int>("最大速度阈值");
		ValueInput<Int> followOffsetAngleInput = AddValueInput<Int>("偏移角度").SetDefaultAndSerializedValue(120000);
		ValueInput<int> followOffsetDistanceInput = AddValueInput<int>("偏移距离");
		ValueInput<int> startMoveDistanceInput = AddValueInput<int>("开始移动的距离阈值");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity obj = (SimEntity)f.userData;
			int value = commandSetID.value;
			if (obj.entityAIThink.mAICommandSet.TryGetValue(value, out var value2))
			{
				AICommandSet aICommandSet = (AICommandSet)value2;
				if (aICommandSet.mCommands == null)
				{
					aICommandSet.mCommands = new List<AICommand>();
				}
				aICommandSet.mCommands.Add(new AIFollowTargetCommand
				{
					mParent = aICommandSet,
					mID = actionID.value,
					mTimeout = timeout.value,
					mDisanceBase = followDistanceBasePartInput.value,
					mDistanceRandomOffset = followDistanceRandomPtInput.value,
					mLerpMinDistance = lerpMinDistanceInput.value,
					mLerpMaxDistance = lerpMaxDistanceInput.value,
					mSpeedFactorMini = speedFactorMiniInput.value,
					mSpeedFactorMaxi = speedFactorMaxiInput.value,
					mFollowOffsetAngleInput = followOffsetAngleInput.value.i,
					mFollowOffsetDistanceInput = followOffsetDistanceInput.value,
					mStartMoveDistanceInput = startMoveDistanceInput.value
				});
			}
			f.Call(output);
		});
	}
}
