using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置奥义每跳增量(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("设置奥义每跳增量")]
public class SetUniqueSkillEnergyAddValue : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _NewValueInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_NewValueInput = AddValueInput<int>("新值", "addValue");
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
				entityWithEntityID.entityUniqueSkillEnergy.mAddValue = _NewValueInput.GetValue();
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
