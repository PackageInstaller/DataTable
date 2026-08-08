using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]随机选取CD中技能并修改", 0)]
[Category("Logic/Attribute")]
[Description("随机选取CD中技能并修改，会刷新AbilityConfig表中记录的同步CD的技能的CD")]
public class RandomModifyAbilityCD : RandomRefreshAbilityCD
{
	private ValueInput<int> _modifyCDValueInput;

	private ValueInput<OperationMethod> _operatorMethodInput;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_modifyCDValueInput = AddValueInput<int>("CD变化值", "ModifyCDValue");
		_operatorMethodInput = AddValueInput<OperationMethod>("操作", "OperationMethod");
	}

	protected override void OnProcessAbility(SimEntity simEntity, AbilityCD abilityCD)
	{
		switch (_operatorMethodInput.value)
		{
		case OperationMethod.Set:
			CDProcessor.SetCD(simEntity, abilityCD.AbilityID, _modifyCDValueInput.value, abilityCD.UsedCount);
			break;
		case OperationMethod.Add:
			CDProcessor.SetCD(simEntity, abilityCD.AbilityID, abilityCD.CD + _modifyCDValueInput.value, abilityCD.UsedCount);
			break;
		case OperationMethod.Subtract:
			CDProcessor.SetCD(simEntity, abilityCD.AbilityID, abilityCD.CD - _modifyCDValueInput.value, abilityCD.UsedCount);
			break;
		case OperationMethod.Multiply:
			CDProcessor.SetCD(simEntity, abilityCD.AbilityID, abilityCD.CD * _modifyCDValueInput.value, abilityCD.UsedCount);
			break;
		case OperationMethod.Divide:
			CDProcessor.SetCD(simEntity, abilityCD.AbilityID, abilityCD.CD / _modifyCDValueInput.value, abilityCD.UsedCount);
			break;
		}
	}
}
