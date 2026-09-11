using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能CD激活", 0)]
[Category("Logic/芯片技能")]
[Description("激活芯片技能的CD，使其进入冷却状态")]
public class EnableMasterSkillCD : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityMasterSkill)
			{
				errorOut.Call(f);
			}
			else
			{
				EntityMasterSkill entityMasterSkill = entityWithEntityID.entityMasterSkill;
				entityMasterSkill.mCD = entityMasterSkill.mMaxCD;
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
