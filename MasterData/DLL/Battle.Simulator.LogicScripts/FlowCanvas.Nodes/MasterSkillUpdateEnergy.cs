using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能能量修改", 0)]
[Category("Logic/芯片技能")]
[Description("芯片技能更新逻辑")]
public class MasterSkillUpdateEnergy : FlowNode
{
	public static void UpdateLogic(SimContext simContext, int entityID, int delta)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityMasterSkill)
		{
			EntityMasterSkill entityMasterSkill = entityWithEntityID.entityMasterSkill;
			entityMasterSkill.mValue += delta;
			entityMasterSkill.mValue = IntMath.Clamp(entityMasterSkill.mValue, 0, entityMasterSkill.mMaxValue);
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> deltaValueInput = AddValueInput<int>("变化值");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			UpdateLogic(base.graph.mSimContext, entityIDInput.value, deltaValueInput.value);
			f.Call(output);
		});
	}
}
