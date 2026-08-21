using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI替换闪避指令", 0)]
[Category("Logic/AI")]
[Description("AI替换闪避指令")]
public class AIReplaceAvoidCammand : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> stepInput = AddValueInput<int>("步骤");
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<bool> isSingleClick = AddValueInput<bool>("是否单次点击", "isSingleClick").SetDefaultAndSerializedValue(v: false);
		ValueInput<int> avoidBackProbability = AddValueInput<int>("非移动闪避概率(百分比)", "avoidBackProbability").SetDefaultAndSerializedValue(0);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (((SimEntity)f.userData).entityAIThink.mAICommandSet.TryGetValue(commandSetID.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				int value2 = stepInput.value;
				AIAvoidCommand obj = (AIAvoidCommand)aICommandSet.mCommands[value2];
				obj.mParent = aICommandSet;
				obj.mID = actionID.value;
				obj.mTimeout = timeout.value;
				obj.mIsSingleClick = isSingleClick.value;
				obj.mAvoidBackProbability = avoidBackProbability.value;
			}
			f.Call(output);
		});
	}
}
