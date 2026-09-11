using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是奥义(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("如题")]
public class IsUniqueSkillAbility : FlowNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _AbilityIDInput;

	private ValueInput<bool> _AttentionFirstInput;

	private FlowOutput _True;

	private FlowOutput _Flase;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "EntityID");
		_AbilityIDInput = AddValueInput<int>("AbilityID", "AbilityID");
		_AttentionFirstInput = AddValueInput<bool>("只关注起手", "attentionFirstInput");
		_True = AddFlowOutput("True", "true");
		_Flase = AddFlowOutput("False", "false");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("IN", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				_Error.Call(f);
			}
			if (CommonProcessor.IsInUniqueSkillABility(entityWithEntityID, _AbilityIDInput.GetValue(), _AttentionFirstInput.GetValue()))
			{
				_True.Call(f);
			}
			else
			{
				_Flase.Call(f);
			}
		});
		AddValueOutput("EntityID", "EntityID", () => _EntityIDInput.GetValue());
		AddValueOutput("AbilityID", "AbilityID", () => _AbilityIDInput.GetValue());
	}
}
