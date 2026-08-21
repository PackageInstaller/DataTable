using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("能否释放奥义(单体)(逻辑)", 0)]
[Category("Logic/QTE")]
[Description("Error:实体不存在、无奥义能量组件、实体无对应的奥义技能ID\n不可释放:奥义能量未满、奥义技能被禁用、奥义技能处于CD状态\n")]
public class CanExecuteUniqueSkill : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private FlowOutput _true;

	private FlowOutput _false;

	private FlowOutput _error;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_true = AddFlowOutput("可以释放", "true");
		_false = AddFlowOutput("不可释放", "false");
		_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.GetValue());
			UniqueSkill config;
			AbilityCD abilityCD;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityUniqueSkillEnergy)
			{
				_error.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.entityConfig.mId, out config))
			{
				_error.Call(f);
			}
			else if (entityWithEntityID.entityUniqueSkillEnergy.mValue < entityWithEntityID.entityUniqueSkillEnergy.mMaxValue)
			{
				_false.Call(f);
			}
			else if (!AttributeProcessor.IsEnableAbility(entityWithEntityID, config.AbilityId.get_Item(0)))
			{
				_false.Call(f);
			}
			else if (CDProcessor.GetCD(entityWithEntityID, config.AbilityId.get_Item(0), out abilityCD) && abilityCD.CD > 0)
			{
				_false.Call(f);
			}
			else
			{
				_true.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.GetValue());
	}
}
