using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[修正模式]实体是否抗拒进入", 0)]
[Category("Logic/修正模式")]
[Description("实体是否抗拒进入修正模式")]
public class IsResistEnterSourceSpace : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput resistedOut = AddFlowOutput("抗拒", "resisted");
		FlowOutput unresistedOut = AddFlowOutput("不抗拒", "unresisted");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityExposedValue)
			{
				errorOut.Call(f);
			}
			else if (entityWithEntityID.entityExposedValue.mResistEnter != 0)
			{
				resistedOut.Call(f);
			}
			else
			{
				unresistedOut.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
