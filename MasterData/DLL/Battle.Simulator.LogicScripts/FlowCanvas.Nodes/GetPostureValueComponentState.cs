using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否破防中", 0)]
[Category("Logic/Attribute")]
[Description("是否破防中")]
public class GetPostureValueComponentState : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		int res = 0;
		AddValueOutput("剩余值", () => res);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityPostureValue)
			{
				errorOut.Call(f);
			}
			else
			{
				res = entityWithEntityID.entityPostureValue.value;
				if (entityWithEntityID.entityPostureValue.state == BreakState.breakState)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
