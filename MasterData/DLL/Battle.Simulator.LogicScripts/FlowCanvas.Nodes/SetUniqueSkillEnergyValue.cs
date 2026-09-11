using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置奥义能量(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("设置奥义能量值,不考虑属性加成, 最大值的千分之 + 增量")]
public class SetUniqueSkillEnergyValue : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _NewValueInput;

	private ValueInput<int> _permill;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_NewValueInput = AddValueInput<int>("新值", "addValue");
		_permill = AddValueInput<int>("千分之", "permill");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityUniqueSkillEnergy)
			{
				_Error.Call(f);
			}
			else
			{
				EntityUniqueSkillEnergy entityUniqueSkillEnergy = entityWithEntityID.entityUniqueSkillEnergy;
				entityUniqueSkillEnergy.mValue = IntMath.Divide(entityUniqueSkillEnergy.mMaxValue * _permill.value, 1000) + _NewValueInput.GetValue();
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
