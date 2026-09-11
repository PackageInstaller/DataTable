using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("变身", 0)]
[Category("Logic/Abilities")]
[Description("变身")]
public class Transfiguration : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		ValueInput<int> entityIDInput = AddValueInput<int>("entityID");
		ValueInput<int> transformRoleIDInput = AddValueInput<int>("transformRoleID");
		ValueInput<int> actionIDInput = AddValueInput<int>("出场动作ID");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionTransfiguration)
			{
				entityWithEntityID.AddEntityActionTransfiguration(transformRoleIDInput.value, actionIDInput.value);
			}
			output.Call(f);
		});
	}
}
