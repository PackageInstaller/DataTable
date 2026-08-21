using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("两个Entity之间是直有遮挡", 0)]
[Category("Logic/Abilities")]
[Description("通过射线判断两个Entity之间是直有遮挡")]
public class CanRaycastEntity : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<int> srcEntityIDVar = AddValueInput<int>("SrcEntityID");
		ValueInput<int> destEntityIDVar = AddValueInput<int>("DestEntityID");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(srcEntityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(destEntityIDVar.GetValue());
				GraphHitInfo hitInfo;
				if (entityWithEntityID2 == null)
				{
					errorOut.Call(f);
				}
				else if (!PathUtilities.Linecast(entityWithEntityID2.entityPositon.mPosition, entityWithEntityID.entityPositon.mPosition, null, out hitInfo))
				{
					falseOut.Call(f);
				}
				else
				{
					trueOut.Call(f);
				}
			}
		});
	}
}
