using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能CD修改", 0)]
[Category("Logic/芯片技能")]
[Description("芯片技能更新逻辑")]
public class MasterSkillUpdateCD : FlowNode
{
	private int OperatorValue(OperationMethod op, int origin, int opValue)
	{
		return op switch
		{
			OperationMethod.Set => opValue, 
			OperationMethod.Add => origin + opValue, 
			OperationMethod.Subtract => origin - opValue, 
			OperationMethod.Multiply => origin * opValue, 
			OperationMethod.Divide => origin / opValue, 
			_ => origin, 
		};
	}

	public void UpdateLogic(SimContext simContext, int entityID, int delta, OperationMethod pOperationMethod)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityMasterSkill)
		{
			return;
		}
		EntityMasterSkill entityMasterSkill = entityWithEntityID.entityMasterSkill;
		entityMasterSkill.mCD = OperatorValue(pOperationMethod, entityMasterSkill.mCD, delta);
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
		ValueInput<OperationMethod> operationInput = AddValueInput<OperationMethod>("操作符", "operation");
		ValueInput<int> deltaValueInput = AddValueInput<int>("变化值");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			UpdateLogic(base.graph.mSimContext, entityIDInput.value, deltaValueInput.value, operationInput.value);
			f.Call(output);
		});
	}
}
