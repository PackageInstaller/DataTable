using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到奥义每跳增量(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("得到奥义每跳增量")]
public class GetUniqueSkillEnergyAddValue : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private int _AddValueOfValue;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
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
				_AddValueOfValue = entityUniqueSkillEnergy.mAddValue;
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
		AddValueOutput("每跳增量", "addValueOfTick", () => _AddValueOfValue);
	}
}
