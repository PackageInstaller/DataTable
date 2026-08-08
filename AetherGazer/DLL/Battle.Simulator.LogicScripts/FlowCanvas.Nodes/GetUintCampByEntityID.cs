using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断阵营(通过EntityID)", 0)]
[Category("Logic/Config")]
[Description("判断输入的entityID判断是哪一方")]
public class GetUintCampByEntityID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("EntityID");
		AddValueOutput("EntityID", () => entityID.value);
		FlowOutput enemyOut = AddFlowOutput("敌方阵营");
		FlowOutput playerOut = AddFlowOutput("玩家阵营");
		FlowOutput other = AddFlowOutput("其他阵营");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = entityID.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityCamp)
			{
				uint mRoleTypeCamp = entityWithEntityID.entityCamp.mRoleTypeCamp;
				if (RoleCampProcessor.IsEnemy(mRoleTypeCamp))
				{
					enemyOut.Call(f);
				}
				else if (RoleCampProcessor.IsPlayer(mRoleTypeCamp))
				{
					playerOut.Call(f);
				}
				else
				{
					other.Call(f);
				}
			}
			else
			{
				errorOut.Call(f);
			}
		});
	}
}
