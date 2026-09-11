using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断实体间距离", 0)]
[Category("Logic/PosAndRot")]
[Description("判断实体间距离")]
public class IsTargetInRange : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体1ID");
		ValueInput<int> entityID2Input = AddValueInput<int>("实体2ID");
		ValueInput<int> rangeInput = AddValueInput<int>("范围");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput errorOut = AddFlowOutput("Error", "errorOut");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(entityID2Input.value);
			if (entityWithEntityID == null || entityWithEntityID2 == null)
			{
				errorOut.Call(f);
			}
			else
			{
				AIProcessor.GetNearestCollisionData(entityWithEntityID, entityWithEntityID2, entityWithEntityID2.entityCamp.mRoleTypeCamp, out var minDistance);
				if (minDistance < rangeInput.value)
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
