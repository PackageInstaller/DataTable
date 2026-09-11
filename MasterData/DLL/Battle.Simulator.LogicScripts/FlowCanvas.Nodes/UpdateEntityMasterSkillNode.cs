using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能更新逻辑", 0)]
[Category("Logic/芯片技能")]
[Description("芯片技能更新逻辑")]
public class UpdateEntityMasterSkillNode : FlowNode
{
	public static void UpdateLogic(SimContext simContext, int entityID)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityMasterSkill)
		{
			return;
		}
		EntityMasterSkill entityMasterSkill = entityWithEntityID.entityMasterSkill;
		if (entityMasterSkill.mCD <= 0)
		{
			return;
		}
		entityMasterSkill.mCD -= CommonProcessor.GetLogicConstTick();
		entityMasterSkill.mCD = IntMath.Clamp(entityMasterSkill.mCD, 0, entityMasterSkill.mMaxCD);
		if (entityMasterSkill.mCD <= 0)
		{
			if (entityMasterSkill.mState != EntityActionStatus.E_ACTIVE)
			{
				simContext.GetSimInterface().mEntityMasterSkillPreparedEvent?.Invoke(entityID);
				entityMasterSkill.mState = EntityActionStatus.E_ACTIVE;
			}
		}
		else if (entityMasterSkill.mState == EntityActionStatus.E_ACTIVE)
		{
			entityMasterSkill.mState = EntityActionStatus.None;
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			UpdateLogic(base.graph.mSimContext, entityIDInput.value);
			f.Call(output);
		});
	}
}
