using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中修改破防值", 0)]
[Category("Logic/Attribute")]
[Description("命中修改破防值")]
public class HitAddBreakValue : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID");
		ValueInput<int> timelineIDInput = AddValueInput<int>("TimelineID");
		ValueInput<int> hitIndexInput = AddValueInput<int>("HitIndex");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
			ConfigHelper.GetInstance().TryGetConfig<public_skill>(timelineIDInput.value, out var config);
			int value = hitIndexInput.value;
			if (entityWithEntityID != null && entityWithEntityID.hasEntityPostureValue && config != null && config.BreakValueConsume.Count > value)
			{
				if (entityWithEntityID.entityPostureValue.state == BreakState.breakCDState || entityWithEntityID.entityPostureValue.state == BreakState.breakState)
				{
					output.Call(f);
					return;
				}
				entityWithEntityID.entityPostureValue.curTime = entityWithEntityID.entityPostureValue.delayTime;
				entityWithEntityID.entityPostureValue.state = BreakState.delay;
				if (entityWithEntityID.entityPostureValue.cantBreakFlag != 0)
				{
					output.Call(f);
					return;
				}
				entityWithEntityID.entityPostureValue.value -= config.BreakValueConsume.get_Item(value);
			}
			output.Call(f);
		});
	}
}
