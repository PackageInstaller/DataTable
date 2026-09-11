using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能CD及上限设置", 0)]
[Category("Logic/芯片技能")]
[Description("芯片技能更新逻辑")]
public class MasterSkillUpdateCDAndMaxCD : FlowNode
{
	public void UpdateLogic(SimContext simContext, int entityID, int delta, int maxValue)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityMasterSkill)
		{
			EntityMasterSkill entityMasterSkill = entityWithEntityID.entityMasterSkill;
			entityMasterSkill.mCD = delta;
			entityMasterSkill.mConsumeCD = maxValue;
			entityMasterSkill.mMaxCD = maxValue;
			entityMasterSkill.mCD = IntMath.Clamp(entityMasterSkill.mCD, 0, entityMasterSkill.mMaxCD);
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> deltaValueInput = AddValueInput<int>("变化值");
		ValueInput<int> maxValueInput = AddValueInput<int>("上限值", "maxValue");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			UpdateLogic(base.graph.mSimContext, entityIDInput.value, deltaValueInput.value, maxValueInput.value);
			f.Call(output);
		});
	}
}
