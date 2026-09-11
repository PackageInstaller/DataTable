using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("数次循环", 0)]
[Category("Logic/Abilities")]
[Description("在区间内循环n次,技能结束的那一帧会自动调用reset")]
public class LoopNTimes : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("entityID");
		ValueInput<int> beginFrameInput = AddValueInput<int>("beginFrame");
		ValueInput<int> endFrameInput = AddValueInput<int>("endFrame");
		ValueInput<int> maxTimesInput = AddValueInput<int>("n");
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput onReset = AddFlowOutput("OnReset");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2203, out var baseValue, out var _, out var _);
			if (baseValue < maxTimesInput.value && entityWithEntityID.entityActionAbility.mLogicTime >= (endFrameInput.value + 1) * CommonProcessor.GetConfigInterval())
			{
				int value = beginFrameInput.value;
				entityWithEntityID.entityActionAbility.mLogicTime = value * CommonProcessor.GetConfigInterval();
				baseValue++;
			}
			else
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID);
				if (config != null && entityWithEntityID.entityActionAbility.mLogicTime >= config.Duration + 33)
				{
					baseValue = 1L;
					onReset.Call(f);
				}
			}
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2203, baseValue, 0L, 0L);
			output.Call(f);
		});
		AddFlowInput("Reset", delegate(Flow f)
		{
			AttributeProcessor.SetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), 2203, 1L, 0L, 0L);
			onReset.Call(f);
		});
	}
}
