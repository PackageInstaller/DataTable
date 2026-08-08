using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置奥义能量组件激活状态(逻辑)", 0)]
[Category("Logic/QTE")]
[Description("Error:实体不存在、无奥义能量组件\n")]
public class SetActiveOfUniqueSkillEnergyStatus : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<EntityActionStatus> _entityActionStatusInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_entityActionStatusInput = AddValueInput<EntityActionStatus>("状态", "entityActionStatus").SetDefaultAndSerializedValue(EntityActionStatus.E_ACTIVE);
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityUniqueSkillEnergy)
			{
				_errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityUniqueSkillEnergy.mState = _entityActionStatusInput.value;
				_output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
	}
}
