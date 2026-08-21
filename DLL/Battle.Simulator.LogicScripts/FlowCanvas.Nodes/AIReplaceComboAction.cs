using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI替换指令", 0)]
[Category("Logic/AI")]
[Description("AI替换连招指令")]
public class AIReplaceComboAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> actionStep = AddValueInput<int>("步骤");
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("动作ID");
		ValueInput<int> actionBeginFrame = AddValueInput<int>("起始帧数");
		ValueInput<int> actionEndFrame = AddValueInput<int>("结束帧数");
		ValueInput<int> actionLoopCount = AddValueInput<int>("循环次数").SetDefaultAndSerializedValue(1);
		ValueInput<int> actionTimeout = AddValueInput<int>("超时时间").SetDefaultAndSerializedValue(10000);
		ValueInput<int> actionRange = AddValueInput<int>("接近范围距离");
		ValueInput<int> actionSpeed = AddValueInput<int>("接近速度百分比").SetDefaultAndSerializedValue(100);
		ValueInput<bool> actionDisableApproach = AddValueInput<bool>("原地释放").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> actionInterrupt = AddValueInput<bool>("强制打断当前动作").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> edgeDistanceInput = AddValueInput<bool>("使用边界距离").SetDefaultAndSerializedValue(v: true);
		AddValueOutput("动作ID", () => actionID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			int num = actionEndFrame.value;
			if (num == 0)
			{
				RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(roleConfig.ID * 1000 + actionID.value);
				num = config.Duration / config.TICKINTERVAL;
			}
			int num2 = actionTimeout.value;
			if (num2 == 0)
			{
				num2 = 10000;
			}
			if (simEntity.entityAIThink.mAICommandSet.TryGetValue(commandSetID.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				int value2 = actionStep.value;
				AIAbilityCommand obj = (AIAbilityCommand)aICommandSet.mCommands[value2];
				obj.mParent = aICommandSet;
				obj.mID = actionID.value;
				obj.mBeginFrame = actionBeginFrame.value;
				obj.mEndFrame = num;
				obj.mTimeout = num2;
				obj.mRange = actionRange.value;
				obj.mApproachSpeed = actionSpeed.value;
				obj.mDisableApproach = actionDisableApproach.value;
				obj.mForceInterruptAbility = actionInterrupt.value;
				obj.mLoop = actionLoopCount.value;
				obj.mUseEdgeDistance = edgeDistanceInput.value;
			}
			f.Call(output);
		});
	}
}
