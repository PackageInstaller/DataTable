using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("重置普攻段数(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("重置普攻段数")]
public class ResetAttackIndex : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionAbility)
			{
				_Error.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.meleeIndex = 0;
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", () => _EntityIDInput.GetValue());
	}
}
