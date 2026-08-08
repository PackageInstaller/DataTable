using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("循环执行技能", 0)]
[Category("Logic/Abilities")]
[Description("循环执行技能,只能在有技能执行的时候使用")]
public class LoopAbilityNode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> maxTimesInput = AddValueInput<int>("循环次数");
		ValueInput<int> abilityIDInput = AddValueInput<int>("循环执行的技能ID");
		FlowOutput output = AddFlowOutput("循环结束");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2203, out var baseValue, out var _, out var _);
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID);
			if (entityWithEntityID.entityActionAbility.mLogicTime + 2 * CommonProcessor.GetConfigInterval() >= config.Duration)
			{
				if (baseValue < maxTimesInput.value)
				{
					baseValue++;
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2203, baseValue, 0L, 0L);
					AbilitiesProcessor.SetNextFrameAbility(entityWithEntityID, abilityIDInput.value, forceBroken: true);
				}
				else
				{
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2203, 0L, 0L, 0L);
					output.Call(f);
				}
			}
		});
	}
}
