using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("闪避是否在CD中", 0)]
[Category("Logic/Abilities")]
[Description("闪避是否在CD中")]
public class AvoidIsInCD : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID);
			if (CDProcessor.InCD(entityWithEntityID, config.AvoidAbility.get_Item(0)))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
