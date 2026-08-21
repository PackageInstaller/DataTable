using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI执行闪避指令", 0)]
[Category("Logic/AI")]
[Description("AI闪避指令")]
public class AIDoAvoidAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			if (!simEntity.entityAIThink.mAICommandSet.TryGetValue(actionID.value, out var _))
			{
				AIAvoidCommand value2 = new AIAvoidCommand
				{
					mParent = null,
					mID = actionID.value,
					mTimeout = timeout.value
				};
				simEntity.entityAIThink.mAICommandSet[actionID.value] = value2;
			}
			simEntity.entityAIThink.mInterruptCommand = simEntity.entityAIThink.mAICommandSet[actionID.value];
			f.Call(output);
		});
	}
}
