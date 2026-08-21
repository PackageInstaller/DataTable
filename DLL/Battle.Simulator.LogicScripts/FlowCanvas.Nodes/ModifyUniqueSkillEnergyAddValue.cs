using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改奥义每跳增量(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("修改奥义每跳增量，没有考虑属性")]
public class ModifyUniqueSkillEnergyAddValue : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _AddValueInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_AddValueInput = AddValueInput<int>("增量", "addValue");
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
				entityWithEntityID.entityUniqueSkillEnergy.mAddValue += _AddValueInput.GetValue();
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
