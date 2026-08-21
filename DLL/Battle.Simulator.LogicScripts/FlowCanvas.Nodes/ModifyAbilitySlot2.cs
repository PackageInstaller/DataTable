using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改技能槽(看备注)", 0)]
[Category("Logic/Abilities")]
[Description("用于修改技能（仅skill1/2/3有效），整合了对应槽判断，相同ID不修改并且不发事件的功能\n修改成功后会发送【技能槽切换事件】")]
public class ModifyAbilitySlot2 : FlowControlNodeOfLogic
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<ButtonType> _buttonTypeInput;

	private ValueInput<int> _abilityIDInput;

	private FlowOutput _succeedOut;

	private FlowOutput _sameOut;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_buttonTypeInput = AddValueInput<ButtonType>("按钮类型", "buttonType");
		_abilityIDInput = AddValueInput<int>("AbilityID", "abilityID");
		_succeedOut = AddFlowOutput("修改成功", "succeed");
		_sameOut = AddFlowOutput("相同不处理", "sample");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				_errorOut.Call(f);
			}
			else
			{
				int value = (int)_buttonTypeInput.value;
				if (value >= entityWithEntityID.entityBlackboard.var.mAbilitySlots.Length)
				{
					_errorOut.Call(f);
				}
				else
				{
					int num = entityWithEntityID.entityBlackboard.var.mAbilitySlots[value];
					if (num == _abilityIDInput.value)
					{
						_sameOut.Call(f);
					}
					else
					{
						entityWithEntityID.entityBlackboard.var.mAbilitySlots[value] = _abilityIDInput.value;
						base.graph.mSimContext.GetSimInterface().mAbilitySlotsChangeEvent?.Invoke(entityWithEntityID.creationIndex, value, num, entityWithEntityID.entityBlackboard.var.mAbilitySlots[value]);
						_succeedOut.Call(f);
					}
				}
			}
		});
	}
}
