using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("奥义释放成功(逻辑)", 0)]
[Category("Logic/QTE")]
[Description("将奥义的能量清0")]
public class UniqueSkillExecuteSuccess : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

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
				entityWithEntityID.entityUniqueSkillEnergy.mValue = 0;
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
