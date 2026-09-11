using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置奥义能量和上限(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("设置奥义能量值")]
public class SetUniqueSkillEnergyValueAndUpperLimit : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _NewValueInput;

	private ValueInput<int> _NewUpperLimitInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_NewValueInput = AddValueInput<int>("新值", "addValue");
		_NewUpperLimitInput = AddValueInput<int>("上限", "uppperLimit");
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
				entityUniqueSkillEnergy.mValue = _NewValueInput.GetValue();
				entityUniqueSkillEnergy.mMaxValue = _NewUpperLimitInput.GetValue();
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
